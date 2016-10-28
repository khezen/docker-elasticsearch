FROM elasticsearch:5.0

MAINTAINER Guillaume Simonneau <simonneaug@gmail.com>
LABEL Description="elasticsearch shield marvel watcher graph"

## install modules
RUN bin/elasticsearch-plugin install x-pack --batch

COPY config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
#COPY config/roles.yml /etc/elasticsearch/x-pack/roles.yml

ENV superuser="admin" \
    superuser_pwd="changeme" \
    kibanauser="kibana" \
    kibanauser_pwd="changeme" \
    heap_size="1g"

RUN mkdir -p /config
ADD ./src/entrypoint.sh /run/entrypoint.sh
RUN chmod +x /run/entrypoint.sh
ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["elasticsearch"]
