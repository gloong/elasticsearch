FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.11

RUN bin/elasticsearch-plugin remove x-pack --purge

# Install ElasticSuite requirements (https://github.com/Smile-SA/elasticsuite/wiki/ModuleInstall)
RUN \
    elasticsearch-plugin install analysis-icu && \
    elasticsearch-plugin install analysis-phonetic
