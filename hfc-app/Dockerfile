FROM mono-nginx-hfc

ENV APP_DIR /app
ENV WEB_DIR ${APP_DIR}/www
ENV APP_NAME appname

COPY nginx.conf run.sh web.config hfc.config app/ ${APP_DIR}/
WORKDIR ${APP_DIR}

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

VOLUME [ "${APP_DIR}" ]

CMD chmod +x $APP_DIR/run.sh && $APP_DIR/run.sh
