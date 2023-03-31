#!/bin/bash

log_path="<PATH_TO_LOG>"
webhook_url="<WEBHOOK_URL>"

send_webhook() {
    message="$1"
    payload=$(echo -n "$message" | jq -Rs '{content: .}')
    curl -X POST \
         -H "Content-Type: application/json" \
         -d "$payload" \
         "$webhook_url"
}


follow_log() {
    tail -fn0 "$log_path" | \
    while read -r line ; do
        if [[ "$line" == *"has joined."* ]]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Sending webhook for: $line"
            send_webhook "$line"
        elif [[ "$line" == *"has left."* ]]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Sending webhook for: $line"
            send_webhook "$line"
        else
            echo "$(date '+%Y-%m-%d %H:%M:%S') - Ignoring line: $line"
        fi
    done
}

echo "$(date '+%Y-%m-%d %H:%M:%S') - Script started"
follow_log