#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="CPpM7FroMj9jem"

#TransDB postgreSQL
psql -h 10.0.11.5 -p 7766 -d paygate_system_db -U pti_paygate_prod << EOF > /home/ubuntu/v3-monthly/v3-monthly-${filename}.txt


select
trx_status,
sum(trx_count)
from (
    select
    case
          when status = 'GR001' then 'GR001'
        when status = 'GR002' then 'GR002'
        when status = 'GR018' then 'GR018'
        when status = 'GR033' then 'GR033'
        when status = 'GR043' then 'GR043'
        when status = 'GR052' then 'GR052'
        when status = 'GR152' then 'GR152'
        when status = 'FR030' then 'FR030'
        when status = 'RM033' then 'RM033'
        when status = 'RM041' then 'RM041'
        when status not in ('GR001', 'GR002', 'GR018', 'GR033', 'GR043', 'GR052', 'GR152', 'FR030', 'RM033',  'RM041') then 'OTHERS'
      end as trx_status,
    count(status) as trx_count
    from receive_otp
    where created_at between (NOW() - INTERVAL '1 MONTH')  and NOW()
    group by trx_status
    union
    select
    case
    when status = 'GR001' then 'GR001'
        when status = 'GR002' then 'GR002'
        when status = 'GR018' then 'GR018'
        when status = 'GR033' then 'GR033'
        when status = 'GR043' then 'GR043'
        when status = 'GR052' then 'GR052'
        when status = 'GR152' then 'GR152'
        when status = 'FR030' then 'FR030'
        when status = 'RM033' then 'RM033'
        when status = 'RM041' then 'RM041'
        when status not in ('GR001', 'GR002', 'GR018', 'GR033', 'GR043', 'GR052', 'GR152', 'FR030', 'RM033',  'RM041') then 'OTHERS'  
        end as trx_status,
    count(status) as trx_count
    from receive_otp
    where created_at between (NOW() - INTERVAL '1 MONTH')  and NOW()
    group by trx_status
    union
    select
    case
    when status = 'GR001' then 'GR001'
        when status = 'GR002' then 'GR002'
        when status = 'GR018' then 'GR018'
        when status = 'GR033' then 'GR033'
        when status = 'GR043' then 'GR043'
        when status = 'GR052' then 'GR052'
        when status = 'GR152' then 'GR152'
        when status = 'FR030' then 'FR030'
        when status = 'RM033' then 'RM033'
        when status = 'RM041' then 'RM041'
        when status not in ('GR001', 'GR002', 'GR018', 'GR033', 'GR043', 'GR052', 'GR152', 'FR030', 'RM033',  'RM041') then 'OTHERS'  
        end as trx_status,
    count(status) as trx_count
    from receive_otp
    where created_at between (NOW() - INTERVAL '1 MONTH')  and NOW()
    group by trx_status
   ) as c
group by trx_status

EOF