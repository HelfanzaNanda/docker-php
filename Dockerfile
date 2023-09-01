FROM php:8.0.0rc1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y git

# Install PHP extensions
RUN buildDeps=" \
        libicu-dev \
        zlib1g-dev \
        libsqlite3-dev \
        libpq-dev \
    " \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        $buildDeps \
        libicu52 \
        zlib1g \
        sqlite3 \
        git \
        php8-pgsql \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install \
        intl \
        mbstring \
        pdo_mysql \
        pdo_pgsql \
        pdo \
        pgsql \
        zip \
        pdo_sqlite \
    && apt-get purge -y --auto-remove $buildDeps

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www
