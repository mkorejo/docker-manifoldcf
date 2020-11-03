#!/bin/sh
bash /wait-for-it.sh $POSTGRES_HOSTNAME:$POSTGRES_PORT

PROPS_FILE='./properties.xml'

sed -i "s/\$MANIFOLDCF_VERSION/$MANIFOLDCF_VERSION/" $PROPS_FILE
sed -i "s/\$POSTGRES_HOSTNAME/$POSTGRES_HOSTNAME/" $PROPS_FILE
sed -i "s/\$POSTGRES_PORT/$POSTGRES_PORT/" $PROPS_FILE
sed -i "s/\$POSTGRES_SSL/$POSTGRES_SSL/" $PROPS_FILE
sed -i "s/\$POSTGRES_DB/$POSTGRES_DB/" $PROPS_FILE
sed -i "s/\$POSTGRES_USER/$POSTGRES_USER/" $PROPS_FILE
sed -i "s/\$POSTGRES_PASSWORD/$POSTGRES_PASSWORD/" $PROPS_FILE

if [ "$1" = 'agent' ]; then
  echo "Initializing DB ..."
  ./initialize.sh

  # Run this script in background so we can also run the start-webapps script
  echo "Starting agents ..."
  ./start-agents.sh > agent-1.log 2>&1 &

  echo "Starting web application ..."
  ./start-webapps.sh

elif [ "$1" = 'webapp' ]; then
  echo "Initializing DB ..."
  ./initialize.sh

  echo "Starting web application ..."
  ./start-webapps.sh

# Run this image with CMD `sleep` just to keep it running and debug
elif [ "$1" = 'sleep' ]; then
  while true; do
    echo "running sleep";
    sleep 10;
  done;
fi
