#!/bin/bash

# Attendre que la base de données soit opérationnelle
until mysqladmin ping -h"${WORDPRESS_DB_HOST}" --silent; do
    echo "En attente de la base de données..."
    sleep 2
done

# Définir le chemin de WordPress
WP_PATH=/var/www/html/wordpress

# Vérifier si WordPress est installé
if ! [ -f "${WP_PATH}/wp-config.php" ]; then
    echo "Configuration de WordPress..."

    # Télécharger wp-cli
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
    chmod +x /usr/local/bin/wp

    # Créer le fichier wp-config.php
    wp config create --allow-root \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}:3306" \
        --path="${WP_PATH}"

    # Installer WordPress
    wp core install --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="Mon Site WordPress" \
        --admin_user="${ADMIN_USER}" \
        --admin_password="${ADMIN_PASSWORD}" \
        --admin_email="${ADMIN_EMAIL}" \
        --path="${WP_PATH}"
fi

# Lancer PHP-FPM
exec php-fpm7.4 -F
