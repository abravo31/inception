# # oldstable Debian version
FROM debian:bullseye

# Update & Install necessary packages PHP & php-fpm
RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    php-common \
    php-cgi \
    php-gd \
    php-xml \
    php-mbstring \
    wget \
    unzip \
    default-mysql-server \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install the dependencies need by WordPress
RUN apt-get update && apt-get install -y \
        libjpeg-dev \
        libpng-dev \
        && docker-php-ext-configure gd --with-jpeg \
        && docker-php-ext-install -j$(nproc) gd

# Download and run WordPress
ADD https://wordpress.org/latest.tar.gz /var/www/html/
RUN tar -xzf /var/www/html/latest.tar.gz -C /var/www/html/ \
    && rm /var/www/html/latest.tar.gz

# Giver the property to the user www-data
RUN chown -R www-data:www-data /var/www/html/wordpress

# Définir le répertoire de travail
WORKDIR /var/www/html/wordpress

# Exposer le port pour php-fpm
EXPOSE 9000

# Démarrer php-fpm
CMD ["php-fpm"]