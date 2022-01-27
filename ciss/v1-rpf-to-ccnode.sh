#!/bin/sh
#current_time=$("%(%m-%d-%Y %H:%M:%S)T")
#before_currenttime=$("%(%m-%d-%Y %H:%M:%S)T")
filename=$(date +"%m-%d-%Y-%H:%M")

#TransDB mySQL
sqlcmd -S 10.0.8.34,5598 -U sa  -P ReportSa1108 -d REPV2 << EOF > /home/ubuntu/ciss/v1-rpf-to-ccnode/GR_REPORT-GR033${filename}.txt

SELECT MID AS "MID",
Sum(Case
	WHEN responsecode in ('GR001','GR002') THEN 1
             ELSE 0
End) AS Success,
Sum(Case
	WHEN responsecode not in ('GR001','GR002', 'GR033', 'GR152') THEN 1
             ELSE 0
End) AS Failed,
Sum(Case
	WHEN responsecode = 'GR033' THEN 1
             ELSE 0
End) AS GR033,
Sum(Case
	WHEN responsecode = 'GR152' THEN 1
             ELSE 0
End) AS GR152

FROM     rep
WHERE    MID in ('000000030619CE50BFE0', '000000060820BA0B0B20', '0000001711202FE512B1', '000000090920B85459DA', '0000003107190BE73843', '000000260121B3D39298', '00000019052027E2A6F4', '0000000207210B6D4D7E', '00000002072120B2AB0B', '0000000207213238E9BA', '0000000207217C90B67B', '0000000207218E21A3E3', '0000000207218E9B3F0B', '000000020721A80B52B9', '000000020721B6286C78', '000000020721BD0B392E', '000000020721F790BCDB', '000000070221159874BC', '00000007022120B732AE', '0000000702212685CD84', '0000000702213C0B3EA8', '00000007022143793171', '000000070221480BE4B3', '00000007022151AB56E8', '000000070221C179DE48', '000000070221C1A9C825', '000000070221CE10BD26','000000070221CE5B10B1', '000000070221D4CF51B3', '00000007062165787C2F', '0000000706216A8F5F95', '0000000706218541F47D', '0000000706219549240B', '000000070621C40B1E91', '000000070621D57527FB', '0000000210201415D10B', '0000000702210B27649C', '000000070621F60B1FCD', '000000100620DF0B4D28', '0000001011202E63BD3F', '000000191120126464B8', '00000019112016F7D54D', '0000001911201FE6B5E8', '000000191120249E967F', '00000019112031A210BC', '00000019112035C76C46', '0000001911203ED430BE', '000000260421C82ABF48', '000000191120656840B5', '000000191120857DB0B5', '0000001911209B9E0B68', '000000191120BF0B9B75', '000000191120DA9F3938', '000000191120E60BD20B', '000000191120F2B85A71', '00000023052120BAE82E', '000000230521410B94FA', '000000230521D9D5CD87', '000000230521E4931CBC', '000000230521EC97B6FA', '000000230521F4767A86') And responsetimestamp BETWEEN dateadd(day, -1, getdate()) AND getdate()
GROUP BY MID
order BY MID ASC
     
GO

EOF

