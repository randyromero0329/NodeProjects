#!/bin/sh
cd /home/ubuntu/v3-all-code
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net"
echo "Subject:V3 GR REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *