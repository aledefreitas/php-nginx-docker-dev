# Copies default nginx configuration files
COPY --chown=nginx: ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx: ./nginx/conf.d /etc/nginx/conf.d

# Copies default php configuration files
COPY --chown=www-data: ./php/fpm/www-common.conf /usr/local/etc/php-fpm.d/www-common.conf
COPY --chown=www-data: ./php/config/php.ini /usr/local/etc/php/php.ini
COPY --chown=www-data: ./php/config/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

# Copies default supervisor configuration files
COPY --chown=www-data: ./supervisor/supervisord.conf /etc/supervisord.conf
COPY --chown=www-data: ./supervisor/conf.d /etc/supervisor/conf.d
