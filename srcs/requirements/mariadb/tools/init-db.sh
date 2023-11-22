#!/bin/bash

# Démarrer MariaDB en arrière-plan
mysqld_safe &

# Attendre que MariaDB soit opérationnelle
while ! mysqladmin ping -uroot --silent; do
    sleep 1
done

# Configurer la base de données et l'utilisateur
mysql -uroot -e "CREATE DATABASE wordpress_db;"
mysql -uroot -e "CREATE USER 'wordpress_user'@'%' IDENTIFIED BY 'wordpress_password';"
mysql -uroot -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'%';"
mysql -uroot -e "FLUSH PRIVILEGES;"

# Arrêter MariaDB
mysqladmin shutdown -uroot
