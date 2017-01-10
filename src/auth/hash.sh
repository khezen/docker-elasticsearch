#!/bin/bash

pwd=$(/usr/share/elasticsearch/plugins/search-guard-5/tools/hash.sh -p $2)
sed -ri "s/\$1:[^\r\n]*/$1: $pwd/" /usr/share/elasticsearch/config/searchguard/sg_internal_users.yml