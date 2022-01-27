#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="CPpM7FroMj9jem"

#TransDB postgreSQL
psql -h 10.0.11.5 -p 7766 -d paygate_system_db -U pti_paygate_prod << EOF > /home/ubuntu/v3-all-code/GR_REPORTV3-${filename}.txt

select
trx_status,
sum(trx_count)
from (

select status as trx_status, count (*) as trx_count from receive_obp where created_at between (NOW() - INTERVAL '1 HOUR')  and NOW() group by trx_status
union all
select status as trx_status, count (*) as trx_count from receive_otp where created_at between (NOW() - INTERVAL '1 HOUR')  and NOW() group by trx_status
union all
select status as trx_status, count (*) as trx_count from receive_wlt where created_at between (NOW() - INTERVAL '1 HOUR')  and NOW() group by trx_status

) as c group by trx_status having sum(trx_count) >=5 order by trx_status

EOF