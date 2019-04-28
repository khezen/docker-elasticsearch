#!/bin/bash

sgadmin(){
    chmod +x /elasticsearch/plugins/search-guard-6/tools/sgadmin.sh
    /elasticsearch/plugins/search-guard-6/tools/sgadmin.sh \
    -cd /elasticsearch/config/searchguard \
    -ks /elasticsearch/config/searchguard/ssl/elastic-keystore.jks \
    -ts /elasticsearch/config/searchguard/ssl/truststore.jks \
    -cn $CLUSTER_NAME \
    -kspass $KS_PWD \
    -tspass $TS_PWD \
    -h $HOSTNAME \
    -nhnv
}

sgadmin
