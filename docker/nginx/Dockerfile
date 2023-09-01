FROM nginx:1.24.0-alpine3.17-slim

COPY ./nginx/* /etc/nginx/
COPY ./run.sh /run.sh

ENV APP_HOST=app
ENV APP_PORT=9000

USER root

RUN apk add --no-cache openssl bash && \
	  mkdir -p /vol/static && \
	  mkdir -p /vol/www && \
    chmod +x /run.sh

CMD ["/run.sh"]
