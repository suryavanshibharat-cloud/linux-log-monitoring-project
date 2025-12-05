
---

## 🛠️ Tech Stack  
- **AWS EC2 (Amazon Linux 2023)**
- **Nginx Web Server**
- **Shell Scripting (Bash)**
- **Cron for automation**
- **HTML + CSS + JavaScript** (simple log viewer)

---

## 📜 monitor_logs.sh — Script Overview

```bash
#!/bin/bash
export TZ="Asia/Kolkata"

LOG_FILE="/var/log/nginx/access.log"
OUTPUT="/var/log/custom-log-monitor.log"
PUBLIC_COPY="/usr/share/nginx/html/logs/monitor.log"

if [ ! -f "$LOG_FILE" ]; then
  ERROR_COUNT=0
  RESPONSE_500=0
else
  ERROR_COUNT=$(grep -i "error" "$LOG_FILE" | wc -l)
  RESPONSE_500=$(grep " 500 " "$LOG_FILE" | wc -l)
fi

{
  echo "--------- $(date) ---------"
  echo "Total Errors: $ERROR_COUNT"
  echo "HTTP 500 Responses: $RESPONSE_500"
  echo ""
} >> "$OUTPUT"

cp "$OUTPUT" "$PUBLIC_COPY"
# linux-log-monitoring-project
