#!/bin/sh

PROFILE=paynamics-oregon
PROFILE2=default
BUCKET=campfire-download-dev
BUCKET2=sftp-pipo-bytedance/staging
dateNow=$(date +"%Y-%m-%d")
dateNow2=$(date)
date7daysAgo=$(date --date="${dateNow2} -7 day" +%Y-%m-%d)
mid=000000161121565B40BF
OBJECT="$(aws s3 ls --profile $PROFILE $BUCKET --recursive | sort | tail -n 1 | awk '{print $4}')"

aws s3 cp s3://$BUCKET/$OBJECT ~/pipo-bytedance-staging/$OBJECT --profile $PROFILE
cd ../pipo-bytedance-staging; mv *.xlsx ~/pipo-bytedance-staging/${mid}_${date7daysAgo}_${dateNow}.xlsx
aws s3 cp ~/pipo-bytedance-staging/* s3://$BUCKET2/ --profile $PROFILE2
                                                           