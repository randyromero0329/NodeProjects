#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/rebill/rebill-${filename}.txt


SELECT RESPONSECODE,MID, count(*) from REP where MID IN ('000000300920DE313239') AND RESPONSECODE IN ('GR001') AND RESPONSETIMESTAMP BETWEEN Ddate_sub(now(), interval 1 week) AND Ddate_add(now(), interval 1 day) GROUP BY MID, RESPONSECODE


GO

EOF