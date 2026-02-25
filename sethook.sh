#!/usr/bin/env bash

# usage: sethook telegram_bot_token <url_to_send_updates_to> [-d|--drop]
# https://api.telegram.org/bot{my_bot_token}/setWebhook?url={url_to_send_updates_to}
# echo description from response json

DROP_PENDING=""
TOKEN=""
URL=""

while [ $# -gt 0 ]; do
    case "$1" in
        -d|--drop)
            DROP_PENDING="&drop_pending_updates=true"
            shift
            ;;
        *)
            if [ -z "$TOKEN" ]; then
                TOKEN="$1"
            elif [ -z "$URL" ]; then
                URL="$1"
            fi
            shift
            ;;
    esac
done

if [ -z "$TOKEN" ]; then
    echo "Usage:"
    echo "npx sethook <telegram_bot_token> [url_to_send_updates_to] [-d|--drop]"
    exit 1
fi

curl -s "https://api.telegram.org/bot${TOKEN}/setWebhook?url=${URL}${DROP_PENDING}" | jq -r '.description'