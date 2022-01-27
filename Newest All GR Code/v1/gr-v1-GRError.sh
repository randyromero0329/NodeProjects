#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-gr033/GR_REPORT-GR033${filename}.txt

SELECT RESPONSECODE, count (*) as "Total Count" from REP WHERE RESPONSETIMESTAMP BETWEEN DATEADD(HOUR, -1, GETDATE()) AND GETDATE()  group by RESPONSECODE having count (*) >=5 order by RESPONSECODE

GO

EOF