#!/bin/bash

curl -XPOST -u "elastic:$ELASTIC_PWD" "$HOSTNAME:9200/_xpack/security/role/elastalert_user" -d "{
 \"cluster\": [\"all\"],
  \"indices\": [
    {
      \"names\": [ \"*elastalert_status-*\" ],
     \"privileges\": [
          \"write\", 
          \"delete\", 
          \"create_index\", 
          \"read\"
       ]
    }
  ]
}"


curl -XPOST -u "elastic:$ELASTIC_PWD" "$HOSTNAME:9200/_xpack/security/user/elastalert" -d "{
  \"password\" : \"$ELASTALERT_PWD\",
  \"roles\": [\"elastalert_user\"]
}"