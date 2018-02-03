# Pull base image.
FROM openjdk:8-jre
ENV ELASTICSEARCH_VERSION elasticsearch-5.6.7
ENV ELASTICSEARCH_PATH /usr/share/elasticsearch
# Install Elasticsearch.
RUN \
  mkdir -p $ELASTICSEARCH_PATH && \
  cd / && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/$ELASTICSEARCH_VERSION.tar.gz && \
  tar xvzf $ELASTICSEARCH_VERSION.tar.gz && \
  rm -f $ELASTICSEARCH_VERSION.tar.gz && \
  mv $ELASTICSEARCH_VERSION $ELASTICSEARCH_PATH
# Define mountable directories.
VOLUME ["$ELASTICSEARCH_PATH/data"]
# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml
# Define working directory.
WORKDIR $ELASTICSEARCH_PATH
# Define default command.
CMD ["$ELASTICSEARCH_PATH/bin/elasticsearch"]
# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300