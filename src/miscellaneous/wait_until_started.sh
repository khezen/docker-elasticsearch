#!/bin/bash
RET=1
while [[ RET -ne 0 ]]; do
    echo "Stalling for Elasticsearch..."
    sleep 5
     curl -XGET "http://localhost:9200/" >/dev/null 2>&1
    RET=$?
done