#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="CPpM7FroMj9jem"

#TransDB postgreSQL
psql -h 10.0.11.5 -p 7766 -d paygate_system_db -U pti_paygate_prod << EOF > /home/ubuntu/v3-ciss-error/GR_REPORTV3-${filename}.txt

SELECT   Sum(Total), 
         "Error",
         "Report to CISS"
FROM     (
Select b.name AS "Report to CISS", a.status AS "Error", count (a.status) AS Total
From receive_wlt a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status in ('GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Report to CISS", "Error"
 UNION ALL
Select b.name AS "Report to CISS", a.status AS "Error", count (a.status) AS Total
From receive_obp a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status in ('GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Report to CISS", "Error"
 UNION ALL
Select b.name AS "Report to CISS", a.status AS "Error", count (a.status) AS Total
From receive_otp a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status in ('GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Report to CISS", "Error"
) AS c
GROUP BY "Report to CISS", "Error"
HAVING   sum(Total) >=5
ORDER BY "Report to CISS", "Error"


EOF