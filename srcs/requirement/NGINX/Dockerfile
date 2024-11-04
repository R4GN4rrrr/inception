FROM debian:bullseye

# Install nginx and openssl, and generate self-signed certificate
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx openssl \
    && mkdir -p /etc/nginx/ssl/ && chmod 755 /etc/nginx/ssl \
    && openssl req -x509 -nodes -out "/etc/nginx/ssl/self.cert" -keyout "/etc/nginx/ssl/self.key" -subj "/"

# Copy our nginx config file to the conf.d folder inside the container
COPY conf/nginx.conf /etc/nginx/conf.d/

# Expose HTTPS port
EXPOSE 443

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
