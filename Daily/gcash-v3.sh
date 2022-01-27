#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")
export PGPASSWORD="CPpM7FroMj9jem"

#TransDB postgreSQL
psql -h 10.0.11.5 -p 7766 -d paygate_system_db -U pti_paygate_prod << EOF > /home/ubuntu/gcash/GR_REPORTV3-${filename}.txt


select
    l."label" as tier,
    r.status as status,
    count(request_id) as count,
    rc.message
from receive as r
left join gcash_merch_class as gmc
on r.requestor_id = gmc.merchant_id
left join lookups as l
on gmc."class" = l.id
left join response_codes as rc
on r.status = rc.code
where r.processing_pchannel = 'gc'
and l."label" = 'GCash Tier 1'
and r.created_at between (NOW() - INTERVAL '1 HOUR')  and NOW()
group by l."label", r.status, rc.message;

select
    l."label" as tier,
    r.status as status,
    count(request_id) as count,
    rc.message
from receive as r
left join gcash_merch_class as gmc
on r.requestor_id = gmc.merchant_id
left join lookups as l
on gmc."class" = l.id
left join response_codes as rc
on r.status = rc.code
where r.processing_pchannel = 'gc'
and l."label" = 'GCash Tier 2'
and r.created_at between (NOW() - INTERVAL '1 HOUR')  and NOW()
group by l."label", r.status, rc.message;

select
    l."label" as tier,
    r.status as status,
    count(request_id) as count,
    rc.message
from receive as r
left join gcash_merch_class as gmc
on r.requestor_id = gmc.merchant_id
left join lookups as l
on gmc."class" = l.id
left join response_codes as rc
on r.status = rc.code
where r.processing_pchannel = 'gc'
and l."label" = 'GCash Tier 3'
and r.created_at between (NOW() - INTERVAL '1 HOUR')  and NOW()
group by l."label", r.status, rc.message;

select
    l."label" as tier,
    r.status as status,
    count(request_id) as count,
    rc.message
from receive as r
left join gcash_merch_class as gmc
on r.requestor_id = gmc.merchant_id
left join lookups as l
on gmc."class" = l.id
left join response_codes as rc
on r.status = rc.code
where r.processing_pchannel = 'gc'
and l."label" = 'GCash Tier 4'
and r.created_at between (NOW() - INTERVAL '1 HOUR')  and NOW()
group by l."label", r.status, rc.message;

EOF
                                      