#!/bin/bash

curl -XPOST -u "elastic:$elastic_pwd" "$HOSTNAME:9200/_xpack/security/role/beats_user" -d "{
 \"cluster\": [\"all\"],
  \"indices\": [
    {
      \"names\": [ \"*beat-*\" ],
     \"privileges\": [
          \"write\", 
          \"delete\", 
          \"create_index\", 
          \"read\"
       ]
    }
  ]
}"


curl -XPOST -u "elastic:$elastic_pwd" "$HOSTNAME:9200/_xpack/security/user/beats" -d "{
  \"password\" : \"$beats_pwd\",
  \"roles\": [\"beats_user\"]
}"