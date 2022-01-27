#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/philam-rebill/v1-rebill4/GR_REPORTV1-${filename}.txt


SELECT MID AS "PHILAM_COFFEE_CLOSING_MOTO_MIGS_PHP",
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
WHERE    MID in ('000000170820E5730B0B') And TRXTYPE = 'Rebill' and responsetimestamp BETWEEN dateadd(hour, -5, getdate()) AND getdate()
GROUP BY MID
order BY MID DESC
     
GO

EOF


