#!/bin/bash

THRESHOLD=80

df -P -h | awk 'NR>1 {
    usage=$5
    gsub("%","",usage)

    if (usage >= 80) {
        print "WARNING: High disk usage on " $6 ": " usage "%"
    }
}'
