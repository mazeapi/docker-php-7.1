FROM php:7.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libgmp-dev \
    zip \
    unzip \
    vim \
    libxslt-dev \
    libicu-dev \
    libmcrypt-dev \
    libxml2-dev \
    curl

# Install extensions

RUN docker-php-ext-configure gd --with-freetype --with-jpeg --with-freetype-dir=/usr/lib64/
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install ctype json dom iconv xml soap xsl pdo_mysql zip exif pcntl gmp bcmath mcrypt intl

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=1.10.16
WORKDIR /var/www
RUN chown -R root:root .
# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
