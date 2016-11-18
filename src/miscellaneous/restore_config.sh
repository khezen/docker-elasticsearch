#!/bin/bash
mkdir -p /usr/share/elasticsearch/config

if [ ! -f /usr/share/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/elasticsearch/config/elasticsearch.yml /usr/share/elasticsearch/config/
fi

if [ ! -f /usr/share/elasticsearch/config/log4j2.properties ]; then
    cp -r /.backup/elasticsearch/config/log4j2.properties /usr/share/elasticsearch/config/
fi

if [ ! -d /usr/share/elasticsearch/config/scrpits ]; then
    cp -r /.backup/elasticsearch/config/scripts /usr/share/elasticsearch/config/
fi
