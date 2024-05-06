#!/bin/sh

# Configuration initiale de MariaDB
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Démarrage temporaire de MariaDB pour configuration initiale
/usr/bin/mysqld_safe --datadir='/var/lib/mysql' & 
pid="$!"

sleep 10

# Configuration de la base de données et de l'utilisateur
echo "
    CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME;
    CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
    CREATE USER IF NOT EXISTS '$MYSQL_ROOT_USER'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
    GRANT ALL ON $MYSQL_DB_NAME.* TO '$MYSQL_ROOT_USER'@'localhost';
    GRANT ALL ON $MYSQL_DB_NAME.* TO '$MYSQL_ROOT_USER'@'%';
    FLUSH PRIVILEGES;
" | mysql -u root

# Arrêt de MariaDB après la configuration
if ! kill -s TERM "$pid" || ! wait "$pid"; then
    echo >&2 'MariaDB init process failed.'
    exit 1
fi

# Démarrage de MariaDB
exec /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
