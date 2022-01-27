#!/bin/sh
cd /home/ubuntu/ciss/v1-rpf-to-ccnode
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jj.salvador@paynamics.net,jester.babia@paynamics.net"
echo "Subject:RPF to CCNode Migration Transaction Monitoring \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *