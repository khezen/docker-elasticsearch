#!/bin/bash

if [ ! -f /config/.elastic ]; then
    curl -XPUT -u "elastic:changeme" "$HOSTNAME:9200/_xpack/security/user/elastic/_password" -d "{
        \"password\" : \"$elastic_pwd\"
    }"
    touch /config/.elastic
fi
