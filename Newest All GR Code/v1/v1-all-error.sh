#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-all-error/GR_REPORT-GR033${filename}.txt

SELECT LEFT(CONCAT('*',responsecode,' - ',responsemess,'*', '\n ' , mid_name, ' \n  ----- *Total* ',Count (*),' -----'),130) AS "Note: That the following result met the threshold of >= 5 transactions per Hour."
FROM   rep
WHERE  responsecode not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032')
       AND responsetimestamp BETWEEN Dateadd(hour, -1, Getdate()) AND Getdate()
GROUP  BY responsecode, mid_name,responsemess
HAVING Count (responsecode) >= 5
ORDER  BY responsecode 

GO

EOF
