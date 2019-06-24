#!/bin/bash
set -e

PROPS_FILE='/usr/share/manifoldcf/example/properties.xml'

if [ "$1" = 'start' ]; then
  sed -i "s/\$POSTGRES_HOSTNAME/$POSTGRES_HOSTNAME/" $PROPS_FILE
  sed -i "s/\$HTTPS_PORT/$HTTPS_PORT/" $PROPS_FILE
  sed -i "s/\$JMS_PORT/$JMS_PORT/" $PROPS_FILE
  sed -i "s/\$DB_HOST/$DB_HOST/" $PROPS_FILE
  sed -i "s/\$MYSQL_PORT/$MYSQL_PORT/" $PROPS_FILE
  sed -i "s/\$DB_NAME/$DB_NAME/" $PROPS_FILE
  sed -i "s/\$DB_USER/$DB_USER/" $PROPS_FILE
  sed -i "s/\$DB_PASSWORD/$DB_PASSWORD/" $PROPS_FILE
  sed -i "s/\$ADMIN_PASSWORD/$ADMIN_PASSWORD/" $PROPS_FILE
  /tmp/ibm-ucd-install/install-server.sh
  exec /opt/ibm-ucd/server/bin/server run

elif [ "$1" = 'sleep' ]; then
  while true; do
    echo "running sleep";
    sleep 10;
  done;
fi;