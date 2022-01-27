#!/bin/sh
cd /home/ubuntu/v3-test
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net"
echo "Subject:V3 Test Error  \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *