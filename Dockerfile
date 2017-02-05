FROM elasticsearch:5.1

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch searchguard search-guard"

# env
ENV CLUSTER_NAME="elasticsearch" \
    HOSTS="[127.0.0.1]" \
    MINIMUM_MASTER_NODES=1 \
    ELASTIC_PWD="changeme" \
    KIBANA_PWD="changeme" \
    LOGSTASH_PWD="changeme" \
    BEATS_PWD="changeme" \
    HEAP_SIZE="1g" \
    CA_FILE="/etc/ssl/ca/elastic-ca.pem" \
    TRUSTORE_FILE="/etc/ssl/trustore.jks" \
    KEYSTORE_FILE="/etc/ssl/keystore.jks"

# install modules
RUN bin/elasticsearch-plugin install -b com.floragunn:search-guard-5:5.1.2-10

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

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["elasticsearch"]
