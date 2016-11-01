#!/bin/bash

set -m

if [ ! -f /etc/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/elasticsearch/config /etc/elasticsearch/
fi

/run/miscellaneous/perf.sh

/docker-entrypoint.sh  "$@" &

/run/miscellaneous/wait_until_started.sh

/run/users/elastic.sh
/run/users/kibana.sh
/run/users/logstash.sh
/run/users/beats.sh

fg