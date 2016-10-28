#!/bin/bash

set -m

/docker-entrypoint.sh "$@" &

if [ "$admin" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $admin -p $admin_pwd -r admin
fi

if [ "$power_user" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $power_user -p $power_user_pwd -r power_user
fi

if [ "$user" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $user -p $user_pwd -r user
fi

if [ "$kibana_server" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $kibana_server -p $kibana_server_pwd -r kibana_server
fi

if [ "$kibana_user" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $kibana_user -p $kibana_pwd -r kibana
fi

if [ "$logstash_user" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $logstash_user -p $logstash_pwd -r logstash
fi

if [ "$marvel_user" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $marvel_user -p $marvel_pwd -r marvel_user
fi

if [ "$watcher_admin" != "" ]; then
    /usr/share/elasticsearch/bin/x-pack/users useradd $watcher_admin -p $watcher_admin_pwd -r watcher_admin
fi

fg