#!/bin/bash

if [ ! -f /etc/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/ /etc/elasticsearch/
fi
