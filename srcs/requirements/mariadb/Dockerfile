# Utiliser une image de base Debian ou Ubuntu
FROM debian:bullseye

# Mettre à jour les paquets et installer MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Configurer MariaDB (facultatif)
# Vous pouvez ajouter des commandes pour ajuster la configuration de MariaDB ici.
# Par exemple, copier un fichier de configuration personnalisé
COPY ./tools/my.cnf /etc/mysql/my.cnf

# Copier un script pour initialiser la base de données et les configurations
COPY ./tools/init-db.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-db.sh

EXPOSE 3306

# Démarrer MariaDB
CMD ["init-db.sh", "mysqld_safe"]
