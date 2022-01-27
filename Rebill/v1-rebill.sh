#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-rebill/GR_REPORTV1-${filename}.txt





SELECT MID AS "MID",
Sum(Case
	WHEN responsecode in ('GR001','GR002') THEN 1
             ELSE 0
End) AS Success,
Sum(Case
	WHEN responsecode not in ('GR001','GR002', 'GR033', 'GR152') THEN 1
             ELSE 0
End) AS Failed,
Sum(Case
	WHEN responsecode = 'GR033' THEN 1
             ELSE 0
End) AS GR033,
Sum(Case
	WHEN responsecode = 'GR152' THEN 1
             ELSE 0
End) AS GR152

FROM     rep
WHERE    MID in ('0000002611190B6F195F', '0000002611190B1AB4F2', '000000170820E5730B0B', '000000230620930B10BE', '0000001708205E54F25C', '0000002306201827C8F2', '0000000305219E2CE4A4', '0000000305210B3582D2') And TRXTYPE = 'Rebill' and responsetimestamp BETWEEN dateadd(hour, -5, getdate()) AND getdate()
GROUP BY MID
order BY MID DESC
     
GO

EOF


