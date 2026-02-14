#!/bin/bash
# Simple watch-like script to run a command repeatedly

interval=2
command_to_run="$*"

if [ $# -eq 0 ]; then
    echo "Usage: $0 [interval_seconds] command"
    echo "Example: $0 5 ls -l"
    echo "Default interval is 2 seconds if not specified"
    exit 1
fi

# If first argument is a number, use it as interval
if [[ $1 =~ ^[0-9]+$ ]]; then
    interval=$1
    shift
    command_to_run="$*"
fi

echo "Running: $command_to_run"
echo "Interval: ${interval}s (Ctrl+C to stop)"

while true; do
    clear
    echo "$(date): Running '$command_to_run'"
    echo "----------------------------------------"
    eval "$command_to_run"
    sleep $interval
done