#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="CPpM7FroMj9jem"

#TransDB postgreSQL
psql -h 10.0.11.5 -p 7766 -d paygate_system_db -U pti_paygate_prod << EOF > /home/ubuntu/v3-grerror/GR_REPORTV3-${filename}.txt


SELECT   trx_status,
         Sum(trx_count)
FROM     (
 SELECT   status AS trx_status,
          merchant_id AS Merchant,
          Count (*) AS trx_count
 FROM     receive_obp
 WHERE    status > 'GR002' and status != 'GR033'
 AND      created_at BETWEEN (Now() - interval '1 HOUR') AND now()
 GROUP BY trx_status,
          merchant_id
 UNION ALL
 SELECT   status AS trx_status,
          merchant_id AS Merchant,
          count (*) AS trx_count
 FROM     receive_otp
 WHERE    status > 'GR002' and status != 'GR033'
 AND      created_at BETWEEN (now() - interval '1 HOUR') AND now()
 GROUP BY trx_status,
          merchant_id
 UNION ALL
 SELECT   status AS trx_status,
          merchant_id AS Merchant,
          count (*) AS trx_count
 FROM     receive_wlt
 WHERE    status > 'GR002' and status != 'GR033'
 AND      created_at BETWEEN (now() - interval '1 HOUR') AND now()
 GROUP BY trx_status,
          merchant_id ) AS c
GROUP BY trx_status
HAVING   sum(trx_count) >=5
ORDER BY trx_status

EOF
    