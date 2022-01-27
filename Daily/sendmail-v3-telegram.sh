#!/bin/bash
cd /home/ubuntu/v3-grerror
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)

TOKEN=2095355429:AAEqX5cY7WBe7uI7QbaqYfdHMKzd7H0rJeY
#CHAT_ID=1686082402
GROUP_CHAT_ID=-1001730636471
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

curl -s -X POST $URL -d chat_id=$GROUP_CHAT_ID -d text="$content"