[![](https://images.microbadger.com/badges/image/khezen/elasticsearch.svg)](https://hub.docker.com/r/khezen/elasticsearch/)
# Supported tags and respective `Dockerfile` links

* `2.4.0`, `2.4`, `2` [(2.4/Dockerfile)](https://github.com/Khezen/docker-elasticseach/blob/2.4/Dockerfile)
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

##### admin | `admin`
Admin user. See roles section to see his permissions.

##### admin_pwd | `changeme`
Admin password

##### power_user | `power-user`
Power user. See roles section to see his permissions.

##### power_user_pwd | `changeme`
Power user password

##### user | `user`
Standard user. See roles section to see his permissions.

##### user_pwd | `changeme`
User password

## Kibana
[configure kibana to use shield](https://www.elastic.co/guide/en/shield/current/kibana.html)

##### kibana_server | `kibana-server`
Kibana server user. See roles section to see his permissions.

##### kibana_server_pwd | `changeme`
Kibana server password

##### kibana | `kibana`
Kibana user. See roles section to see his permissions.

##### kibana_pwd | `changeme`
Kibana password

## Logstash
[configure logstash to use shield](https://www.elastic.co/guide/en/shield/current/logstash.html)

##### logstash_user | `logstash`
Logstash user. See roles section to see his permissions.

##### logstash_pwd | `changeme`
Logstash password

## Marvel
[configure marvel](https://www.elastic.co/guide/en/marvel/current/configuration.html)

##### marvel_user | `marvel`
Marvel user. See roles section to see his permissions.

##### marvel_pwd | `changeme`
Marvel password

##### remote_marvel_agent | `marvel-agent`
Remote marvel agent user. See roles section to see his permissions.

##### remote_marvel_agent_pwd | `changeme`
Remote marvel agent password

## Watcher
[configure watcher](https://www.elastic.co/guide/en/watcher/current/email-services.html)

##### watcher_admin | `watcher-admin`
Watcher admin user. See roles section to see his permissions.

##### watcher_admin_pwd | `changeme`
Watcher admin password


# Roles

```
# All cluster rights
# All operations on all indices
admin:
  cluster:
    - all
  indices:
    - names: '*'
      privileges:
        - all

# monitoring cluster privileges
# All operations on all indices
power_user:
  cluster:
    - monitor
  indices:
    - names: '*'
      privileges:
        - all

# Read-only operations on indices
user:
  indices:
    - names: '*'
      privileges:
        - read

# Defines the required permissions for transport clients
transport_client:
  cluster:
      - transport_client

# The required permissions for the kibana 4 server
kibana4_server:
  cluster:
      - monitor
  indices:
    - names: '.kibana'
      privileges:
        - all

# The required permissions for a kibana admin
kibana:
  cluster:
      - monitor
  indices:
    - names: 'logstash-*'
      privileges:
        - all
    - names: '.kibana*' 
      privileges:
        - all

# The required role for logstash users
logstash:
  cluster:
    - manage_index_templates
  indices:
    - names: 'logstash-*'
      privileges:
        - write
        - delete
        - create_index

# Marvel user role. Assign to marvel users.
marvel_user:
  indices:
    - names: '.marvel-es-*'
      privileges: [ "read" ]
    - names: '.kibana'
      privileges:
        - view_index_metadata
        - read

# Marvel remote agent role. Assign to the agent user on the remote marvel cluster
# to which the marvel agent will export all its data
remote_marvel_agent:
  cluster: [ "manage_index_templates" ]
  indices:
    - names: '.marvel-es-*'
      privileges: [ "all" ]

# Watcher admin role.
watcher_admin:
  cluster: [ "monitor", "manage" ]
  indices:
    - names: [ ".watches", ".triggered_watches" ,".watcher-history*" ]
      privileges: [ "all" ]
```

# User Feedback
## Issues
If you have any problems with or questions about this image, please ask for help through a [GitHub issue](https://github.com/Khezen/docker-elasticsearch/issues).