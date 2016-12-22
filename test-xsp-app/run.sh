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

mv -f $APP_DIR/nginx.conf /etc/nginx/conf.d/default.conf
mv -f $APP_DIR/web.config $WEB_DIR/web.config

nginx
xsp -v --root=$WEB_DIR --applications=/$APP_NAME:$WEB_DIR --port=8081 --nonstop