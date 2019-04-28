# Elasticsearch & Searchguard Docker Image

## Supported tags and respective `Dockerfile` links

* `5.6.3`,`5.6`, `5` [(5.6/Dockerfile)](https://github.com/Khezen/docker-elasticsearch/blob/5.6/Dockerfile)
* `6.1.3`,`6.1` [(6.1/Dockerfile)](https://github.com/Khezen/docker-elasticsearch/blob/6.1/Dockerfile)
* `6.2.2`,`6.2` [(6.2/Dockerfile)](https://github.com/Khezen/docker-elasticsearch/blob/6.2/Dockerfile)
* `6.5.4`,`6.5` [(6.5/Dockerfile)](https://github.com/Khezen/docker-elasticsearch/blob/6.5/Dockerfile)
* `6.7.1`,`6.7`, `6`, `latest` [(6.7/Dockerfile)](https://github.com/Khezen/docker-elasticsearch/blob/6.7/Dockerfile)[![img not found](https://images.microbadger.com/badges/image/khezen/elasticsearch.svg)](https://hub.docker.com/r/khezen/elasticsearch/)

## What is elasticsearch

Elasticsearch is a distributed, RESTful search and analytics engine capable of solving a growing number of use cases. As the heart of the Elastic Stack, it centrally stores your data so you can discover the expected and uncover the unexpected.
This image uses [search-guard](https://github.com/floragunncom/search-guard) instead of shield to handle trusted users.

[<img src="https://static-www.elastic.co/fr/assets/blt9a26f88bfbd20eb5/icon-elasticsearch-bb.svg?q=802" width="144" height="144">](https://www.elastic.co/fr/products/elasticsearch)

## How To Use

```shell
docker run -d -p 9200:9200 -p 9300:9300 -e ELASTIC_PWD=changeme -e KIBANA_PWD=changeme  khezen/elasticsearch:latest
```

```shell
version: '2'
services:
    elasticsearch:
        image: khezen/elasticsearch:5
        environment:
            ELASTIC_PWD: changeme
            KIBANA_PWD: changeme
        volumes:
            - /data/elasticsearch:/elasticsearch/data
            - /etc/elasticsearch:/elasticsearch/config
        ports:
             - "9200:9200"
             - "9300:9300"
        network_mode: bridge
        restart: always
```

### [File Descriptors and MMap](https://www.elastic.co/guide/en/elasticsearch/guide/current/_file_descriptors_and_mmap.html)

run the following command on your host:

```shell
sysctl -w vm.max_map_count=262144
```

You can set it permanently by modifying `vm.max_map_count` setting in your `/etc/sysctl.conf`.

## Environment Variables

### Miscellaneous

#### LOG_LEVEL | `INFO`

Log level from witch elasticsearch echoes logs.

#### SG_ENTERPRISE_ENABLED | `false`

If **true** then searchguard enterprise features are enabled.
Keep in mind that you need to obtain a commercial license if you want to run this features in production!

### Cluster

#### CLUSTER_NAME | `elasticsearch`

ES cluster name.

#### MINIMUM_MASTER_NODES | `1`

[This setting]((https://www.elastic.co/guide/en/elasticsearch/guide/1.x/_important_configuration_changes.html#_minimum_master_nodes)) tells Elasticsearch to not elect a master unless there are enough master-eligible nodes available. Only then will an election take place.
We recommand to set this variable to `(number of nodes / 2) + 1`

#### HOSTS | `127.0.0.1, [::1]`

List of hosts for node discovery (discovery.zen.ping.unicast.hosts)

### Node

#### NODE_NAME | `NODE-1`

ES cluster name.

#### NODE_MASTER | `true`

Set to true (default) makes it eligible to be elected as the master node, which controls the cluster.

#### NODE_DATA | `true`

Data nodes hold data and perform data related operations such as CRUD, search, and aggregations.

#### NODE_INGEST | `true`

Ingest nodes are able to apply an ingest pipeline to a document in order to transform and enrich the document before indexing. With a heavy ingest load, it makes sense to use dedicated ingest nodes and to mark the master and data nodes as `NODE_INGEST: false`.

#### HTTP_CORS_ENABLE | `true`

Enable or disable cross-origin resource sharing, i.e. whether a browser on another origin can execute requests against Elasticsearch. Note that if the client does not send a pre-flight request with an Origin header or it does not check the response headers from the server to validate the Access-Control-Allow-Origin response header, then cross-origin security is compromised.

#### HTTP_CORS_ALLOW_ORIGIN | `*`

Which origins to allow. Note that `*` is a valid value but is considered a security risk as your elasticsearch instance is open to cross origin requests from anywhere.

#### NETWORK_HOST |`0.0.0.0`

The node will bind to this hostname or IP address and advertise this host to other nodes in the cluster. Accepts an IP address, hostname, a special value, or an array of any combination of these.

### Security & Roles

#### ELASTIC_PWD | `changeme`

password for built-in user *elastic*.

#### KIBANA_PWD | `changeme`

password for built-in user *kibana*.

#### LOGSTASH_PWD | `changeme`

password for built-in user *logstash*.

#### BEATS_PWD | `changeme`

password for built-in user *beats*.

#### CA_PWD | `changeme`

CA certificate passphrase.

#### TS_PWD | `changeme`

Truststore(public keys storage) password.

#### KS_PWD | `changeme`

Keystore(private key storage) password.

#### HTTP_SSL | `true`

* If **true** then **https** is bound on **9200**
* If **false** then **http** is bound on **9200**

## Configure Elasticsearch

Configuration file is located in `/etc/elasticsearch/elasticsearch.yml` if you follow the same volume mapping as in the docker-compose example above.

You can find default config [there](https://github.com/Khezen/docker-elasticsearch/blob/master/config/elasticsearch.yml).

You can find help with elasticsearch configuration [there](https://www.elastic.co/guide/en/elasticsearch/reference/current/settings.html).

## User Feedback

### Issues

If you have any problems with or questions about this image, please ask for help through a [GitHub issue](https://github.com/Khezen/docker-elasticsearch/issues).
