FROM elasticsearch:5.3.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch searchguard search-guard"

EXPOSE 9200 9300

# install modules
RUN bin/elasticsearch-plugin install -b com.floragunn:search-guard-5:5.3.0-11-20170329.222527-2

# retrieve conf
COPY config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY config/searchguard/ /usr/share/elasticsearch/config/searchguard/

# backup conf
RUN mkdir -p /.backup/elasticsearch/ \
&&  mv /usr/share/elasticsearch/config /.backup/elasticsearch/config

ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /usr/hare/elasticsearch/config
VOLUME /usr/hare/elasticsearch/dara

# env
ENV CLUSTER_NAME="elasticsearch-default" \
    MINIMUM_MASTER_NODES=1 \
    HOSTS="['127.0.0.1', '[::1]']" \
    NODE_NAME=$HOSTNAME \
    NODE_MASTER=true \
    NODE_DATA=true \
    NODE_INGEST=true \
    HTTP_ENABLE=true \
    HTTP_CORS_ENABLE=true \
    HTTP_CORS_ALLOW_ORIGIN=* \
    NETWORK_HOST="0.0.0.0" \
    ELASTIC_PWD="changeme" \
    KIBANA_PWD="changeme" \
    LOGSTASH_PWD="changeme" \
    BEATS_PWD="changeme" \
    HEAP_SIZE="1g" \
    CA_PWD="changeme" \
    TS_PWD="changeme" \
    KS_PWD="changeme"

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["elasticsearch"]
