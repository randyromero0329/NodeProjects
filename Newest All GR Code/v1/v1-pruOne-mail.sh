#!/bin/sh
cd /home/ubuntu/v1-pruOne
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jester.babia@paynamics.net"
echo "Subject:V1 Pru One App_MIGS_PHP \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *