#!/bin/bash

# PT Workout Timer Script
# Usage: chmod +x pt_timer.sh && ./pt_timer.sh

for round in {1..10}; do
    echo "Round $round of 10"

    # Get ready countdown
    say "get ready in"
    for count in {5..1}; do
        say "$count"
        sleep 1
    done

    # Start with bell sound
    say "start [[slnc 500]]"
    afplay /System/Library/Sounds/Glass.aiff

    # 30 second stretch
    sleep 30
    say "rest"

    # 25 second rest
    sleep 25

    # Only say "second side" if not the last round
    if [ $round -lt 10 ]; then
        say "second side"
    else
        say "workout complete"
    fi
done

echo "Workout finished!"