#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-weekly/v1-weekly-${filename}.txt

-- TONIK DIGITAL BANK_RPF_GPAP_PHP
SELECT Left(count(*),10) As "Total", Left(RESPONSECODE,50) As "TONIK DIGITAL BANK_RPF_GPAP_PHP" from REP where MID IN ('000000300920DE313239') AND RESPONSECODE IN ('FR017','GR001','GR002','GR003','GR005','GR021','GR033','GR043','GR049','GR053','GR092','GR094','GR152','GR045','RM042') AND RESPONSETIMESTAMP BETWEEN DATEADD(day,-7,GETDATE()) AND GETDATE() 
GROUP BY MID, RESPONSECODE
ORDER  BY responsecode 

-- Pulse App_MIGS_PHP
SELECT Left(count(*),10) As "Total", Left(RESPONSECODE,50) As "Pulse App_MIGS_PHP" from REP where MID IN ('000000191020E4317539') AND RESPONSECODE IN ('GR001','GR003','GR036','GR053','GR092','GR152') AND RESPONSETIMESTAMP BETWEEN DATEADD(day,-7,GETDATE()) AND GETDATE() 
GROUP BY MID, RESPONSECODE
ORDER  BY responsecode 

-- Pru One App_MIGS_PHP
SELECT Left(count(*),10) As "Total", Left(RESPONSECODE,50) As "Pru One App_MIGS_PHP" from REP where MID IN ('000000191020B15FDB8C') AND RESPONSECODE IN ('GR001','GR003','GR036','GR053','GR092','GR152') AND RESPONSETIMESTAMP BETWEEN DATEADD(day,-7,GETDATE()) AND GETDATE() 
GROUP BY MID, RESPONSECODE
ORDER  BY responsecode 

GO

EOF

