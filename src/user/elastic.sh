#!/bin/bash

if [ ! -f /.elastic ]; then
    touch /.elastic
    echo "changeme" > /.elastic
fi

curl -XPUT -u "elastic:$(cat /.elastic)" "$HOSTNAME:9200/_xpack/security/user/elastic/_password" -d "{
    \"password\" : \"$ELASTIC_PWD\"
}"

echo "$ELASTIC_PWD" > /.elastic