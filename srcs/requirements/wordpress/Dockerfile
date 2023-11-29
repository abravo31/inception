# # oldstable Debian version
FROM debian:bullseye

# Update & Install necessary packages for PHP & php-fpm
RUN apt-get update && apt-get install -y \
    vim \
    default-mysql-client \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-common \
    php7.4-cgi \
    php7.4-gd \
    php7.4-xml \
    php7.4-mbstring \
    wget \
    unzip \
    telnet \
    && rm -rf /var/lib/apt/lists/*

# Download and run WordPress
ADD https://wordpress.org/latest.tar.gz /var/www/html/
RUN tar -xzf /var/www/html/latest.tar.gz -C /var/www/html/ \
    && rm /var/www/html/latest.tar.gz

# Give the property to the user www-data
RUN chown -R www-data:www-data /var/www/html/wordpress 
RUN mkdir -p /run/php && chown www-data:www-data /run/php

COPY ./tools/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY ./tools/init-wordpress.sh /usr/local/bin/init-wordpress.sh

# Set the working directory
WORKDIR /var/www/html/wordpress

# Expose the port for php-fpm
EXPOSE 9000

# Start php-fpm
CMD ["bash", "/usr/local/bin/init-wordpress.sh"]