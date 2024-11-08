# Pulling our base image
FROM debian:bullseye

WORKDIR /var/www/html

# Install PHP-FPM and MySQL extensions
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install php-fpm php7.4-mysqlnd -y \
    && apt-get install curl -y ; mkdir -p /var/www/html

COPY ./conf/wp-config.sh  /

RUN chmod +x /wp-config.sh

EXPOSE 9000

CMD [ "sh", "/wp-config.sh" ]