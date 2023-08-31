#!/bin/bash

set -e

echo "Checando dhparams.pem"
if [ ! -f "/vol/proxy/ssl-dhparams.pem" ]; then
  echo "dhparams.pem não encontrado, criando..."
  openssl dhparam -out /vol/proxy/ssl-dhparams.pem 2048
fi

echo "Checando fullchain.pem"
if [ ! -f "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" ]; then
  echo "Certificado SSL não encontrado, habilitando apenas HTTP..."
  envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf
else
  echo "Certificado SSL encontrado, habilitando HTTPS..."
  envsubst < /etc/nginx/default-ssl.conf.tpl > /etc/nginx/conf.d/default.conf
fi

nginx-debug -g 'daemon off;'
