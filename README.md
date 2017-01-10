[![](https://images.microbadger.com/badges/image/khezen/elasticsearch.svg)](https://hub.docker.com/r/khezen/elasticsearch/)
# Supported tags and respective `Dockerfile` links

* `5.0.1`, `5.0`[(5.0/Dockerfile)](https://github.com/Khezen/docker-elasticsearch/blob/5.0/Dockerfile)
* `5.0.1`, `5.1`, `5`, `latest` [(5.1/Dockerfile)](https://github.com/Khezen/docker-elasticsearch/blob/5.1/Dockerfile)


# What is elasticsearch?

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
docker run -d -p 9200:9200 -p 9300:9300 -e ELASTIC_PWD=dockerrocks -e KIBANA_PWD=brucewayne  khezen/elasticsearch:latest   
```

## docker-compose
```
version: '2'
services:
    elasticsearch:
        image: khezen/elasticsearch:5
        environment:
            ELASTIC_PWD: changeme
            KIBANA_PWD: changeme
        volumes:
            - /data/elasticsearch:/usr/share/elasticsearch/data
            - /etc/elasticsearch:/usr/share/elasticsearch/config 
        ports:
             - "9200:9200"
             - "9300:9300"
        network_mode: bridge
        restart: always
```

# Environment Variables

##### CLUSTER_NAME | `elasticsearch`
ES cluster name.

##### HEAP_SIZE | `1g`
Defines the maximum memory allocated to elasticsearch.

##### ELASTIC_PWD | `changeme`
password for built-in user *elastic*.

##### KIBANA_PWD | `changeme`
password for built-in user *kibana*.

##### LOGSTASH_PWD | `changeme`
password for built-in user *logstash*.

##### BEATS_PWD | `changeme`
password for built-in user *beats*.

##### CA_PWD | `changeme`
CA certificate passphrase.

##### TS_PWD | `changeme`
Truststore(public keys storage) password.

##### KS_PWD | `changeme`
Keystore(private key storage) password.


# Configure Elasticsearch

Configuration file is located in `/etc/elasticsearch/elasticsearch.yml` if you follow the same volume mapping as in the docker-compose example above.

You can find default config [there](https://github.com/Khezen/docker-elasticsearch/blob/master/config/elasticsearch.yml).

You can find help with elasticsearch configuration [there](https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html).

# User Feedback
## Issues
If you have any problems with or questions about this image, please ask for help through a [GitHub issue](https://github.com/Khezen/docker-elasticsearch/issues).