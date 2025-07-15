FROM solr:9.8

ENV TZ="America/Moncton"
ENV SOLR_LOG_LEVEL="warn"
ENV SOLR_OPTS="-Dsolr.config.lib.enabled=true"

COPY build/scripts /scripts

# Silence the verbose logging.
USER root
RUN /scripts/container/setSolrLogLevels.sh ${SOLR_LOG_LEVEL}
USER $SOLR_UID

ENTRYPOINT ["/scripts/run.sh"]

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL ca.unb.lib.generator="solr" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="MIT" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.description="unbscholar.solr.lib.unb.ca provides a solr endpoint for The UNBScholar instance at UNB Libraries." \
  org.label-schema.name="unbscholar.solr.lib.unb.ca" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.vcs-url="https://github.com/unb-libraries/unbscholar.solr.lib.unb.ca" \
  org.label-schema.vendor="University of New Brunswick Libraries" \
  org.label-schema.version=$VERSION \
  org.opencontainers.image.authors="libsupport@unb.ca" \
  org.opencontainers.image.source="https://github.com/unb-libraries/unbscholar.solr.lib.unb.ca"
