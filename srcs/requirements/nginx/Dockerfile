# version oldstable 
FROM debian:bullseye

# Install NGINX
RUN apt-get update && apt-get install -y nginx

# Copy NGINX configuration inside of container 
COPY nginx.conf /tools/nginx.conf

# Expose the port HTTPS
EXPOSE 443

# run NGINX
CMD ["nginx", "-g", "daemon off;"]
