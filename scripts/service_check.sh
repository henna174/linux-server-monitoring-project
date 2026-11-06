#!/bin/bash

SERVICE="nginx"

if systemctl is-active --quiet "$SERVICE"; then
    echo "$SERVICE is RUNNING"
else
    echo "$SERVICE is STOPPED"
fi
