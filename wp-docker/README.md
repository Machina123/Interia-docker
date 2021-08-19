## wp-docker

This folder contains necessary Docker files to create and start replicated Wordpress service complete with database, caching and SSL/TLS termination.

### Warning

This repository contains self-signed TLS certificate *(for testing purposes only!)* and should be replaced with valid certificate in production environment.

### Setup

To start the service, `docker-compose up -d` should do the trick.