awk '{print $1}' /proc/uptime | xargs -I{} date -d@{} -u +%H:%M
