#!/bin/bash
sed -ri "s/cluster.name:[^\r\n]*/cluster.name: $CLUSTER_NAME/" /usr/share/elasticsearch/config/elasticsearch.yml
sed -ri "s/discovery.zen.minimum_master_nodes:[^\r\n]*/discovery.zen.minimum_master_nodes: $MINIMUM_MASTER_NODES/" /usr/share/elasticsearch/config/elasticsearch.yml
sed -ri "s/keystore_password:[^\r\n]*/keystore_password: $KS_PWD/" /usr/share/elasticsearch/config/elasticsearch.yml
sed -ri "s/truststore_password:[^\r\n]*/truststore_password: $TS_PWD/" /usr/share/elasticsearch/config/elasticsearch.yml