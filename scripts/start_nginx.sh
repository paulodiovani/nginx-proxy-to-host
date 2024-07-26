#!/bin/sh

export DOLLAR='$'

set -e 

if [ -n "$GRPC" ]; then
  envsubst < /tmp/nginx-grpc.conf.template > /etc/nginx/conf.d/default.conf
else
  envsubst < /tmp/nginx-http.conf.template > /etc/nginx/conf.d/default.conf
fi

nginx -g 'daemon off;'
