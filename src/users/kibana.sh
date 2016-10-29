#!/bin/bash

curl -XPUT -u "elastic:$elastic_pwd" "$HOSTNAME:9200/_xpack/security/user/kibana/_password" -d "{
    \"password\" : \"$kibana_pwd\"
}"
