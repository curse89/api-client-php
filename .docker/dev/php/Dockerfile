FROM php:8.0-fpm-alpine3.13

ARG NEED_DEBUG

RUN curl -L https://getcomposer.org/download/2.2.10/composer.phar -o /usr/bin/composer && chmod a+x /usr/bin/composer

RUN apk --update add \
    autoconf \
    gcc \
    git \
    jq \
    libc-dev \
    libxml2-dev \
    libzip-dev \
    make \
    postgresql-dev \
    shadow \
    tzdata \
    && docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install pgsql pdo_pgsql bcmath intl sockets zip \
    && docker-php-ext-enable opcache \
    && rm -rf /var/cache/apk/* && rm -rf /etc/apk/cache

RUN pecl install pcov redis && docker-php-ext-enable pcov redis

RUN if [[ ${NEED_DEBUG} -eq 1 ]] ; then \
    pecl install xdebug-3.1.4 && docker-php-ext-enable xdebug \
    && echo "xdebug.mode=debug,coverage" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.client_host=172.17.0.1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.port=9003" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.discover_client_host=false" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.log_level=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
; fi

