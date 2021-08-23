<?php
// https://gist.github.com/msdousti/b98f225512bd21ba23caebc5548f4678
ob_start();

header("HTTP/1.1 204 NO CONTENT");

header("Cache-Control: no-cache, no-store, must-revalidate"); // HTTP 1.1.
header("Pragma: no-cache"); // HTTP 1.0.
header("Expires: 0"); // Proxies.

ob_end_flush(); //now the headers are sent