#!/bin/bash

# Démarrer MariaDB en arrière-plan
mysqld_safe &

# Attendre que MariaDB soit opérationnelle
while ! mysqladmin ping -uroot --silent; do
    sleep 1
done

# Vérifier si la base de données existe et la créer si ce n'est pas le cas
if ! mysql -uroot -e "USE wordpress_db"; then
    mysql -uroot -e "CREATE DATABASE wordpress_db;"
fi

# Vérifier si l'utilisateur existe et le créer si ce n'est pas le cas
if ! mysql -uroot -e "SELECT 1 FROM mysql.user WHERE user = 'wordpress_user'"; then
    mysql -uroot -e "CREATE USER 'wordpress_user'@'%' IDENTIFIED BY 'wordpress_password';"
    mysql -uroot -e "GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'%';"
    mysql -uroot -e "FLUSH PRIVILEGES;"
fi

# Arrêter MariaDB
mysqladmin shutdown -uroot

