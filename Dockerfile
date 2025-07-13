FROM php:7.4-apache

# 🧩 Instalar extensiones necesarias para Laravel/Lumen y dependencias comunes
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libzip-dev \
    libxml2-dev \
    unzip \
    iputils-ping \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        pdo \
        pdo_mysql \
        gd \
        zip \
        dom \
    && rm -rf /var/lib/apt/lists/*

# 🔄 Activar mod_rewrite
RUN a2enmod rewrite

# 📄 Copiar VirtualHost personalizado
COPY conf/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf

# 🌐 Activar el sitio
RUN a2ensite 000-default.conf

EXPOSE 80
