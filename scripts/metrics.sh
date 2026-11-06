
#!/bin/bash

WEB_DIR="/usr/share/nginx/html/linuxproject"
OUTPUT="$WEB_DIR/status.json"

# CPU usage calculation
read cpu user nice system idle iowait irq softirq steal rest < /proc/stat
IDLE1=$((idle + iowait))
TOTAL1=$((user + nice + system + idle + iowait + irq + softirq + steal))

sleep 1

read cpu user nice system idle iowait irq softirq steal rest < /proc/stat
IDLE2=$((idle + iowait))
TOTAL2=$((user + nice + system + idle + iowait + irq + softirq + steal))

CPU=$(awk -v i1="$IDLE1" -v i2="$IDLE2" \
-v t1="$TOTAL1" -v t2="$TOTAL2" \
'BEGIN { if(t2==t1) print 0; else printf "%.1f", (1-(i2-i1)/(t2-t1))*100 }')

# RAM usage
RAM=$(free | awk '/Mem:/ {printf "%.1f", $3/$2*100}')

# Disk usage
DISK=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

# Nginx service status
NGINX=$(systemctl is-active nginx 2>/dev/null || echo "inactive")

# Other server information
HOST=$(hostname)
OS=$(source /etc/os-release && echo "$PRETTY_NAME")
UPTIME=$(uptime -p)
UPDATED=$(date '+%Y-%m-%d %H:%M:%S')

# Generate JSON
umask 022

cat > "$OUTPUT.tmp" <<EOF
{
  "hostname": "$HOST",
  "os": "$OS",
  "cpu": "$CPU",
  "ram": "$RAM",
  "disk": "$DISK",
  "nginx": "$NGINX",
  "uptime": "$UPTIME",
  "updated": "$UPDATED"
}
EOF

mv "$OUTPUT.tmp" "$OUTPUT"
