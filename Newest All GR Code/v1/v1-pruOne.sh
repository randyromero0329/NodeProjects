#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v1-pruOne/v1-pruOne-${filename}.txt

-- Pru One App_MIGS_PHP
SELECT Left(RESPONSECODE,10) As "Pru One App_MIGS_PHP",Left(count(*),10) As "Total" from REP where MID IN ('000000191020B15FDB8C') AND RESPONSECODE IN ('GR001', 'GR015','GR033','GR036', 'GR038', 'GR043', 'GR053','GR092','GR152') AND RESPONSETIMESTAMP BETWEEN DATEADD(hour, -1, Getdate()) AND Getdate() 
GROUP BY MID, RESPONSECODE
ORDER  BY responsecode 

GO

EOF

