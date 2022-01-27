#!/bin/sh
cd /home/ubuntu/dgate
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="jester.babia@paynamics.net,christian.balagtas@paynamics.net,kenneth.palen@paynamics.net,merchant@paynamics.net,devops@paynamics.net,kim.briones@paynamics.net,richard.secondez@paynamics.net"
echo "Subject:DGATE GR REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *



================================


from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net"
echo "Subject:DGATE GR REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *