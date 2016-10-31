#!/bin/bash

echo "Stalling for Elasticsearch"
while true; do
    nc -q 1 $elasticsearch_host $elasticsearch_port 2>/dev/null && break
done

echo "Elasticsearch started"