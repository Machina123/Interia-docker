vcl 4.0;

// import directors;
import dynamic;

backend default none;

probe backend_probe {
    .request =
    "HEAD /healthprobe.php HTTP/1.1"
    "Host: localhost"
    "Connection: close"
    "User-Agent: Varnish Health Probe";    
    # co jaki czas jest wysylany GET - co 10s
    .interval = 10s;
    # jezeli zajmuje to wiecej niz 5s - blad
    .timeout = 5 s;
    # jezeli w 5 probach 3 zakonczyly sie sukcesem, server jest healthy
    .window = 5;
    .threshold = 3;
    .expected_response = 204;
}

sub vcl_init {
    new all_wordpress = dynamic.director(
        probe = backend_probe,
        ttl = 5m,
        connect_timeout = 10s
    );
    // all_wordpress.debug(true);
}

sub vcl_backend_fetch {
    set bereq.backend = all_wordpress.backend("wpfront", port="8080");
    return (fetch);
}

sub vcl_recv {
    # Only cache GET or HEAD requests. This makes sure the POST requests are always passed.
    if (req.method != "GET" && req.method != "HEAD") {
        return (pass);
    }
    
    if (req.url ~ "wp-admin|wp-login") {
        return (pass);
    }

    set req.http.cookie = regsuball(req.http.cookie, "wp-settings-\d+=[^;]+(; )?", "");
    set req.http.cookie = regsuball(req.http.cookie, "wp-settings-time-\d+=[^;]+(; )?", "");
    set req.http.cookie = regsuball(req.http.cookie, "wordpress_test_cookie=[^;]+(; )?", "");
    if (req.http.cookie == "") {
        unset req.http.cookie;
    }
}

sub vcl_backend_response {
    set beresp.ttl = 600s;
    set beresp.grace = 3600s;

    if (bereq.url ~ "^[^?]*\.(7z|avi|bmp|bz2|css|csv|doc|docx|eot|flac|flv|gif|gz|ico|jpeg|jpg|js|less|mka|mkv|mov|mp3|mp4|mpeg|mpg|odt|otf|ogg|ogm|opus|pdf|png|ppt|pptx|rar|rtf|svg|svgz|swf|tar|tbz|tgz|ttf|txt|txz|wav|webm|webp|woff|woff2|xls|xlsx|xml|xz|zip)(\?.*)?$") {
      unset beresp.http.set-cookie;
    }
    return (deliver);
}

sub vcl_deliver {
    unset resp.http.X-Varnish;
    unset resp.http.Via;
    unset resp.http.Age;
    unset resp.http.X-Powered-By;
    unset resp.http.Server;
    set resp.http.Server = "Wordpress_PC";
    unset resp.http.X-Cacheable;       
    unset resp.http.Pragma;
}
