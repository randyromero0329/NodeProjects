#!/bin/sh
cd /home/ubuntu/dgate-grerror
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,devops@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net"
echo "Subject:DGATE ERROR REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *