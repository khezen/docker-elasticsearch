#!/bin/bash

set_users(){
    hash=$(/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $ELASTIC_PWD)
    sed -ri "s|hash:[^\r\n#]*#elastic|hash: \'$hash\' #elastic|" /elasticsearch/config/searchguard/sg_internal_users.yml

    hash=$(/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $KIBANA_PWD)
    sed -ri "s|hash:[^\r\n#]*#kibana|hash: '$hash' #kibana|" /elasticsearch/config/searchguard/sg_internal_users.yml

    hash=$(/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $LOGSTASH_PWD)
    sed -ri "s|hash:[^\r\n#]*#logstash|hash: '$hash' #logstash|" /elasticsearch/config/searchguard/sg_internal_users.yml

    hash=$(/elasticsearch/plugins/search-guard-6/tools/hash.sh -p $BEATS_PWD)
    sed -ri "s|hash:[^\r\n#]*#beats|hash: '$hash' #beats|" /elasticsearch/config/searchguard/sg_internal_users.yml

    cat /elasticsearch/config/searchguard/sg_internal_users.yml
}

set_users

