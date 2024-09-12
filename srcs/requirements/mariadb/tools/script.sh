#!/bin/bash

if [ ! -d /var/lib/mysql/db ]; then
    mysql_install_db --user=mysql --ldata=/var/lib/mysql/db
    mysqld_safe --skip-networking &
    while ! mysqladmin ping --silent; do
        sleep 1
    done

    mysql -uroot -e "
        CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
        CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASS}';
        GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
        FLUSH PRIVILEGES;
    "

    mysqladmin -uroot shutdown
fi

exec mysqld --bind-address=0.0.0.0
