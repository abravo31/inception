#!/bin/bash
set -x
# Attendre que la base de données soit opérationnelle
until mysqladmin ping -h"${DB_HOST}" -p$MYSQL_ROOT_PASSWORD; do
    echo "En attente de la base de données..."
    sleep 1
done

# Définir le chemin de WordPress
WP_PATH=/var/www/html/wordpress

# Vérifier si WordPress est installé
if ! [ -f "${WP_PATH}/wp-config.php" ]; then
    echo "WordPress configuration ..."

    # Télécharger wp-cli
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp
    chmod +x /usr/local/bin/wp

    # Créer le fichier wp-config.php
    wp config create --allow-root \
        --dbname="${DB_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="${DB_HOST}" \
        --path="${WP_PATH}"

    # Installer WordPress
    wp core install --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="Mon Site WordPress" \
        --admin_user="${ADMIN_USER}" \
        --admin_password="${ADMIN_PASSWORD}" \
        --admin_email="${ADMIN_EMAIL}" \
        --path="${WP_PATH}"
    
    wp user create --allow-root \
        ${DB_NEW_USER} ${DB_NEW_USER_MAIL} \
        --user_pass=${DB_NEW_USER_PASS} \
    
fi
echo "End of configuration ..."

# Lancer PHP-FPM
exec php-fpm7.4 -F
