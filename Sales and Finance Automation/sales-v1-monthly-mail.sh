#!/bin/sh
cd /home/ubuntu/sales-v1-monthly
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="jester.babia@paynamics.net,christian.balagtas@paynamics.net,randy.romero@paynamics.net"
echo "Subject:Sales and Finance V1 Monthly Report \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *
