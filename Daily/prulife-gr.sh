#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/prulife/prulife-${filename}.txt


SELECT RESPONSECODE,MID, count(*) from REP where MID IN ('000000191020E4317539','000000191020B15FDB8C') AND RESPONSECODE IN ('GR001','GR033') AND RESPONSETIMESTAMP BETWEEN DATEADD(hour,-1,GETDATE()) AND GETDATE() GROUP BY MID, RESPONSECODE

GO

EOF


