#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="CPpM7FroMj9jem"

#TransDB postgreSQL
psql -h 10.0.11.5 -p 7766 -d paygate_system_db -U pti_paygate_prod << EOF > /home/ubuntu/v3-all-error/GR_REPORTV3-${filename}.txt

SELECT   Sum(Total), 
         "Status",
         "Name"
FROM     (
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_wlt a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_obp a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_otp a inner join merchant b on a.merchant_id = b.merchant_id  
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL

Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_cc a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_cc_installment a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_installment a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_installment_payment a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_obp_pay_reference_link a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_obt a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_pay_reference_link a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"
 UNION ALL
Select b.name AS "Name", a.status AS "Status", count (a.status) AS Total
From receive_settlement_info	 a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status not in ('GR001','GR002','GR033','GR052','GR124','RM033','FR032') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() 
GROUP BY "Name", "Status"

) AS c
GROUP BY "Name", "Status"
HAVING   sum(Total) >=5
ORDER BY "Name", "Status"


EOF
