#!/bin/sh
cd /home/ubuntu/gcash
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="randy.romero@paynamics.net"
echo "Subject: GCASH V3 GR REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *