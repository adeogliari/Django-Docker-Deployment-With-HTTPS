#!/bin/sh

# Waits for proxy to be available, then gets the first certificate.

set -e

until nc -z proxy 80; do
    echo "Aguardando Proxy..."
    sleep 5s & wait ${!}
done

echo "Gerando Certificado..."

certbot certonly \
    --webroot \
    --webroot-path "/vol/www/" \
    -d "$DOMAIN" \
    --email $EMAIL \
    --rsa-key-size 4096 \
    --agree-tos \
    --noninteractive
