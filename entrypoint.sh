#!/bin/bash
set -e

PROPS_FILE='/usr/share/manifoldcf/example/properties.xml'

if [ "$1" = 'start' ]; then
  sed -i "s/\$POSTGRES_HOSTNAME/$POSTGRES_HOSTNAME/" $PROPS_FILE
  sed -i "s/\$POSTGRES_PORT/$POSTGRES_PORT/" $PROPS_FILE
  sed -i "s/\$POSTGRES_SSL/$POSTGRES_SSL/" $PROPS_FILE
  sed -i "s/\$POSTGRES_DB/$POSTGRES_DB/" $PROPS_FILE
  sed -i "s/\$POSTGRES_USER/$POSTGRES_USER/" $PROPS_FILE
  sed -i "s/\$POSTGRES_PASSWORD/$POSTGRES_PASSWORD/" $PROPS_FILE
  exec java -jar start.jar

elif [ "$1" = 'sleep' ]; then
  while true; do
    echo "running sleep";
    sleep 10;
  done;
fi;
