#!/bin/bash
set -ex
export DEBIAN_FRONTEND=noninteractive

# Actualizar sistema
apt update
apt upgrade -y

# Apache
apt install apache2 -y
a2enmod rewrite
cp ../conf/000-default.conf /etc/apache2/sites-available/000-default.conf

# PHP
apt install php libapache2-mod-php php-mysql -y
systemctl restart apache2

# MySQL
apt install mysql-server -y

# Permisos del directorio web
chown -R www-data:www-data /var/www/html