FROM nginxinc/nginx-unprivileged:1.25-alpine3.18

COPY ./nginx/* /etc/nginx/
COPY ./run.sh /run.sh

ENV APP_HOST=app
ENV APP_PORT=9000

USER root

RUN apk add --no-cache openssl bash && \
	 mkdir -p /vol/static && \
	 mkdir -p /vol/www && \
	 mkdir -p /vol/proxy && \
	 mkdir -p /etc/letsencrypt && \
	 chown -R nginx:nginx /vol && \
	 chown -R nginx:nginx /etc/letsencrypt && \
	     #chmod -R 755 /vol
    chown nginx:nginx /run.sh && \
    chmod +x /run.sh

VOLUME /vol/static
VOLUME /vol/www

USER nginx

CMD ["/run.sh"]
