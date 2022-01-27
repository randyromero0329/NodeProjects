#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-gr033/GR_REPORT-GR033${filename}.txt
 
SELECT LEFT(Count (*),10) AS "Total",LEFT(responsecode,10) AS "Responce Code"
FROM   rep
WHERE  responsecode not in ('GR001','GR002','GR033')
       AND responsetimestamp BETWEEN Dateadd(hour, -1, Getdate()) AND Getdate()
GROUP  BY responsecode
HAVING Count (*) >= 5
ORDER  BY responsecode           

GO

EOF
