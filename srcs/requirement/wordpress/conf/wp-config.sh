#!/bin/bash

# Create necessary directories
mkdir -p /var/www/html

# Navigate to the web root directory
cd /var/www/html

# Remove any existing files
rm -rf /var/www/html/*

# Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

# Make wp-cli executable and move it to a directory in PATH
chmod +x wp-cli.phar 
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress core files
wp core download --allow-root

# Create wp-config.php from the sample file
# mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Set database configuration in wp-config.php
# sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
# sed -i "s/username_here/$MYSQL_USER/" wp-config.php
# sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
# sed -i "s/localhost/mariadb-app/" wp-config.php
wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb-app --allow-root
# Install WordPress
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# Create an additional WordPress user
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# Install and activate a theme
# wp theme install astra --activate --allow-root

# Install and activate Redis cache plugin
# wp plugin install redis-cache --activate --allow-root

# Set permissions for WordPress directories
# chmod -R 755 /var/www/html/wp-content/plugins
# chmod -R 755 /var/www/html/wp-content/themes
# chmod -R 755 /var/www/html/wp-content/uploads

# Set ownership to www-data
chown -R www-data:www-data /var/www/html/

# Enable Redis cache:
#Redis is an in-memory data structure store that can be used as a caching layer for WordPress to improve performance.
#To enable Redis cache in WordPress, the WP_CACHE constant must be set to true in the wp-config.php file, and the Redis object cache plugin must be installed and activated.

# wp config set WP_CACHE true --raw --type=constant --allow-root
#WP_CACHE is a WordPress constant that enables the use of a caching plugin.
#--raw indicates that the value should be written as a raw value (not quoted).
#--type=constant specifies that the value being set is a constant.
#--allow-root allows the command to be run as the root user.

# wp config set WP_REDIS_HOST redis --allow-root
#WP_REDIS_HOST is a constant used by the Redis cache plugin to specify the hostname of the Redis server.
#redis is the hostname of the Redis server, which should be accessible from the WordPress container.

# wp redis enable --allow-root
#wp redis enable is a command provided by the Redis cache plugin to enable Redis caching.


# Ensure PHP-FPM listens on port 9000
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf
#sed: Stream editor for filtering and transforming text.
#-i: Option to edit the file in place. This means the changes are directly applied to the file without creating a backup.
#'s/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g': The substitution command.
#s: Stands for substitution.
#listen = \/run\/php\/php7.4-fpm.sock: The pattern to search for. The backslashes (\) are used to escape the forward slashes (/) in the file path.
#listen = 9000: The replacement string.
#g: Global flag, meaning all occurrences of the pattern in the file will be replaced.
#/etc/php/7.4/fpm/pool.d/www.conf: The file to be edited.

#Purpose of the Command:

#Original Line: listen = /run/php/php7.4-fpm.sock
#This line in the PHP-FPM configuration file specifies that PHP-FPM should listen on a Unix socket located at /run/php/php7.4-fpm.sock.

#Modified Line: listen = 9000
#This changes the configuration to make PHP-FPM listen on TCP port 9000 instead of the Unix socket.

#Why This Change is Necessary:

#Unix Socket vs. TCP Port:
        #Unix Socket: A file-based communication endpoint. It is efficient for communication between processes on the same machine.
        #TCP Port: A network-based communication endpoint. It allows communication over a network, which is necessary when the web server (NGINX) and PHP-FPM are running in separate Docker containers.

#By making PHP-FPM listen on port 9000, you enable the NGINX container to communicate with the PHP-FPM container over the network,
#which is essential in a Dockerized environment where services run in isolated containers.

# Create necessary directories for PHP-FPM
mkdir -p /run/php

# Start PHP-FPM
php-fpm7.4 -F -R

#Summary:
#This script automates the setup and configuration of WordPress, including downloading the core files, setting up the configuration,
#installing WordPress, creating users, installing themes and plugins, setting permissions, and starting PHP-FPM. 
#Each command is designed to ensure that WordPress is properly configured and ready to use in a Docker container environment.