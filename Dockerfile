FROM openjdk:8-jre-alpine as build
ENV ES_TMPDIR "/tmp"
ENV ES_VERSION 6.7.1
ENV SG_VERSION "25.0"
ENV DOWNLOAD_URL "https://artifacts.elastic.co/downloads/elasticsearch"
ENV ES_TARBAL "${DOWNLOAD_URL}/elasticsearch-${ES_VERSION}.tar.gz"
# Install Elasticsearch.
RUN apk add --no-cache --update bash ca-certificates su-exec util-linux curl openssl rsync tar
RUN apk add --no-cache -t .build-deps gnupg
RUN mkdir /install \
&&  cd /install
RUN echo "${ES_TARBAL}"
RUN curl -o elasticsearch.tar.gz -Lkj "${ES_TARBAL}"; 
RUN tar -xzvf elasticsearch.tar.gz
RUN mv elasticsearch-$ES_VERSION /elasticsearch
# Install searchguard
RUN /elasticsearch/bin/elasticsearch-plugin install -b "com.floragunn:search-guard-6:$ES_VERSION-$SG_VERSION"
# Cleanup install
RUN rm -rf /install \
&&  rm /elasticsearch/config/elasticsearch.yml \
&&  rm -rf /elasticsearch/modules/x-pack-ml \
&&  rm -rf /elasticsearch/modules/x-pack-security \
&&  apk del --purge .build-deps
# Copy default config
RUN  mkdir -p /.backup/elasticsearch/
COPY config /.backup/elasticsearch/config
COPY ./src/ /run/
RUN chmod +x -R /run/

FROM openjdk:8-jre-alpine
LABEL maintainer="Guillaume Simonneau <simonneaug@gmail.com>"
LABEL description="elasticsearch search-guard"
RUN apk add --no-cache --update bash ca-certificates su-exec openssl rsync curl
COPY --from=build /elasticsearch /elasticsearch
COPY --from=build /run /run
COPY --from=build /.backup/elasticsearch/config /.backup/elasticsearch/config
# set user
RUN adduser -DH -s /sbin/nologin elasticsearch \
  && for path in \
    /elasticsearch/config \
    /elasticsearch/config/scripts \
    /elasticsearch/plugins \
  ; do \
    mkdir -p "$path"; \
    chown -R elasticsearch:elasticsearch "$path"; \
  done
ENV PATH="/elasticsearch/bin:$PATH" \
    CLUSTER_NAME="elasticsearch-default" \
    MINIMUM_MASTER_NODES=1 \
    HOSTS="127.0.0.1, [::1]" \
    NODE_NAME=NODE-1 \
    NODE_MASTER=true \
    NODE_DATA=true \
    NODE_INGEST=true \
    HTTP_CORS_ENABLE=true \
    HTTP_CORS_ALLOW_ORIGIN=* \
    NETWORK_HOST="0.0.0.0" \
    ELASTIC_PWD="changeme" \
    KIBANA_PWD="changeme" \
    LOGSTASH_PWD="changeme" \
    BEATS_PWD="changeme" \
    CA_PWD="changeme" \
    TS_PWD="changeme" \
    KS_PWD="changeme" \
		HTTP_SSL=true \
    LOG_LEVEL=INFO \
    SG_ENTERPRISE_ENABLED=false
VOLUME /elasticsearch/config
VOLUME /elasticsearch/data
EXPOSE 9200 9300
ENTRYPOINT ["/run/entrypoint.sh"]
CMD ["elasticsearch"]