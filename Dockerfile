FROM php:8.1-apache

# Instala extensões necessárias
RUN apt-get update && apt-get install -y \
    libpq-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_pgsql

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copia os arquivos do projeto
COPY . /var/www/html/public

# Instala dependências do Laravel
RUN composer install --no-dev --optimize-autoloader

# Permissões para o storage e cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Porta padrão do Apache
EXPOSE 80