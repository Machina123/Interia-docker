from locust import HttpUser, task
from locust.user.wait_time import between

import os, logging
logger = logging.getLogger(__name__)
logger.setLevel(os.environ.get('LOCUST_LOG_LEVEL', 'INFO').upper())


class Task1User(HttpUser):
    wait_time = between(0.5, 1.0)

    def on_start(self):
        self.client.headers = {'User-Agent': 'Interia Benchmark - Locust.io'}
        
    @task
    def hello(self):
        self.client.get("/")
