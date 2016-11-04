#!/bin/bash

set -m

if [ ! -f /etc/elasticsearch/config/elasticsearch.yml ]; then
    cp -r /.backup/elasticsearch/config /etc/elasticsearch/
fi

/run/miscellaneous/perf.sh

if [ "${1:0:1}" = '-' ]; then
	set -- elasticsearch "$@"
fi
if [ "$1" = 'elasticsearch' -a "$(id -u)" = '0' ]; then
	chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data
	set -- gosu elasticsearch "$@"
fi
$@ &

/run/miscellaneous/wait_until_started.sh

/run/user/elastic.sh
/run/user/kibana.sh
/run/user/logstash.sh
/run/user/beats.sh

fg