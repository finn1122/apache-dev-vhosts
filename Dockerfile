FROM php:7.4-apache

# 🧩 Instalar extensiones necesarias
RUN docker-php-ext-install mysqli pdo pdo_mysql
# Activar mod_rewrite
RUN a2enmod rewrite

# Copiar VirtualHost personalizado
COPY conf/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

# Activar el sitio
RUN a2ensite 000-default.conf

EXPOSE 80
