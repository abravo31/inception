#!/bin/bash
set -x
# Démarrer MariaDB en arrière-plan
mysqld_safe &

# Attendre que MariaDB soit opérationnelle
while ! mysqladmin ping --silent; do
    sleep 4
done

# Créer la base de données si elle n'existe pas
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS '$MYSQL_DATABASE';"

# Créer l'utilisateur s'il n'existe pas et lui accorder les privilèges
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON '$MYSQL_DATABASE'.* TO '$MYSQL_USER'@'%';"
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

echo "User done "

# Shutdown MariaDB service
echo "Shutting down MariaDB..."
mysqladmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown

# Start MariaDB in safe mode
echo "Starting MariaDB in safe mode..."
exec mysqld_safe