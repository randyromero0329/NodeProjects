#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="p@yg@t3@dm1n"

### Dev Env ###
#TransDB postgreSQL
psql -h 159.203.110.226 -p 5432 -d paygate_system_db -U pti_paygate_admin << EOF > /home/ubuntu/v3-gvli-dev/GR_REPORTV3-${filename}.txt


SELECT   "GR Code",
          Sum(Total)
FROM     (
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_wlt a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_obp a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_otp a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL

Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_cc a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_cc_installment a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_installment a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_installment_payment a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_obp_pay_reference_link a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_obt a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_pay_reference_link a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"
 UNION ALL
Select b.name AS "Name", a.status AS "GR Code", count (a.status) AS Total
From receive_settlement_info	 a inner join merchant b on a.merchant_id = b.merchant_id 
where a.status IN ('GR001','GR002','GR003','GR033','GR094','GR112','GR152','GR158') AND a.created_at BETWEEN (Now() - interval '1 HOUR') AND now() and a.merchant_id = '0000000411210B13E740' 
GROUP BY "Name", "GR Code"

) AS c
GROUP BY "Name", "GR Code"
ORDER BY "Name", "GR Code"

EOF
    