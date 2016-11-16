#!/bin/bash

curl -XPUT -u "elastic:$ELASTIC_PWD" "$HOSTNAME:9200/_xpack/security/user/kibana/_password" -d "{
    \"password\" : \"$KIBANA_PWD\"
}"
