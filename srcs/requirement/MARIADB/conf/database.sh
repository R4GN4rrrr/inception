#!/bin/bash

service mariadb start

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' ;"
mariadb -e "FLUSH PRIVILEGES;"

# mariadb : command-line client for MariaDB. It provides a way to execute SQL queries, manage databases, users, and perform various administrative tasks. 
# -e : stands for "execute." It allows you to specify a single SQL statement to be executed by MariaDB immediately after connecting.

service mariadb stop

mysqld_safe

# Using mysqld_safe is a common practice in Docker containers to ensure that the MariaDB server starts reliably and remains running within the container environment, providing a stable database service for applications running inside the container.
