FROM nginx:1.24.0-alpine3.17-slim

COPY ./nginx/* /etc/nginx/
COPY ./run.sh /run.sh

ENV APP_HOST=app
ENV APP_PORT=9000

USER root

RUN apk add --no-cache openssl bash && \
	  mkdir -p /vol/static && \
	  mkdir -p /vol/www && \
	#  mkdir -p /vol/proxy && \
	#  mkdir -p /etc/letsencrypt && \
	#  chown -R nginx:nginx /vol && \
	#  chown -R nginx:nginx /etc/letsencrypt && \
   #  chown nginx:nginx /run.sh && \
    chmod +x /run.sh

# VOLUME /vol/static
# VOLUME /vol/www

CMD ["/run.sh"]
