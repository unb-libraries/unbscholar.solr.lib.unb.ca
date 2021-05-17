#!/bin/bash
for i in /scripts/pre-init.d/*sh
do
 if [[ -e "${i}" ]]; then
   echo "[i] pre-init.d - processing $i"
   . "${i}"
 fi
done

/opt/docker-solr/scripts/init-var-solr
/opt/docker-solr/scripts/precreate-core initalcore

docker-entrypoint.sh solr-foreground
