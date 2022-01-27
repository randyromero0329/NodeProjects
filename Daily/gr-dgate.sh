#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")


sqlcmd -S 10.0.0.10,5598 -U pnxdgateusr  -P starFl33t -d DGate2.0 << EOF > /home/ubuntu/dgate/GR_REPORT-DGATE${filename}.txt

SELECT dresResponseCode as "GR-CODE", COUNT(dresResponseCode) as COUNT  FROM [DGate2.0].[dbo].[details_response] where dresResponseCode IN ('GR001','GR002','GR003','GR027','GR033','GR040','GR056','RM005') and drestimestamp > dateadd(hh,-1,getdate()) GROUP BY dresResponseCode

GO


EOF