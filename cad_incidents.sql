DECLARE @ThreeYearsAgo DATE = DATEADD(YEAR, -3, DATEADD(YEAR, DATEDIFF(YEAR, 0, GETDATE()), 0))

;WITH cad_incidents AS(
SELECT
	Master_Incident_Number AS 'incident_number'
	,CASE
		WHEN Address LIKE '501 W PROSPECT%' THEN 'Aggie Village Family'
		WHEN Address LIKE '551 W Laurel%' THEN 'Allison Hall'
		WHEN Address LIKE '711 Oval%' THEN 'Ammons Hall'
		WHEN Address LIKE '800 W Pitkin%' THEN 'AV - Aspen Hall'
		WHEN Address LIKE '820 W Pitkin%' THEN 'AV - Commons'
		WHEN Address LIKE '816 W Pitkin%' THEN 'AV - Engineering'
		WHEN Address LIKE '810 W Pitkin%' THEN 'AV - Honors'
		WHEN Address LIKE '1101 Braiden%' THEN 'Braiden Hall'
		WHEN Address LIKE '500 W Pitkin%' THEN 'Braiden Hall'
		WHEN Address LIKE '801 W Laurel%' THEN 'Corbett Hall'
		WHEN Address LIKE '511 W Lake%' THEN 'Cottonwood Hall'
		WHEN Address LIKE '950 W Plum%' THEN 'Durrell Center'
		WHEN Address LIKE '1001 W Laurel%' THEN 'Durward Hall'
		WHEN Address LIKE '1231 Center%' THEN 'Eddy Hall'
		WHEN Address LIKE '900 W Pitkin%' THEN 'Edwards Hall'
		WHEN Address LIKE '1000 W Pitkin%' THEN 'Ingersoll Hall'
		WHEN Address LIKE '1400 W Elizabeth%' THEN 'International House'
		WHEN Address LIKE '910 W Plum%' THEN 'Alpine Hall'
		WHEN Address LIKE '701 W Laurel%' THEN 'Parmelee Hall'
		WHEN Address LIKE '920 W Plum%' THEN 'The Pavilion'
		WHEN Address LIKE '900 W Plum%' THEN 'Pinon Hall'
		WHEN Address LIKE '521 W Lake%' THEN 'Lodgepole'
		WHEN Address LIKE '700 W Pitkin%' THEN 'Newsom Hall'
		WHEN Address LIKE '963 W Pitkin%' THEN 'Summit Hall'
		WHEN Address LIKE '1500 W Plum%' THEN 'University Village - 1500'
		WHEN Address LIKE '1600 W Plum%' THEN 'University Village - 1600'
		WHEN Address LIKE '1700 W Plum%' THEN 'University Village - 1700'
		WHEN Address LIKE '501 W Lake%' THEN 'Walnut'
		WHEN Address LIKE '1009 W Laurel%' THEN 'Westfall Hall'
			--General Campus Buildings
		WHEN Address LIKE '900 Oval%' THEN 'Admin Building'
		WHEN Address LIKE '701 W Pitkin%' THEN 'Alumni Center'
		WHEN Address LIKE '711 Oval%' Then 'Ammons Hall'
		WHEN Address LIKE '1350 Center%' THEN 'Anatomy/Zoology'
		WHEN Address LIKE '350 W Pitkin%' THEN 'Animal Sciences'
		WHEN Address LIKE '1100 Meridian%' THEN 'Aylesworth Hall'
		WHEN Address LIKE '251 W Pitkin%' THEN 'Biology Building'
		WHEN Address LIKE '410 W Pitkin%' THEN 'BSB'
		WHEN Address LIKE '751 W PITKIN%' THEN 'Canvas Stadium'
		WHEN Address LIKE '1301 Center%' THEN 'Chemistry Building'
		WHEN Address LIKE '301 W Pitkin%' THEN 'Chemistry Research'
		WHEN Address LIKE '1200 Center%' THEN 'Clark Building'
		WHEN Address LIKE '151 W LAKE%' THEN 'CSU Medical Center'
		WHEN Address LIKE '531 W Plum%' THEN 'CSU Transit Center'
		WHEN Address LIKE '701 Oval%' THEN 'Danforth Chapel'
		WHEN Address LIKE '950 W Plum%' THEN 'Durrell Center'
		WHEN Address LIKE '1231 Center Aven%' THEN 'Eddy Hall'
		WHEN Address LIKE '1231 CENTER%' THEN 'Eddy Hall'
		WHEN Address LIKE '400 Isotope%' THEN 'Engineering Building'
		WHEN Address LIKE '501 W Plum%' THEN 'Engineering Lot'
		WHEN Address LIKE '430 N College%' THEN 'Engines Lab'
		WHEN Address LIKE '1251 S Mason%' THEN 'GSB'
		WHEN Address LIKE '920 Oval%' THEN 'Gibbons Hall'
		WHEN Address LIKE '502 W Lake%' THEN 'Gifford Building'
		WHEN Address LIKE '901 S Colleg%' THEN 'Glenn Morris Field House'
		WHEN Address LIKE '451 Isotope%' THEN 'Glover Building'
		WHEN Address LIKE '750 Meridian%' THEN 'Green Hall - CSUPD'
		WHEN Address LIKE '750 S Meridian%' THEN 'Green Hall - CSUPD'
		WHEN Address LIKE '600 Hughes%' THEN 'Hartshorn'
		WHEN Address LIKE '911 W Plum%' THEN 'HES Building'
		WHEN Address LIKE '1803 Bay%' THEN 'Horticulture Farm'
		WHEN Address LIKE '555 S Howes%' THEN 'HSBC'
		WHEN Address LIKE '821 W Plum%' THEN 'Indoor Practice Facility'
		WHEN Address LIKE '251 W Laurel%' THEN 'Industrial Sciences'
		WHEN Address LIKE '1150 S Mason%' THEN 'Jack Track'
		WHEN Address LIKE '950 Libbie Coy%' THEN 'Johnson Hall'
		WHEN Address LIKE '1508 Center%' THEN 'Lake St Parking Garage'
		WHEN Address LIKE '600 University%' THEN 'The Lagoon'
		WHEN Address LIKE '700 Oval%' THEN 'Laurel Hall'
		WHEN Address LIKE '1101 Center%' THEN 'Lory Student Center'
		WHEN Address LIKE '401 W Pitkin%' THEN 'Microbiology Building'
		WHEN Address LIKE '251 University%' THEN 'Military Science Building'
		WHEN Address LIKE '951 W Plum%' THEN 'Moby Arena'
		WHEN Address LIKE '1201 Center%' THEN 'Morgan Library'
		WHEN Address LIKE '201 W Pitkin%' THEN 'Motor Pool'
		WHEN Address LIKE '1345 Center%' THEN 'MRB'
		WHEN Address LIKE '400 University%' THEN 'Natural Resources Building'
		WHEN Address LIKE '1111 S Mason%' THEN 'NCGRP (Seed Lab)'
		WHEN Address LIKE '1231 LIBBIE COY%' THEN 'NESB'
		WHEN Address LIKE '850 Oval%' THEN 'Occupational Therapy Building'
		WHEN Address LIKE '1005 W Laurel%' THEN 'Palmer Center'
		WHEN Address LIKE '300 W Lake%' THEN 'Pathology'
		WHEN Address LIKE '630 W Lake%' THEN 'PERC'
		WHEN Address LIKE '1380 CENTER AVE%' THEN 'Physics Building'
		WHEN Address LIKE '400 W Lake%' THEN 'Physiology'
		WHEN Address LIKE '307 University%' THEN 'Plant Sciences'
		WHEN Address LIKE '1203 CENTER%' THEN 'The Plaza'
		WHEN Address LIKE '522 W Lake%' THEN 'Richardson Design Center'
		WHEN Address LIKE '501 W Laurel%' THEN 'Rockwell Hall'
		WHEN Address LIKE '523 W LAUREL%' THEN 'Rockwell West'
		WHEN Address LIKE '151 W Laurel%' THEN 'Routt Hall'
		WHEN Address LIKE '121 W Pitkin%' THEN 'S College Parking Garage'
		WHEN Address LIKE '700 S Mason%' THEN 'Sage Hall'
		WHEN Address LIKE '301 University%' THEN 'Shepardson Building'
		WHEN Address LIKE '150 Old Main%' THEN 'Spruce Hall'
		WHEN Address LIKE '851 Oval%' THEN 'Statistics Building'
		WHEN Address LIKE '951 Meridian%' THEN 'Student Rec Center'
		WHEN Address LIKE '201 W Lake%' THEN 'Surplus Property'
		WHEN Address LIKE '801 Oval%' THEN 'TILT Building'
		WHEN Address LIKE '2304 RESEARCH%' THEN 'Tennis Complex'
		WHEN Address LIKE '2400 Research%' THEN 'Tennis Courts'
		WHEN Address LIKE '1400 Remington%' THEN 'UCA'
		WHEN Address LIKE '1504 REMINGTON%' THEN 'University House on Remington'
		WHEN Address LIKE '1130 Max Guideway%' THEN 'University Max Station'
		WHEN Address LIKE '601 S Howes%' THEN 'University Services Center'
		WHEN Address LIKE '300 W Drake%' THEN 'VTH'
		WHEN Address LIKE '3745 E Prospect%' THEN 'Visitors Center'
		WHEN Address LIKE '551 W PITKIN%' THEN 'Visual Arts'
		WHEN Address LIKE '951 Amy Van%' THEN 'Wagar Building'
		WHEN Address LIKE '300 W PITKIN%' THEN 'Weed Research Facility'
		WHEN Address LIKE '1330 CENTER AV%' THEN 'Yates Hall'
			--Else the physical Address, I add 'p-' to the beginning to differentiate between addresses that were converted and addresses that were not.
		WHEN Address IS NULL THEN 'Missing Information'
		ELSE 'p-'+Address
	END AS 'location'
	,CASE
		WHEN Problem LIKE '%XTRA P%' THEN 'EXTRA PATROL'
		WHEN Problem LIKE '%IRECTED P%' THEN 'DIRECTED PATROL'
		ELSE Problem
	END AS 'problem'
	,CASE
		WHEN Problem LIKE '%Patrol' THEN 'Patrols'
		WHEN Problem LIKE 'Traffic%' THEN 'Traffic'
		WHEN Problem LIKE 'Out%' THEN 'Out-of-Service'
		Else 'All Others'
	END AS 'problem_category'
	,CASE
		WHEN (Call_Back_Phone IS NULL OR Call_Back_Phone = '') AND Problem = 'BIKE THEFT' THEN 'Call-for-Service'
		WHEN (Call_Back_Phone IS NULL OR Call_Back_Phone = '') AND Problem LIKE 'THEF%' THEN 'Call-for-Service'
		WHEN Call_Back_Phone IS NULL OR Call_Back_Phone = '' THEN 'Department-Initiated'
		ELSE 'Call-for-Service'
	END AS 'origin'
	,CONVERT(VARCHAR(10), Response_Date, 101) AS 'date'
	,CONVERT(VARCHAR(10), Response_Date, 108) AS 'time'
	,YEAR(Response_Date) AS 'year'
	,Time_CallEnteredQueue AS 'time_call_entered_queue'
	,Time_First_Unit_Arrived AS 'time_first_unit_arrived'
	,DATEDIFF(s, Time_CallEnteredQueue, Time_First_Unit_Arrived) AS 'response_secs'
	,DATEDIFF(s, Time_CallEnteredQueue, Time_First_Unit_Arrived)/60.0 AS 'response_mins'
	,CASE
		WHEN DATEDIFF(s, Time_CallEnteredQueue, Time_First_Unit_Arrived) < 0 THEN 'exclude'
		ELSE 'accurate'
	END AS 'response_time_category'
	,Priority_Number AS 'priority_code'
	,CASE
		WHEN Priority_Number = 1 THEN 'Emergency'
		WHEN Priority_Number = 2 THEN 'Urgent'
		Else 'Non-Emergency'
	END AS 'priority_desc'
	,CASE
		WHEN Caller_Building IN ('J50530', 'J50541', 'J50611', 'J50640', 'J50741', 'J50811', 'J50821', 'J50830', 'J51415', 'J51416', 'J51417', 'J51422',
					 'J51423', 'J51424', 'J51425', 'J51426', 'J51427', 'J51432', 'J51433', 'J51434', 'J51442', 'J51443', 'J51444', 'J51445', 
					 'J51511', 'J51512', 'J51513','J51711 ', 'J51720', 'J51721', 'J51811', 'J51841', 'J52014', 'J52033', 'J52042', 'J52313', 
					 'J52321') THEN 'Main Campus'
		ELSE 'Other Properties'
	END AS 'location_type'
	,CASE
		WHEN Address LIKE '%810 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%816 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%800 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%511 W Lake%' THEN 'housing'
		WHEN Address LIKE '%521 W Lake%' THEN 'housing'
		WHEN Address LIKE '%501 W Lake%' THEN 'housing'
		WHEN Address LIKE '%551 W Laurel%' THEN 'housing'
		WHEN Address LIKE '%500 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%801 W Laurel%' THEN 'housing'
		WHEN Address LIKE '%1001 W Laurel%' THEN 'housing'
		WHEN Address LIKE '%900 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%1000 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%910 W Plum%' THEN 'housing'
		WHEN Address LIKE '%920 W Plum%' THEN 'housing'
		WHEN Address LIKE '%900 W Plum%' THEN 'housing'
		WHEN Address LIKE '%700 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%701 W Laurel%' THEN 'housing'
		WHEN Address LIKE '%963 W Pitkin%' THEN 'housing'
		WHEN Address LIKE '%1009 W Laurel%' THEN 'housing'
		ELSE 'other'
	END AS 'residence'
	,'-'+ LEFT(Longitude, 3) + '.' + RIGHT(Longitude, 6) AS 'longitude'
	,LEFT(Latitude, 2) + '.' + RIGHT(Latitude, 6) AS 'latitude'
	,M.Call_Disposition AS 'disposition'
	,ROW_NUMBER() OVER (partition BY Master_Incident_Number ORDER BY V.Radio_Name DESC) AS 'incident_count'
FROM
	Reporting_System.dbo.Response_Master_Incident M
	INNER JOIN Reporting_System.dbo.Response_Vehicles_Assigned V
		ON M.Id = V.master_incident_id
WHERE
	V.Radio_Name LIKE '5%'
	AND
	NOT(Master_Incident_Number IS NULL 
		OR Master_Incident_Number = '')
	AND
	Response_Date > @ThreeYearsAgo
	AND
	problem NOT IN ('TEST CALL', '_Blank', '1610Am Radio', 'On Foot')
)
SELECT
	incident_number,
	CASE
		WHEN location LIKE 'p-%' THEN SUBSTRING(location, CHARINDEX('-', location)+1, len(location)-CHARINDEX('-', location))
		ELSE location
	END AS 'location',
	CASE
		WHEN location LIKE 'p-%' THEN 'False'
		ELSE 'True'
	END AS 'location_id',
	location_type,
	problem,
	problem_category,
	origin,
	date,
	time,
	year,
	time_call_entered_queue,
	time_first_unit_arrived,
	response_secs,
	response_mins,
	response_time_category,
	priority_code,
	priority_desc,
	residence,
	longitude,
	latitude,
	disposition,
	incident_count
FROM
	cad_incidents
WHERE
	incident_count = 1
	AND latitude != '0.0'
ORDER BY
	date;
