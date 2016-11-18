FROM centos:centos7

MAINTAINER Rick Alm <rickalm@aol.com>

ENV \
  DIST_MIRROR=http://mirror.cc.columbia.edu/pub/software/apache/nifi \
  NIFI_HOME=/opt/nifi \
  VERSION=1.0.0 \
  TEST=

# Install necessary packages, create target directory, download and extract, and update the banner to let people know what version they are using
RUN \
  yum update -y \
    || exit 1; \
  \
  yum install -y java-1.8.0-openjdk tar \
    || exit 1; \
  \
  mkdir -p /opt/nifi \
    || exit 1; \
  \
  curl ${DIST_MIRROR}/${VERSION}/nifi-${VERSION}-bin.tar.gz | tar xvz -C ${NIFI_HOME} --strip-components=1 \
    || exit 1; \
  \
  sed -i -e "s|^nifi.ui.banner.text=.*$|nifi.ui.banner.text=Docker NiFi ${VERSION}|" ${NIFI_HOME}/conf/nifi.properties \
    || exit 1; \
  \
  yum clean all \
    || exit 1; \
  \
  /bin/true

VOLUME [ \
  "/opt/certs", \
  "${NIFI_HOME}/flowfile_repository", \
  "${NIFI_HOME}/database_repository", \
  "${NIFI_HOME}/content_repository", \
  "${NIFI_HOME}/provenance_repository" \
  ]

ADD ./sh/ /opt/sh

CMD ["/opt/sh/start.sh"]
