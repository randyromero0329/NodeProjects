#!/bin/sh
cd /home/ubuntu/v1-all-error
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net,devops@paynamics.net"
echo "Subject:V1 Error Report to MS Team  \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *