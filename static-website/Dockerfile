FROM nginx:alpine

# Use a custom server config so Nginx listens on 8085 instead of 80
COPY default.conf /etc/nginx/conf.d/default.conf

# Serve the static site from Nginx's web root
COPY index.html style.css /usr/share/nginx/html/

EXPOSE 8085
