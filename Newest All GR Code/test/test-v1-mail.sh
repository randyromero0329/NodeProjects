#!/bin/sh
cd /home/ubuntu/v1-all-code
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jester"
echo "Subject:V1 ALL GR CODE \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *