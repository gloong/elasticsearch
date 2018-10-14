FROM bitnami/minideb-extras-base:stretch-r44
LABEL maintainer "Bitnami <containers@bitnami.com>"

ENV BITNAMI_PKG_CHMOD="-R g+rwX" \
    HOME="/" \
    OS_ARCH="amd64" \
    OS_FLAVOUR="debian-9" \
    OS_NAME="linux"

# Install required system packages and dependencies
RUN install_packages libblkid1 libbsd0 libc6 libffi6 libgcc1 libglib2.0-0 libmount1 libpcre3 libselinux1 libstdc++6 libuuid1 libx11-6 libxau6 libxcb1 libxdmcp6 libxext6 zlib1g
RUN . ./libcomponent.sh && component_unpack "java" "1.8.181-1" --checksum 66bba4b4a2647f981339d306da796905c222057c4277a5ef045e079981a404f4
RUN . ./libcomponent.sh && component_unpack "elasticsearch" "5.6.12-0" --checksum 815544507322b21f44c515132e511ef3e027dee25eb9eeff4e84c5ad7625f42d

COPY rootfs /
RUN /prepare.sh
ENV BITNAMI_APP_NAME="elasticsearch" \
    BITNAMI_IMAGE_VERSION="5.6.12-debian-9-r10" \
    ELASTICSEARCH_BIND_ADDRESS="" \
    ELASTICSEARCH_CLUSTER_HOSTS="" \
    ELASTICSEARCH_CLUSTER_NAME="elasticsearch-cluster" \
    ELASTICSEARCH_HEAP_SIZE="1024m" \
    ELASTICSEARCH_IS_DEDICATED_NODE="no" \
    ELASTICSEARCH_MINIMUM_MASTER_NODES="" \
    ELASTICSEARCH_NODE_NAME="" \
    ELASTICSEARCH_NODE_PORT_NUMBER="9300" \
    ELASTICSEARCH_NODE_TYPE="master" \
    ELASTICSEARCH_PLUGINS="analysis-phonetic, analysis-icu" \
    ELASTICSEARCH_PORT_NUMBER="9200" \
    PATH="/opt/bitnami/java/bin:/opt/bitnami/elasticsearch/bin:$PATH"

EXPOSE 9200 9300

USER 1001
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/run.sh" ]
