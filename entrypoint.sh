#!/bin/sh

set -e

if [ "$admin" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $admin -p $admin_pwd -r admin
fi

if [ "$power_user" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $power_user -p $power_user_pwd -r power_user
fi

if [ "$user" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $user -p $user_pwd -r user
fi

if [ "$kibana_server" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $kibana_server -p $kibana_server_pwd -r kibana4_server
fi

if [ "$kibana_user" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $kibana_user -p $kibana_pwd -r kibana
fi

if [ "$logstash_user" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $logstash_user -p $logstash_pwd -r logstash
fi

if [ "$marvel_user" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $marvel_user -p $marvel_pwd -r marvel_user
fi

if [ "$remote_marvel_agent" != "" ]; then
    /usr/share/elasticsearch/bin/shield/esusers useradd $remote_marvel_agent -p $remote_marvel_agent_pwd -r remote_marvel_agent
fi


exec /docker-entrypoint.sh "$@"