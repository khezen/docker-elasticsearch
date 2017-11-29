#!/bin/bash

hash=$(/usr/share/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $ELASTIC_PWD)
sed -ri "s|hash:[^\r\n#]*#elastic|hash: \'$hash\' #elastic|" /usr/share/elasticsearch/config/searchguard/sg_internal_users.yml

hash=$(/usr/share/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $KIBANA_PWD)
sed -ri "s|hash:[^\r\n#]*#kibana|hash: '$hash' #kibana|" /usr/share/elasticsearch/config/searchguard/sg_internal_users.yml

hash=$(/usr/share/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $LOGSTASH_PWD)
sed -ri "s|hash:[^\r\n#]*#logstash|hash: '$hash' #logstash|" /usr/share/elasticsearch/config/searchguard/sg_internal_users.yml

hash=$(/usr/share/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $BEATS_PWD)
sed -ri "s|hash:[^\r\n#]*#beats|hash: '$hash' #beats|" /usr/share/elasticsearch/config/searchguard/sg_internal_users.yml

cat /usr/share/elasticsearch/config/searchguard/sg_internal_users.yml
