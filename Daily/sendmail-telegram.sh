#!/bin/bash
cd /home/ubuntu/v1-gr033
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)

TOKEN=2107571002:AAHbnLHe4qceXvoCTo7pNxLfSkIDjXoFxPY
#CHAT_ID=1686082402
GROUP_CHAT_ID=-1001730636471
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$GROUP_CHAT_ID -d text="$content"