#!/bin/bash
mkdir -p /etc/elasticsearch

if [ ! -f /etc/elasticsearch/elasticsearch.yml ]; then
    cp -ra /.backup/elasticsearch/elasticsearch.yml /etc/elasticsearch
fi

if [ ! -f /etc/elasticsearch/jvm.options ]; then
    cp -ra /.backup/elasticsearch/jvm.options /etc/elasticsearch
fi

if [ ! -f /etc/elasticsearch/log4j2.properties ]; then
    cp -ra /.backup/elasticsearch/log4j2.properties /etc/elasticsearch
fi

if [ ! -d /etc/elasticsearch/x-pack ]; then
    cp -ra /.backup/elasticsearch/x-pack /etc/elasticsearch
fi

if [ ! -d /etc/elasticsearch/scrpits ]; then
    cp -ra /.backup/elasticsearch/scripts /etc/elasticsearch
fi
