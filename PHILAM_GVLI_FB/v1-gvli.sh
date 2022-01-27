#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-gvli/GR_REPORTV1-${filename}.txt

SELECT Left(count(*),10) As "Total", Left(RESPONSECODE,50) As "PHILAM_GVLI_FB_Retail" from REP where MID IN ('000000091221958F54F4') AND RESPONSECODE IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND RESPONSETIMESTAMP BETWEEN Dateadd(hour, -1, Getdate()) AND Getdate() 
GROUP BY MID, RESPONSECODE
ORDER  BY responsecode 

GO

EOF


SELECT
    [GR001],[GR002],[GR003],[GR033],[GR094],[GR112],[GR152],[GR0158]

FROM
    (SELECT RESPONSECODE from REP WHERE MID IN ('000000091221958F54F4') AND RESPONSETIMESTAMP BETWEEN DATEADD(HOUR, -1, GETDATE()) AND GETDATE()) t
PIVOT
    (count([RESPONSECODE]) FOR [RESPONSECODE] IN ([GR001],[GR002],[GR003],[GR033],[GR094],[GR112],[GR152],[GR0158])) AS PT