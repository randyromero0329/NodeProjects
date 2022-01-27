#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")


sqlcmd -S 10.0.0.10,5598 -U pnxdgateusr  -P starFl33t -d DGate2.0 << EOF > /home/ubuntu/dgate-all-code/GR_REPORT-DGATE${filename}.txt

SELECT dresresponsecode AS "Error Code",
       Count(*) AS Count
FROM   [DGate2.0].[dbo].[details_response]
WHERE  drestimestamp > Dateadd(hh, -1, Getdate())
GROUP  BY dresresponsecode,FK_procID
BY dresresponsecode
GO


EOF