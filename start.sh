#!/bin/sh

# get host ip
export HOST_IP=$(/sbin/ip route|awk '/default/ { print $3 }')

echo "Running PhantomJS in GhostDriver mode"
echo "Host IP: $HOST_IP"

# adding IP of a host to /etc/hosts
echo "$HOST_IP dockerhost" >> /etc/hosts

# adding APP_HOST to list of known hosts
if [ $APP_HOST ]; 
then 
  echo "Registering host $APP_HOST"
  echo "$HOSTIP $APP_HOST" >> /etc/hosts
fi;

# if only port provided - redirect to host+port
if [ $APP_PORT ]; 
then 
  echo "Registering port $APP_PORT"
  socat TCP4-LISTEN:$APP_PORT,fork,reuseaddr TCP4:dockerhost:$APP_PORT &
fi;

# starting selenium
phantomjs --webdriver=4444