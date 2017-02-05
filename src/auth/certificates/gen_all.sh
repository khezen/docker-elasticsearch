#!/bin/bash

chmod +x /usr/share/elasticsearch/plugins/search-guard-5/tools/hash.sh
cd /usr/share/elasticsearch/config/searchguard/ssl

# if env changes
if [ ! -f $CA_FILE ] || [ ! -f $TRUSTORE_FILE ]; then

  ca_pwd=openssl rand -base64 32
  ts_pwd=openssl rand -base64 32
  ks_pwd=openssl rand -base64 32

  /run/auth/certificates/init.sh
  /run/auth/certificates/gen_root_ca.sh
  /run/auth/certificates/gen_node_cert.sh ca_pwd ca_pwd ks_pwd
  /run/auth/certificates/gen_client_node_cert.sh elastic ca_pwd ks_pwd
  /run/auth/certificates/gen_client_node_cert.sh kibana ca_pwd ks_pwd
  /run/auth/certificates/gen_client_node_cert.sh logstash ca_pwd ks_pwd
  /run/auth/certificates/gen_client_node_cert.sh beats ca_pwd ks_pwd
fi
