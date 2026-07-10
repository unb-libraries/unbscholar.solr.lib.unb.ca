FROM solr:8.11

ENV TZ="America/Moncton"
ENV SOLR_LOG_LEVEL="warn"

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
  org.opencontainers.image.title="unbscholar.solr.lib.unb.ca" \
  org.opencontainers.image.description="unbscholar.solr.lib.unb.ca provides a solr endpoint for The UNBScholar instance at UNB Libraries." \
  org.opencontainers.image.vendor="University of New Brunswick Libraries" \
  org.opencontainers.image.authors="UNB Libraries <libsupport@unb.ca>" \
  org.opencontainers.image.source="https://github.com/unb-libraries/unbscholar.solr.lib.unb.ca" \
  org.opencontainers.image.version="$VERSION" \
  org.opencontainers.image.revision="$VCS_REF" \
  org.opencontainers.image.created="$BUILD_DATE"
