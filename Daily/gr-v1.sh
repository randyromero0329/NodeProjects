#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1/GR_REPORTV1-${filename}.txt

SELECT
    [GR001]
    ,[GR002]
    ,[GR003]
    ,[GR018]
    ,[GR033]
    ,[GR043]
    ,[GR052]
    ,[GR152]
    ,[FR030]
    ,[RM033]
    ,[RM041]
    ,[FR017]
    ,[GR013]
    ,[GR049]
    ,[GR092]
    ,[GR124]
    ,[GR069]
    ,[FR013]
    ,[GR036]
    ,[GR055]

FROM
    (SELECT RESPONSECODE from REP WHERE RESPONSETIMESTAMP BETWEEN DATEADD(HOUR, -1, GETDATE()) AND GETDATE()) t
PIVOT
    (count([RESPONSECODE]) FOR [RESPONSECODE] IN ([GR001],[GR002],[GR003],[GR018],[GR033],[GR043],[GR052],[GR152],[FR030],[RM033],[RM041],[FR017],[GR013] ,[GR049],[GR092],[GR124],[GR069],[FR013],[GR036],[GR055])) AS PT

GO

EOF