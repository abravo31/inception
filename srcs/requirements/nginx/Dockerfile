# version oldstable 
FROM debian:bullseye

# Install NGINX, 
# Create the directory for CSR (Certificate Signing Requests)
# Clean and remove files dowload by apt-get update that we dont need 
RUN apt-get update && apt-get install -y nginx \
mkdir -p /etc/ssl/certs && /etc/ssl/private \
apt-get clean && \
rm -rf /var/lib/apt/lists/*


# Copy NGINX configuration inside of container 
COPY  ./tools/nginx.conf /etc/nginx/nginx.conf

# Copy certifications in the container
COPY ./tools/ssl/certs/inception.crt /etc/ssl/certs/
COPY ./tools/ssl/private/inception.key /etc/ssl/private/
#RUN chown www-data:www-data /etc/ssl/private/inception.key && chmod 600 /etc/ssl/private/inception.key

# Expose the port HTTPS
EXPOSE 443

# run NGINX
CMD ["nginx", "-g", "daemon off;"]
