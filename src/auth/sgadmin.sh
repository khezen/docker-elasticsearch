#!/bin/bash

chmod +x /usr/share/elasticsearch/plugins/search-guard-5/tools/sgadmin.sh
plugins/search-guard-5/tools/sgadmin.sh \
-cd /usr/share/elasticsearch/config/searchguard \
-ks /usr/share/elasticsearch/config/searchguard/ssl/elastic-keystore.jks \
-ts /usr/share/elasticsearch/config/searchguard/ssl/truststore.jks \
-cn $CLUSTER_NAME \
-kspass $KS_PWD \
-tspass $TS_PWD \
-h $HOSTNAME \
-nhnv
