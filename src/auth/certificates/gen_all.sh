#!/bin/bash

chmod +x /usr/share/elasticsearch/plugins/search-guard-5/tools/hash.sh

cd /usr/share/elasticsearch/config/searchguard/ssl

/run/auth/certificates/init.sh
/run/auth/certificates/gen_root_ca.sh
/run/auth/certificates/gen_node_cert.sh 0

/run/auth/certificates/gen_client_node_cert.sh elastic 
/run/auth/certificates/gen_client_node_cert.sh kibana
/run/auth/certificates/gen_client_node_cert.sh logstash
/run/auth/certificates/gen_client_node_cert.sh beats
