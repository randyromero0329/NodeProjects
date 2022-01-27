#!/bin/sh
cd /home/ubuntu/special-event
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net,kim.briones@paynamics.net"
echo "Subject:GMOVIES REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *