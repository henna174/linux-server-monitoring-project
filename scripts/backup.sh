#!/bin/bash

SOURCE="/usr/share/nginx/html/linuxproject"
DEST="$HOME/linux-server-monitoring-project/backups"

mkdir -p "$DEST"

DATE=$(date +%F_%H-%M-%S)

tar -czf "$DEST/website_backup_$DATE.tar.gz" -C /usr/share/nginx/html linuxproject

if [ $? -eq 0 ]; then
    echo "Backup completed successfully"
else
    echo "Backup failed"
    exit 1
fi
