#!/bin/bash

echo "===== SERVER HEALTH REPORT ====="

echo "Date:"
date

echo "Hostname:"
hostname

echo "Uptime:"
uptime

echo "CPU and Load:"
cat /proc/loadavg

echo "Memory Usage:"
free -h

echo "Disk Usage:"
df -h

echo "Top Processes:"
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo "Nginx Status:"
systemctl is-active nginx

echo "===== REPORT COMPLETED ====="
