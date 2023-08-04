#!/bin/sh

set -e

until nc -z ${DB_HOST} 5432; do
    echo "Aguardando Banco de Dados..."
    sleep 2s & wait ${!}
done

echo "Banco de Dados Pronto!"

ls -la /vol/
ls -la /vol/web

whoami

python manage.py collectstatic --noinput
python manage.py migrate
python manage.py runserver 0.0.0.0:8000

uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi