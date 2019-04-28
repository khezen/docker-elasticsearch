#!/bin/bash

restore_config(){
    mkdir -p /elasticsearch/config
    if [ ! -f /elasticsearch/config/elasticsearch.yml ]; then
        cp -r /.backup/elasticsearch/config/elasticsearch.yml /elasticsearch/config/
    fi
    if [ ! -f /elasticsearch/config/log4j2.properties ]; then
        cp -r /.backup/elasticsearch/config/log4j2.properties /elasticsearch/config/
    fi
    if [ ! -f /elasticsearch/config/jvm.options ]; then
        cp -r /.backup/elasticsearch/config/jvm.options /elasticsearch/config/
    fi
    rsync -av --ignore-existing /.backup/elasticsearch/config/searchguard/ /elasticsearch/config/searchguard/
}

restore_config

