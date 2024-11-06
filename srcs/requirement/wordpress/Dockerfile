# Pulling our base image
FROM debian:bullseye

# Install PHP-FPM and MySQL extensions
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install php-fpm php7.4-mysqlnd -y \
    && apt-get install curl -y

COPY ./conf/wp-config.sh  /

RUN chmod +x wp-config.sh

EXPOSE 9000

CMD [ "./wp-config.sh" ]