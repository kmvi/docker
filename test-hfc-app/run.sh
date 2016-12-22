#!/bin/sh

export MONO_IOMAP=all

APP_DIR_E=$(echo $APP_DIR | sed -e 's/[\/&]/\\&/g')
APP_NAME_E=$(echo $APP_NAME | sed -e 's/[\/&]/\\&/g')
WEB_DIR_E=$(echo $WEB_DIR | sed -e 's/[\/&]/\\&/g')

sed -ie "s/\${APP_DIR}/$APP_DIR_E/g" $APP_DIR/web.config
sed -ie "s/\${APP_NAME}/$APP_NAME_E/g" $APP_DIR/web.config
sed -ie "s/\${WEB_DIR}/$WEB_DIR_E/g" $APP_DIR/web.config

sed -ie "s/\${APP_DIR}/$APP_DIR_E/g" $APP_DIR/nginx.conf
sed -ie "s/\${APP_NAME}/$APP_NAME_E/g" $APP_DIR/nginx.conf
sed -ie "s/\${WEB_DIR}/$WEB_DIR_E/g" $APP_DIR/nginx.conf

sed -ie "s/\${APP_DIR}/$APP_DIR_E/g" $APP_DIR/hfc.config
sed -ie "s/\${APP_NAME}/$APP_NAME_E/g" $APP_DIR/hfc.config
sed -ie "s/\${WEB_DIR}/$WEB_DIR_E/g" $APP_DIR/hfc.config

mv -f $APP_DIR/nginx.conf /etc/nginx/conf.d/default.conf
mv -f $APP_DIR/web.config $WEB_DIR/web.config

sed -ie "s/\(fastcgi_param[[:space:]]*SCRIPT_FILENAME\)/#\1/" /etc/nginx/fastcgi_params
sed -ie "s/\(fastcgi_param[[:space:]]*PATH_INFO\)/#\1/" /etc/nginx/fastcgi_params

mkdir -p /tmp/hfc-socket
chown :nginx /tmp/hfc-socket
chmod g+s /tmp/hfc-socket

nginx

umask 0012
hyperfastcgi4 /config=$APP_DIR/hfc.config