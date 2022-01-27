#!/bin/bash
cd /home/ubuntu/dgate-grerror
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)

TOKEN=1840563010:AAHuExm2oemT79ceFqo-yHmCYG4_xVvVAME
#CHAT_ID=1686082402
GROUP_CHAT_ID=-1001730636471
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$GROUP_CHAT_ID -d text="$content"