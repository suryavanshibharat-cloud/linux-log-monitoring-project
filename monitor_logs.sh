#!/bin/bash
export TZ="Asia/Kolkata"

# ~/scripts/monitor_logs.sh
LOG_FILE="/var/log/nginx/access.log"
OUTPUT="/var/log/custom-log-monitor.log"
PUBLIC_COPY="/usr/share/nginx/html/logs/monitor.log"

# read/parse log safely
if [ ! -f "$LOG_FILE" ]; then
  ERROR_COUNT=0
  RESPONSE_500=0
else
  ERROR_COUNT=$(grep -i "error" "$LOG_FILE" 2>/dev/null | wc -l)
  RESPONSE_500=$(grep " 500 " "$LOG_FILE" 2>/dev/null | wc -l)
fi

{
  echo "--------- $(date) ---------"
  echo "Total errors: $ERROR_COUNT"
  echo "HTTP 500 responses: $RESPONSE_500"
  echo ""
} >> "$OUTPUT"

# copy the monitoring output to web root (safe, read-only for visitors)
# ensure the destination folder exists and is writable by this user (chown done earlier)
cp "$OUTPUT" "$PUBLIC_COPY" 2>/dev/null || { echo "Failed to copy to $PUBLIC_COPY" >&2; }

# optional: also export the raw nginx access.log (trimmed last N lines) for viewing
# keep just last 1000 lines to avoid huge file
tail -n 1000 "$LOG_FILE" > /usr/share/nginx/html/logs/access-last1000.log 2>/dev/null || true
