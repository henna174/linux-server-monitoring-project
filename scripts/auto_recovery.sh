
#!/bin/bash

SERVICE="nginx"

# Automatically identify project directory
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# Define log directory and file
LOG_DIR="$PROJECT_DIR/logs"
LOG_FILE="$LOG_DIR/recovery.log"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Check Nginx service
if ! systemctl is-active --quiet "$SERVICE"; then

    echo "$(date): $SERVICE is down. Restarting..." >> "$LOG_FILE"

    systemctl restart "$SERVICE"

    if systemctl is-active --quiet "$SERVICE"; then
        echo "$(date): $SERVICE recovered successfully" >> "$LOG_FILE"
    else
        echo "$(date): Recovery failed" >> "$LOG_FILE"
    fi

else
    echo "$(date): $SERVICE is running normally" >> "$LOG_FILE"
fi
