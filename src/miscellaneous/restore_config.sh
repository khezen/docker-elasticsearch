#!/bin/bash

if [ ! -f /etc/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/config/elasticsearch.yml $CONF_DIR/elasticsearch.yml
fi
