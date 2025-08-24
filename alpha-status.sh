#!/bin/bash

# Function to draw system info header
draw_header() {
    tput sc                # Save cursor position
    tput cup 0 0           # Go to top-left

    # Clear 8 lines (in case old data lingers)
    for i in {0..7}; do
        tput cup $i 0
        printf "%-80s" " "
    done

    tput cup 0 0; echo "User: $USER"
    tput cup 1 0; echo "Date: $(date +"%Y-%m-%d")"
    tput cup 2 0; echo "Time: $(date +"%H:%M:%S")"
    tput cup 3 0; echo "Path: $(pwd)"

    # CPU usage
    cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"%"}')
    tput cup 4 0; echo "CPU Usage: $cpu"

    # RAM usage
    ram=$(free -h | awk '/Mem:/ {print $3 " / " $2}')
    tput cup 5 0; echo "RAM Usage: $ram"

    # Disk usage (root filesystem)
    disk=$(df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')
    tput cup 6 0; echo "Disk Usage: $disk"

    tput rc                # Restore cursor
}
