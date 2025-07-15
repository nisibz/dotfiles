#!/bin/bash

# Get CPU usage percentage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')

# Ensure it has % sign
if [[ "$CPU_USAGE" != *"%" ]]; then
  CPU_USAGE="${CPU_USAGE}%"
fi

# Remove % sign and convert to integer for comparison
CPU_NUM=$(echo "$CPU_USAGE" | sed 's/%//' | cut -d'.' -f1)

# Color based on CPU usage
if [ "$CPU_NUM" -ge 80 ]; then
  COLOR="colour196" # Red
elif [ "$CPU_NUM" -ge 60 ]; then
  COLOR="colour208" # Orange
elif [ "$CPU_NUM" -ge 40 ]; then
  COLOR="colour226" # Yellow
elif [ "$CPU_NUM" -ge 20 ]; then
  COLOR="colour154" # Light green
else
  COLOR="colour255" # White
fi

echo "#[fg=$COLOR]$CPU_USAGE#[fg=colour244]"

