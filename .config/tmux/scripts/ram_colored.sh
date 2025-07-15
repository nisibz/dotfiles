#!/bin/bash

# Get RAM usage percentage
RAM_USAGE=$(free | grep Mem | awk '{printf "%.1f%%", $3/$2 * 100.0}')

# Extract numeric value
RAM_NUM=$(echo "$RAM_USAGE" | sed 's/%//' | cut -d'.' -f1)

# Color based on RAM usage
if [ "$RAM_NUM" -ge 80 ]; then
    COLOR="colour196"  # Red
elif [ "$RAM_NUM" -ge 60 ]; then
    COLOR="colour208"  # Orange
elif [ "$RAM_NUM" -ge 40 ]; then
    COLOR="colour226"  # Yellow
elif [ "$RAM_NUM" -ge 20 ]; then
    COLOR="colour154"  # Light green
else
    COLOR="colour255"  # White
fi

echo "#[fg=$COLOR]$RAM_USAGE#[fg=colour244]"