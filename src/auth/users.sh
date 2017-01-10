#!/bin/bash
/run/auth/hash.sh "elastic.hash" "$ELASTIC_PWD"
/run/auth/hash.sh "kibana.hash" "$KIBANA_PWD"
/run/auth/hash.sh "logstash.hash" "$LOGSTASH_PWD"
/run/auth/hash.sh "beats.hash" "$BEATS_PWD"