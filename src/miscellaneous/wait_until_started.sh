#!/bin/bash
pingElasticSuccess() {
    local failurecode=${2:-404}
    local status=$(curl --head --location --silent --connect-timeout 5 --write-out %{http_code} --output /dev/null -XGET -k -u "elastic:$ELASTIC_PWD" "$http://localhost:9200/")
    [[ $status != ${failurecode} ]] && [[ $status != 000 ]]
}

pollElasticsearch(){
  local ret=1
  local http="http"
  if [ "$HTTP_SSL" = "true" ]; then
    http="https"
  fi
  while [[ ret -ne 0 ]]; do
      echo "Stalling for Elasticsearch..."
      pingElasticSuccess && ret=0
      sleep 5
  done
}

 pollElasticsearch

