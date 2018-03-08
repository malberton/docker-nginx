# Starting with the NGINX image...
FROM nginx

# Copy static HTML files from host machine www/ folder to appropriate nginx image folder
COPY www/ /usr/share/nginx/html

# Copy custom configuration from host machine conf/ folder to appropriate nginx image folder
COPY conf/ /etc/nginx/conf.d

# Mount volumes to expose files that may need to be edited downstream
VOLUME /usr/share/nginx/html /etc/nginx
