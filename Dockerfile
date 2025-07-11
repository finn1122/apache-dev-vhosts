FROM php:8.2-apache

# Activar módulos necesarios
RUN a2enmod rewrite

# Copiar configuración global personalizada
COPY conf/apache2.conf /etc/apache2/apache2.conf
COPY conf/ports.conf /etc/apache2/ports.conf
COPY conf/envvars /etc/apache2/envvars
COPY conf/magic /etc/apache2/magic

# Configuración adicional y módulos
COPY conf/conf-available/ /etc/apache2/conf-available/
COPY conf/mods-available/ /etc/apache2/mods-available/

# Copiar Virtual Hosts
COPY sites/*.conf /etc/apache2/sites-available/

# Activar todos los Virtual Hosts disponibles
RUN a2ensite *.conf || true

# Copiar DocumentRoot
COPY www/ /var/www/
RUN chown -R www-data:www-data /var/www

EXPOSE 80
