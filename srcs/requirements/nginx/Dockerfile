# oldstable version
FROM debian:bullseye

# Install NGINX, 
# Create the directory for CSR (Certificate Signing Requests)
# Clean and remove files dowload by apt-get update that we dont need 
# Create the dir for PID
# Create a directory for access.log
RUN apt-get update && apt-get install -y nginx curl && \
mkdir -p /etc/ssl/certs && \
mkdir -p /etc/ssl/private && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* && \
mkdir -p /var/run/nginx && \
mkdir -p /usr/share/nginx/logs/ && touch /usr/share/nginx/logs/access.log

# Copy NGINX configuration inside of container 
COPY  ./tools/nginx.conf /etc/nginx/nginx.conf

# Copy certifications in the container
COPY ./tools/ssl/certs/inception.crt /etc/ssl/certs/
COPY ./tools/ssl/private/inception.key /etc/ssl/private/

# Expose the port HTTPS
EXPOSE 443

# change the ownership of the html directory
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# run NGINX
CMD ["nginx", "-g", "daemon off;"]
