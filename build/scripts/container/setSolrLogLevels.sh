#!/bin/bash
LOG_LEVEL=${1:-"warn"}
CONFIG_FILE="/opt/solr/server/resources/log4j2.xml"
TEMP_FILE="${CONFIG_FILE}.tmp"

sed -i "s/<Root level=\"info\">/<Root level=\"$LOG_LEVEL\">/" "$CONFIG_FILE"
sed -i "s/<AsyncRoot level=\"info\">/<AsyncRoot level=\"$LOG_LEVEL\">/" "$CONFIG_FILE"

INSERTION=$(cat <<EOF
    <AsyncLogger name="org.apache.solr" level="$LOG_LEVEL"/>
EOF
)

awk -v insert="$INSERTION" '
  $0 ~ /<AsyncLogger name="org.apache.hadoop"/ {
    print insert
  }
  { print }
' "$CONFIG_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$CONFIG_FILE"

echo "Log levels set to $LOG_LEVEL in $CONFIG_FILE"
