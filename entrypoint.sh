#!/bin/bash

set -m

# perf tweak
sysctl -w vm.max_map_count=262144
sysctl -w vm.swappiness=1
export ES_JAVA_OPTS="-Xms$heap_size -Xmx$heap_size"


/docker-entrypoint.sh "$@" &

if [ "$admin" != "" ] && [ ! -f /config/.admin_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $admin -p $admin_pwd -r admin
    touch /config/.admin_created
fi

if [ "$power_user" != "" ] && [ ! -f /config/.power_user_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $power_user -p $power_user_pwd -r power_user
    touch /config/.power_user_created
fi

if [ "$user" != "" ] && [ ! -f /config/.user_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $user -p $user_pwd -r user
    touch /config/.user_created
fi

if [ "$kibana_server" != "" ] && [ ! -f /config/.kibana_server_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $kibana_server -p $kibana_server_pwd -r kibana_server
    touch /config/.kibana_server_created
fi

if [ "$kibana_user" != "" ] && [ ! -f /config/.kibana_user_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $kibana_user -p $kibana_pwd -r kibana
    touch /config/.kibana_user_created
fi

if [ "$logstash_user" != "" ] && [ ! -f /config/.logstash_user_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $logstash_user -p $logstash_pwd -r logstash
    touch /config/.logstash_user_created
fi

if [ "$marvel_user" != "" ] && [ ! -f /config/.marvel_user_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $marvel_user -p $marvel_pwd -r marvel_user
    touch /config/.marvel_user_created
fi

if [ "$watcher_admin" != "" ] && [ ! -f /config/.watcher_admin_created ]; then
    /usr/share/elasticsearch/bin/shield/eusers useradd $watcher_admin -p $watcher_admin_pwd -r watcher_admin
    touch /config/.watcher_admin_created
fi

fg