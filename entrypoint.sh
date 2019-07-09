#!/bin/sh
sh /wait-for-it.sh $POSTGRES_HOSTNAME:$POSTGRES_PORT

PROPS_FILE='./properties.xml'

sed -i "s/\$MANIFOLDCF_VERSION/$MANIFOLDCF_VERSION/" $PROPS_FILE
sed -i "s/\$POSTGRES_HOSTNAME/$POSTGRES_HOSTNAME/" $PROPS_FILE
sed -i "s/\$POSTGRES_PORT/$POSTGRES_PORT/" $PROPS_FILE
sed -i "s/\$POSTGRES_SSL/$POSTGRES_SSL/" $PROPS_FILE
sed -i "s/\$POSTGRES_DB/$POSTGRES_DB/" $PROPS_FILE
sed -i "s/\$POSTGRES_USER/$POSTGRES_USER/" $PROPS_FILE
sed -i "s/\$POSTGRES_PASSWORD/$POSTGRES_PASSWORD/" $PROPS_FILE

if [ "$1" = 'start' ]; then
  chmod +x *.sh

  echo "Initializing DB ..."
  sh initialize.sh

  echo "Starting agents ..."
  sh start-agents.sh &

  echo "Starting web application ..."
  sh start-webapps.sh
elif [ "$1" = 'sleep' ]; then
  while true; do
    echo "running sleep";
    sleep 10;
  done;
fi
