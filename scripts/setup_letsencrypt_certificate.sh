#!/bin/bash
set -ex

source .env

# Copiar el VirtualHost y poner el dominio en ServerName
cp ../conf/000-default.conf /etc/apache2/sites-available/000-default.conf
sed -i "s/PUT_YOUR_DOMAIN_HERE/$LE_DOMAIN/" /etc/apache2/sites-available/000-default.conf
systemctl reload apache2

# Instalar y actualizar snapd
snap install core
snap refresh core

# Eliminar cualquier Certbot instalado con apt
apt remove certbot -y

# Instalar Certbot y crear el enlace simbólico
snap install --classic certbot
ln -fs /snap/bin/certbot /usr/bin/certbot

# Obtener el certificado y configurar Apache sin preguntas
certbot --apache \
  -m "$LE_EMAIL" \
  --agree-tos \
  --no-eff-email \
  -d "$LE_DOMAIN" \
  --non-interactive