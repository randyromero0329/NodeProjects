#!/bin/sh
dateNow=$(date +"%Y-%m-%d")
dateNow2=$(date)
date7daysAgo=$(date --date="${dateNow2} -7 day" +%Y-%m-%d)
mid=00000029122116D681BF
details=all_details

toDonwload=$(curl --user "devops_prod:?7VHrS/)]V?b" -X POST -d "end_date=${dateNow}&merchant_id=${mid}&mids&module&payment_reference&pchannels&pmethods&pnx_reference&request_id&response_codes&response_id&start_date=${date7daysAgo}&topic&type=${details}" https://campfire.paynamics.net/api/transactions/download_transaction)

echo "$toDonwload"