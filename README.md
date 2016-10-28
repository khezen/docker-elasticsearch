[![](https://images.microbadger.com/badges/image/khezen/elasticsearch.svg)](https://hub.docker.com/r/khezen/elasticsearch/)
# Supported tags and respective `Dockerfile` links

* `5.0.0`, `5.0`, `5`, `latest` [(5.0/Dockerfile)](https://github.com/Khezen/docker-elasticseach/blob/5.0/Dockerfile)

# What is elasticseach?

Elasticsearch is a distributed, RESTful search and analytics engine capable of solving a growing number of use cases. As the heart of the Elastic Stack, it centrally stores your data so you can discover the expected and uncover the unexpected.

[<img src="https://static-www.elastic.co/fr/assets/blt9a26f88bfbd20eb5/icon-elasticsearch-bb.svg?q=802" width="144" height="144">](https://www.elastic.co/fr/products/elasticsearch)

# How To Use

## [File Descriptors and MMap](https://www.elastic.co/guide/en/elasticsearch/guide/current/_file_descriptors_and_mmap.html)

run the following command on your host:
```
sysctl -w vm.max_map_count=262144
```
You can set it permanently by modifying `vm.max_map_count` setting in your `/etc/sysctl.conf`.

## docker engine
```
docker run -d -p 9200:9200 -p 9300:9300 -e admin=changeme -e admin_pwd=changeme  khezen/elasticsearch:latest   
```
## docker-compose
```
version: '2'
services:
    elasticsearch:
        image: khezen/elasticsearch:5.0
        environment:
            admin: admin
            admin_pwd: changeme
            kibana_server: kibana-server
            kibana_server_pwd: changeme
            kibana_user: kibana
            kibana_pwd: changeme
            logstash_user: logstash
            logstash_pwd: changeme
        ports:
             - "9200:9200"
             - "9300:9300"
        network_mode: bridge
        restart: always
```

# Environment Variables

## Elasticseach

##### heap_size | `1g`
Defines the maximum memory allocated to elasticsearch.

##### superuser | `admin`
Admin user. See roles section to see his permissions.

##### superuser_pwd | `changeme`
Admin password

## Kibana
[configure kibana to use shield](https://www.elastic.co/guide/en/shield/current/kibana.html)

##### kibanauser | `kibanauser`
Kibana user. See roles section to see his permissions.

##### kibanauser_pwd | `changeme`
Kibana password

# User Feedback
## Issues
If you have any problems with or questions about this image, please ask for help through a [GitHub issue](https://github.com/Khezen/docker-elasticsearch/issues).