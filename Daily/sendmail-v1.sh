#!/bin/sh
cd /home/ubuntu/v1
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="kenneth.palen@paynamics.net,merchant@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net,kim.briones@paynamics.net,richard.secondez@paynamics.net,devops@paynamics.net"
echo "Subject:V1 GR REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *