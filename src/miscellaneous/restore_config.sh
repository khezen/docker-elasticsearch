#!/bin/bash
 
export CONF_DIR=/etc/elasticsearch/config/elasticsearch.yml
if [ ! -f /etc/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/config /etc/elasticsearch/config
fi
