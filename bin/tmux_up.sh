awk '
  {
    sec = int($1);                     # whole seconds from /proc/uptime
    days = sec / 86400;                # 86400 s = 1 day
    hrs  = (sec % 86400) / 3600;       # remaining hours
    mins = (sec % 3600) / 60;          # remaining minutes
    printf "%dd%02d:%02d\n", days, hrs, mins
  }
' /proc/uptime
