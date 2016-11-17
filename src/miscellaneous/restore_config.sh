#!/bin/bash

ES_JAVA_OPTS=$ES_JAVA_OPTS" -Des.path.conf=$CONF_DIR"
if [ ! -f /etc/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/config/elasticsearch.yml $CONF_DIR/elasticsearch.yml
fi
