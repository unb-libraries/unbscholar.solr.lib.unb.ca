#!/bin/bash
for i in /scripts/pre-init.d/*sh
do
 if [[ -e "${i}" ]]; then
   echo "[i] pre-init.d - processing $i"
   . "${i}"
 fi
done

cp -R /opt/solr/server/solr/* "$SOLR_HOME"

docker-entrypoint.sh solr-foreground
