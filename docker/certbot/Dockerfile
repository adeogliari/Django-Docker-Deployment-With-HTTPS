FROM certbot/certbot:v2.6.0

COPY certify-init.sh /opt/

RUN adduser --disabled-password --no-create-home nginx && \
	 mkdir -p /etc/letsencrypt && \
	 chown -R nginx:nginx /etc/letsencrypt && \
	 chown -R nginx:nginx /opt && \
	 chmod +x /opt/certify-init.sh && \
	 certbot certonly --config-dir ~/certbot/config --work-dir ~/certbot/work --logs-dir ~/certbot/logs
 

USER nginx

ENTRYPOINT []
CMD ["certbot", "renew"]
