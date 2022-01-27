#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

sqlcmd -S 10.0.0.10,5598 -U pnxdgateusr  -P starFl33t -d DGate2.0 << EOF > /home/ubuntu/dgate-grerror/GR_REPORT-DGATE${filename}.txt

SELECT LEFT(CONCAT('*',dresresponsecode,' - ',dresresponsemessage,'*', '\n '  , FK_procID, ' \n  ----- *Total* ', Count(*),' -----'),130) AS "Note: That the following result met the threshold of >= 5 transactions per Hour."
FROM   [DGate2.0].[dbo].[details_response]
WHERE  dresresponsecode not in ('GR001','GR002')
       AND drestimestamp > Dateadd(hh, -1, Getdate())
GROUP  BY dresresponsecode,FK_procID,dresresponsemessage
HAVING Count (*) >= 5
ORDER  BY dresresponsecode

GO


EOF 

"\e[31Note:\e[0m"