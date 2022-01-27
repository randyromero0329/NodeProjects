#!/bin/sh
cd /home/ubuntu/paybiz-v3-weekly
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="jester.babia@paynamics.net,christian.balagtas@paynamics.net,randy.romero@paynamics.net"
echo "Subject:PAYBIZ V3 Weekly REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *