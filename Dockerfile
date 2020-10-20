# Tony Duco
# Oct 20 2020
# NGINX server for serving Gitlab Review Apps

# Base image
FROM nginx:1.17.6

# Set default host directory
ENV BASE_HOST=localhost

# Set working directory
WORKDIR /srv

# Make pages directory
RUN mkdir -p /srv/pages

# Copy nginx config template
COPY nginx.conf.template /nginx.conf.template

# Give permissions to nginx user
RUN chown -R nginx:nginx /srv && \
    chmod -R 755 /srv && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d && \
    chown -R nginx:nginx /etc/nginx/nginx.conf

# Configure PID of nginx user
RUN touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Set to use user nginx
USER nginx

# Expose HTTP port
EXPOSE 8000

# Set run command to create config from template and start
CMD ["/bin/sh" , "-c" , "envsubst '$BASE_HOST' < /nginx.conf.template > /etc/nginx/nginx.conf && exec nginx -g 'daemon off;'"]