FROM php:8.3-fpm
WORKDIR /var/www

RUN apt-get -y update \
    && apt-get -y install --no-install-recommends  \
    libicu-dev  \
    g++ \
    bash \
    httpie \
    unzip \
    libzip-dev \
    autoconf \
    make \
    jq \
    git \
    unixodbc \
    unixodbc-dev -y \
    cmake \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN docker-php-ext-configure intl \
    && docker-php-ext-install intl pdo_mysql pcntl bcmath zip \
    && docker-php-ext-enable intl

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -sS https://getcomposer.org/installer |  php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir tests

COPY composer.* ./

RUN composer install 

COPY ./entrypoint.sh /usr/local/bin

RUN ["chmod", "+x", "/usr/local/bin/entrypoint.sh"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh", "php-fpm"]