#!/bin/sh
cd /home/ubuntu/v1-rebill
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net,jj.salvador@paynamics.net"
echo "Subject:PhilAM Rebill Daily 1:00 AM to 5:00 AM. \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *
