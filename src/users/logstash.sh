#!/bin/bash

curl -XPOST -u "elastic:$elastic_pwd" "$HOSTNAME:9200/_xpack/security/role/logstash_user" -d "{
 \"cluster\": [\"all\"],
  \"indices\": [
    {
      \"names\": [ \"logstash-*\" ],
      \"privileges\": [
          \"write\", 
          \"delete\", 
          \"create_index\", 
          \"read\"
        ]
    }
  ]
}"


curl -XPOST -u "elastic:$elastic_pwd" "$HOSTNAME:9200/_xpack/security/user/logstash" -d "{
  \"password\" : \"$logstash_pwd\",
  \"roles\": [\"logstash_user\"]
}"