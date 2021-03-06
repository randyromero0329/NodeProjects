#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/v3-weekly/v3-weekly-${filename}.txt

-- TONIK DIGITAL BANK_RPF_GPAP_PHP
SELECT RESPONSECODE,MID, count(*) from REP where MID IN ('000000300920DE313239') AND RESPONSECODE IN ('FR017','GR001','GR002','GR003',GR005','GR021','GR033','GR043','GR049','GR053','GR092','GR094','GR152','GR045','RM042') AND RESPONSETIMESTAMP BETWEEN DATEADD(DAY, -7, GETDATE(),110)) AND getdate() GROUP BY MID, RESPONSECODE

-- Pulse App_MIGS_PHP
SELECT RESPONSECODE,MID, count(*) from REP where MID IN ('0000002611190B1AB4F2') AND RESPONSECODE IN ('GR001','GR003','GR036','GR053','GR092','GR152') AND RESPONSETIMESTAMP BETWEEN DATEADD(DAY, -7, GETDATE(),110)) AND getdate() GROUP BY MID, RESPONSECODE

-- Pru One App_MIGS_PHP
SELECT RESPONSECODE,MID, count(*) from REP where MID IN ('000000191020E4317539') AND RESPONSECODE IN ('GR001','GR003','GR036','GR053','GR092','GR152') AND RESPONSETIMESTAMP BETWEEN DATEADD(DAY, -7, GETDATE(),110)) AND getdate() GROUP BY MID, RESPONSECODE

-- TONIK DIGITAL BANK_WORKFLOW_MIGS_PHP
SELECT RESPONSECODE,MID, count(*) from REP where MID IN ('000000300920D374EDC0') AND RESPONSECODE IN ('FR017','GR001','GR002','GR003',GR005','GR021','GR033','GR043','GR049','GR053','GR092','GR094','GR152','GR045','RM042') AND RESPONSETIMESTAMP BETWEEN DATEADD(DAY, -7, GETDATE(),110)) AND getdate() GROUP BY MID, RESPONSECODE

GO

EOF