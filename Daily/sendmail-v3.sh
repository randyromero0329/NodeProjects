#!/bin/sh
cd /home/ubuntu/v3
recentfile=$(ls -rt1 | tail -1)
content=$(cat $recentfile)
#subject="mail subject"

from="postmaster@notification.paynamics.net"
to="kenneth.palen@paynamics.net,merchant@paynamics.net,jester.babia@paynamics.net,christian.balagtas@paynamics.net,kim.briones@paynamics.net,richard.secondez@paynamics.net,devops@paynamics.net"
echo "Subject:V3 GR REPORT \n\n ${content}" | /usr/sbin/sendmail -f "${from}" -t "${to}"

rm *


ubuntu@ip-10-0-6-33:~/scripts$ ./v1-all-error.sh
ubuntu@ip-10-0-6-33:~/scripts$ ./v1-all-error-mail.sh 
ubuntu@ip-10-0-6-33:~/scripts$ ./v3-all-error.sh
ubuntu@ip-10-0-6-33:~/scripts$ ./v3-all-error-mail.sh 




From: postmaster@notification.paynamics.net
To: richard.secondez@paynamics.net
Subject: Amazon SES test email

This is a test message sent from Amazon SES using Sendmail.