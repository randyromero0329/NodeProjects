#!/bin/sh
cd /home/ubuntu/ciss/v1-ciss-error
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net,devops@paynamics.net"
echo "Subject: V1 Error Report to Sir Leo's Team (CISS)  \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *