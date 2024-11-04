# Pull the Debian Bullseye image as the base image
FROM debian:bullseye

# Update package lists and install MariaDB server
RUN apt-get update -y && apt-get install -y mariadb-server 


# Modify the MariaDB configuration to allow remote connections, as we will be connecting to our database from the WordPress container.
#RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the shell script for creating the database
COPY conf/database.sh /

RUN chmod +x database.sh

EXPOSE 3306

# Set the default command to execute the shell script when the container starts
CMD ["./database.sh"]