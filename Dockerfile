FROM elasticsearch:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch x-pack shield marvel watcher graph"

## install modules
RUN bin/elasticsearch-plugin install x-pack --batch

RUN mkdir -p /.backup
COPY config/elasticsearch.yml /.backup/elasticsearch/config/elasticsearch.yml

ENV ELASTIC_PWD="changeme" \
    KIBANA_PWD="changeme" \
    LOGSTASH_PWD="changeme" \
    BEATS_PWD="changeme" \
    HEAP_SIZE="1g"

ADD ./src/ /run/
RUN chmod +x -R /run/

VOLUME /etc/elasticsearch/config
VOLUME /data

ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["elasticsearch"]
