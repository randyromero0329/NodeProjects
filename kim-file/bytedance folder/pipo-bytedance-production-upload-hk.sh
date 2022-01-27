#!/bin/sh

PROFILE=paynamics-oregon
PROFILE2=default
BUCKET=campfire-download-prod
BUCKET2=sftp-pipo-bytedance/production
dateNow=$(date +"%Y-%m-%d")
dateNow2=$(date)
date7daysAgo=$(date --date="${dateNow2} -7 day" +%Y-%m-%d)
mid=000000161121565B40BF
dir=pipo-bytedance-production
OBJECT="$(aws s3 ls --profile $PROFILE $BUCKET --recursive | sort | tail -n 1 | awk '{print $4}')"

aws s3 cp s3://$BUCKET/$OBJECT ~/$dir/$OBJECT --profile $PROFILE
cd ../$dir && mv *.xlsx ~/$dir/${mid}_${date7daysAgo}_${dateNow}.xlsx
aws s3 cp ~/$dir/* s3://$BUCKET2/ --profile $PROFILE2