from locust import HttpUser, task
from locust import __version__ as locust_version
from locust.user.wait_time import between

import os, logging
logger = logging.getLogger(__name__)
logger.setLevel(os.environ.get('LOCUST_LOG_LEVEL', 'INFO').upper())

STATIC_CONTENT_URLS = [
    ("/wp-content/uploads/2021/09/pexels-vraj-shah-638479.jpg", "IMAGE"),
    ("/wp-content/themes/twentytwentyone/assets/images/roses-tremieres-hollyhocks-1884.jpg", "IMAGE"),
    ("/wp-content/themes/twentytwentyone/style.css", "STYLE"),
    ("/wp-content/themes/twentytwentyone/assets/js/responsive-embeds.js", "SCRIPT"),
    ("/wp-content/themes/twentytwentyone/assets/js/primary-navigation.js", "SCRIPT"),
    ("/wp-includes/js/wp-embed.min.js", "SCRIPT")
]

HEADERS_BASE = {
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Accept-Language": "en-US,en;q=0.9,pl;q=0.8",
    "Connection": "keep-alive",
    "Host": "patryk.staz.inpl.work",
    "Referer": "https://patryk.staz.inpl.work/",
    "User-Agent": f"Locust/{locust_version}"
}

HEADERS_IMAGES = HEADERS_BASE.copy()
HEADERS_IMAGES["Accept"] = "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8"

HEADERS_STYLE = HEADERS_BASE.copy()
HEADERS_STYLE["Accept"] = "text/css,*/*;q=0.1"

HEADERS = {
    "IMAGE": HEADERS_IMAGES,
    "STYLE": HEADERS_STYLE,
    "SCRIPT": HEADERS_BASE
}

class Task3User(HttpUser):
    wait_time = between(0.5, 1.0)

    def on_start(self):
        self.client.headers = HEADERS_BASE

    @task(5)
    def get_home(self):
        r = self.client.get("/")
        logger.info(r.request.headers)

    @task(3)
    def get_static_content(self):
        for (url, ctype) in STATIC_CONTENT_URLS:
            self.client.get(url, name=f"GET_STATIC_{ctype}", headers=HEADERS[ctype])

    @task(2)
    def get_page(self):
        self.client.get("/?page_id=6", name="GET_PAGE")
    
    @task(2)
    def get_search(self):
        self.client.get("/?s=lorem", name="GET_SEARCH")

    @task(1)
    def get_tag(self):
        self.client.get("/?tag=supercars", name="GET_TAG")