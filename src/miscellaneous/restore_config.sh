#!/bin/bash

if [ ! -f /etc/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/elasticsearch/config /etc/elasticsearch/
fi
