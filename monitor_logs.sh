#!/bin/bash
export TZ="Asia/Kolkata"

LOG_FILE="/var/log/nginx/access.log"
OUTPUT="/var/log/custom-log-monitor.log"
PUBLIC_COPY="/usr/share/nginx/html/logs/monitor.log"

ERROR_COUNT=$(grep -i "error" "$LOG_FILE" 2>/dev/null | wc -l)
RESPONSE_500=$(grep " 500 " "$LOG_FILE" 2>/dev/null | wc -l)

{
  echo "--------- $(date) ---------"
  echo "Total Errors: $ERROR_COUNT"
  echo "HTTP 500 Responses: $RESPONSE_500"
  echo ""
} >> "$OUTPUT"

cp "$OUTPUT" "$PUBLIC_COPY"
