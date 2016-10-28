#!/bin/bash

set -m

# perf tweak
sysctl -w vm.max_map_count=262144
sysctl -w vm.swappiness=1
export ES_JAVA_OPTS="-Xms$heap_size -Xmx$heap_size"


/docker-entrypoint.sh "$@" &

if [ "$superuser" != "" ] && [ ! -f /config/.admin_created ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $superuser -p $superuser_pwd -r superuser
    touch /config/.admin_created
fi

if [ "$kibanauser" != "" ] && [ ! -f /config/.kibana_user_created ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $kibanauser -p $kibanauser_pwd -r kibana_user
    touch /config/.kibana_user_created
fi

fg