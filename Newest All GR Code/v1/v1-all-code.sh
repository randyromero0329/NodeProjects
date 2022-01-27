#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-all-code/GR_REPORTV1-${filename}.txt

  SELECT   responsecode AS "Code",
         responsemess,
         mid_name,
         Count (*) AS "Total"
FROM     rep
WHERE    responsecode > 'GR002' and responsetimestamp BETWEEN dateadd(hour, -1, getdate()) AND getdate()
GROUP BY responsecode,
         mid_name,
         responsemess
HAVING   count (*) >=5
ORDER BY responsecode,
         mid_name,
         responsemess
     
GO

EOF


