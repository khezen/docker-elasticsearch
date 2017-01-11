#!/bin/bash
mkdir -p /usr/share/elasticsearch/config

if [ ! -f /usr/share/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/elasticsearch/config/elasticsearch.yml /usr/share/elasticsearch/config/
fi

if [ ! -f /usr/share/elasticsearch/config/logging.yml ]; then
    cp -r /.backup/elasticsearch/config/logging.yml /usr/share/elasticsearch/config/
fi

if [ ! -d /usr/share/elasticsearch/config/scrpits ]; then
    cp -r /.backup/elasticsearch/config/scripts /usr/share/elasticsearch/config/
fi

if [ ! -d /usr/share/elasticsearch/config/searchguard ]; then
    cp -r /.backup/elasticsearch/config/searchguard /usr/share/elasticsearch/config/searchguard/
fi
