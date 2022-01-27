#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="CPpM7FroMj9jem"

#TransDB postgreSQL
psql -h 10.0.11.5 -p 7766 -d paygate_system_db -U pti_paygate_prod << EOF > /home/ubuntu/paybiz-v3-weekly/GR_REPORTV3-${filename}.txt


-- PAYBIZ - 00000027011198B17BFB Only
select
trx_status,
sum(trx_count)
from (
    select
    case
        when status = 'GR001' then 'GR001'
        when status = 'GR002' then 'GR002'
        when status = 'GR003' then 'GR003'
        when status = 'GR018' then 'GR018'
        when status = 'GR033' then 'GR033'
        when status = 'GR043' then 'GR043'
        when status = 'GR052' then 'GR052'
        when status = 'GR152' then 'GR152'
        when status = 'FR030' then 'FR030'
        when status = 'RM033' then 'RM033'
        when status = 'RM041' then 'RM041'
        when status = 'FR017' then 'FR017'
        when status = 'GR013' then 'GR013'
        when status = 'GR092' then 'GR092'
        when status = 'GR049' then 'GR049'
        when status = 'GR124' then 'GR124'
        when status = 'GR069' then 'GR069'
        when status = 'FR013' then 'FR013'
        when status = 'GR036' then 'GR036'
        when status = 'GR055' then 'GR055'
        when status = 'GR152' then 'GR152'
        when status not in ('GR001', 'GR002', 'GR003', 'GR018', 'GR033', 'GR043', 'GR052', 'GR152', 'FR030', 'RM033',  'RM041', 'FR017', 'GR013', 'GR092',  'GR049', 'GR124', 'GR069', 'FR013', 'GR036', 'GR055', 'GR152') then 'OTHERS'
    end as trx_status,
    count(status) as trx_count
    from receive_otp
    where created_at between (NOW() - INTERVAL '1 WEEK')  and NOW() and merchant_id = '00000027011198B17BFB'
    group by trx_status
    union
    select
    case
when status = 'GR001' then 'GR001'
        when status = 'GR002' then 'GR002'
        when status = 'GR003' then 'GR003'
        when status = 'GR018' then 'GR018'
        when status = 'GR033' then 'GR033'
        when status = 'GR043' then 'GR043'
        when status = 'GR052' then 'GR052'
        when status = 'GR152' then 'GR152'
        when status = 'FR030' then 'FR030'
        when status = 'RM033' then 'RM033'
        when status = 'RM041' then 'RM041'
        when status = 'FR017' then 'FR017'
        when status = 'GR013' then 'GR013'
        when status = 'GR092' then 'GR092'
        when status = 'GR049' then 'GR049'
        when status = 'GR124' then 'GR124'
        when status = 'GR069' then 'GR069'
        when status = 'FR013' then 'FR013'
        when status = 'GR036' then 'GR036'
        when status = 'GR055' then 'GR055'
        when status = 'GR152' then 'GR152'
        when status not in ('GR001', 'GR002', 'GR003', 'GR018', 'GR033', 'GR043', 'GR052', 'GR152', 'FR030', 'RM033',  'RM041', 'FR017', 'GR013', 'GR092',  'GR049', 'GR124', 'GR069', 'FR013', 'GR036', 'GR055', 'GR152') then 'OTHERS'
    end as trx_status,
    count(status) as trx_count
    from receive_obt
    where created_at between (NOW() - INTERVAL '1 WEEK')  and NOW() and merchant_id = '00000027011198B17BFB'
    group by trx_status
    union
    select
    case
           when status = 'GR001' then 'GR001'
        when status = 'GR002' then 'GR002'
        when status = 'GR003' then 'GR003'
        when status = 'GR018' then 'GR018'
        when status = 'GR033' then 'GR033'
        when status = 'GR043' then 'GR043'
        when status = 'GR052' then 'GR052'
        when status = 'GR152' then 'GR152'
        when status = 'FR030' then 'FR030'
        when status = 'RM033' then 'RM033'
        when status = 'RM041' then 'RM041'
        when status = 'FR017' then 'FR017'
        when status = 'GR013' then 'GR013'
        when status = 'GR092' then 'GR092'
        when status = 'GR049' then 'GR049'
        when status = 'GR124' then 'GR124'
        when status = 'GR069' then 'GR069'
        when status = 'FR013' then 'FR013'
        when status = 'GR036' then 'GR036'
        when status = 'GR055' then 'GR055'
        when status = 'GR152' then 'GR152'
        when status not in ('GR001', 'GR002', 'GR003', 'GR018', 'GR033', 'GR043', 'GR052', 'GR152', 'FR030', 'RM033',  'RM041', 'FR017', 'GR013', 'GR092',  'GR049', 'GR124', 'GR069', 'FR013', 'GR036', 'GR055', 'GR152') then 'OTHERS'
    end as trx_status,
    count(status) as trx_count
    from receive_wlt
    where created_at between (NOW() - INTERVAL '1 WEEK')  and NOW() and merchant_id = '00000027011198B17BFB'
    group by trx_status
) as c
group by trx_status

EOF
                                      