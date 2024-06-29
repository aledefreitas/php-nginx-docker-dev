# syntax = edrevo/dockerfile-plus

ARG PHP_IMAGE=php:8.3-fpm-alpine

FROM ${PHP_IMAGE} AS build

INCLUDE+ ./dockerfiles/nginx.Dockerfile
INCLUDE+ ./dockerfiles/app.Dockerfile
INCLUDE+ ./dockerfiles/php.Dockerfile
INCLUDE+ ./dockerfiles/config.Dockerfile
INCLUDE+ ./dockerfiles/cleanup.Dockerfile

EXPOSE 80

CMD ["/usr/bin/supervisord", "-n"];

## DEVELOPMENT IMAGE
FROM build AS dev

RUN pecl install xdebug-3.3.2 \
    && docker-php-ext-enable xdebug

ENV OPCACHE_ENABLED 0
ENV PHP_DISPLAY_ERRORS 1
ENV PHP_DISPLAY_STARTUP_ERRORS 1
ENV APP_DEBUG 1

EXPOSE 9003

## PRODUCTION IMAGE
FROM build AS prod

ENV OPCACHE_ENABLED 1

## STAGING IMAGE COPIES PROD
FROM prod AS staging