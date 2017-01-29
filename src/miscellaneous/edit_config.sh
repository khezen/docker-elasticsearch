#!/bin/bash
sed -ri "s/cluster.name:[^\r\n]*/cluster.name: $CLUSTER_NAME/" /usr/share/elasticsearch/config/elasticsearch.yml
sed -ri "s/keystore_password:[^\r\n]*/keystore_password: $KS_PWD/" /usr/share/elasticsearch/config/elasticsearch.yml
sed -ri "s/truststore_password:[^\r\n]*/truststore_password: $TS_PWD/" /usr/share/elasticsearch/config/elasticsearch.yml
sed -ri "s/discovery.zen.ping.unicast.hosts:[^\r\n]*/discovery.zen.ping.unicast.hosts: $HOSTS/" /usr/share/elasticsearch/config/elasticsearch.yml