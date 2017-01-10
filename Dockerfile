FROM elasticsearch:5.1

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch searchguard search-guard"

# env
ENV CLUSTER_NAME="elasticsearch" \
    ELASTIC_PWD="changeme" \
    KIBANA_PWD="changeme" \
    LOGSTASH_PWD="changeme" \
    BEATS_PWD="changeme" \
    HEAP_SIZE="1g" \
    CA_PWD="changeme" \
    TS_PWD="changeme" \
    KS_PWD="changeme"

## install modules
RUN bin/elasticsearch-plugin install -b com.floragunn:search-guard-5:5.1.1-9

# retrieve conf
COPY config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY config/searchguard/ /usr/share/elasticsearch/config/searchguard/

## ssl
ADD ./src/ /run/
RUN chmod +x -R /run/ \
&&  /run/auth/certificates/gen_all.sh

# backup conf
RUN mkdir -p /.backup/elasticsearch/ \
&&  mv /usr/share/elasticsearch/config /.backup/elasticsearch/config

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["elasticsearch"]
