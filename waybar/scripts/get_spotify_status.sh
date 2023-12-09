#!/bin/bash

# Get the current workspace name using wmctrl

# Your existing code
PARENT_BAR="now-playing"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)
PLAYER="spotify"

available_players=$(playerctl -l 2>/dev/null)

# Set the default player to be used if "spotify" is not available
default_player=""

# Check if "spotify" is available in the list of players
if [[ $available_players == *"spotify"* ]]; then
    # Set PLAYER to "spotify" if it's available
    PLAYER="spotify"
else
    # If "spotify" is not available, use the first available player from the list
    IFS=' ' read -ra player_array <<< "$available_players"
    PLAYER="${player_array[0]}"
fi

FORMAT="{{ title }}"
PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)
EXIT_CODE=$?

RES=$(playerctl --player=$PLAYER metadata --format "$FORMAT")
OUTPUT=${RES:0:40}


if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="No player is running"
fi

if [ "$1" == "--status" ]; then
    echo "$STATUS"
else
    if [ "$STATUS" = "Stopped" ]; then
        echo "No music is playing"
    elif [ "$STATUS" = "Paused"  ]; then
        echo $OUTPUT
    elif [ "$STATUS" = "No player is running"  ]; then
        echo "$STATUS"
    else
        echo $OUTPUT
    fi
fi

