#!/bin/bash
mkdir -p /elasticsearch/config

if [ ! -f /elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/elasticsearch/config/elasticsearch.yml /elasticsearch/config/
fi

if [ ! -f /elasticsearch/config/log4j2.properties ]; then
    cp -r /.backup/elasticsearch/config/log4j2.properties /elasticsearch/config/
fi

if [ ! -d /elasticsearch/config/scripts ]; then
    cp -r /.backup/elasticsearch/config/scripts /elasticsearch/config/
fi

if [ ! -d /elasticsearch/config/searchguard ]; then
    cp -r /.backup/elasticsearch/config/searchguard /elasticsearch/config/searchguard/
fi
