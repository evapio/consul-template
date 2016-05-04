#!/usr/bin/env bash
set +x

echo "Consul Located at $CONSUL_HTTP_ADDR"
echo "Project ID is $PROJECT_ID"
echo "Retrieving Consul Template Config and Template"

wget http://$CONSUL_HTTP_ADDR/v1/kv/$PROJECT_ID/$PROJECT_ID.conf?raw -O /consul-template/config.d/$PROJECT_ID.conf
wget http://$CONSUL_HTTP_ADDR/v1/kv/$PROJECT_ID/$PROJECT_ID.ctmpl?raw -O /consul-template/templates/$PROJECT_ID.ctmpl

echo "Acquired Config and Template"

consul-template -config /consul-template/config.d/$PROJECT_ID.conf
