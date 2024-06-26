USE InformRMSSummaries;
WITH incidents AS(
SELECT
	OE.Number AS 'number'
	,OE.CaseNumber AS 'case_number'
	,CASE
		WHEN address_streetAddress LIKE '800 W Pitkin%' THEN 'AV - Aspen Hall'
		WHEN address_streetAddress LIKE '820 W Pitkin%' THEN 'AV - Commons'
		WHEN address_streetAddress LIKE '816 W Pitkin%' THEN 'AV - Engineering'
		WHEN address_streetAddress LIKE '810 W Pitkin%' THEN 'AV - Honors'
		WHEN address_streetAddress LIKE '551 W Laurel%' THEN 'Allison Hall'
		WHEN address_streetAddress LIKE '1101 Braiden%' THEN 'Braiden Hall'
		WHEN address_streetAddress LIKE '500 W Pitkin%' THEN 'Braiden Hall'
		WHEN address_streetAddress LIKE '801 W Laurel%' THEN 'Corbett Hall'
		WHEN address_streetAddress LIKE '511 W Lake%' THEN 'Cottonwood Hall'
		WHEN address_streetAddress LIKE '1001 W Laurel%' THEN 'Durward Hall'
		WHEN address_streetAddress LIKE '900 W Pitkin%' THEN 'Edwards Hall'
		WHEN address_streetAddress LIKE '1000 W Pitkin%' THEN 'Ingersoll Hall'
		WHEN address_streetAddress LIKE '1400 W Elizabeth%' THEN 'International House'
		WHEN address_streetAddress LIKE '910 W Plum%' THEN 'Alpine Hall'
		WHEN address_streetAddress LIKE '701 W Laurel%' THEN 'Parmelee Hall'
		WHEN address_streetAddress LIKE '920 W Plum%' THEN 'The Pavilion'
		WHEN address_streetAddress LIKE '900 W Plum%' THEN 'Pinon Hall'
		WHEN address_streetAddress LIKE '521 W Lake%' THEN 'Lodgepole'
		WHEN address_streetAddress LIKE '700 W Pitkin%' THEN 'Newsom Hall'
		WHEN address_streetAddress LIKE '963 W Pitkin%' THEN 'Summit Hall'
		WHEN address_streetAddress LIKE '1500 W Plum%' THEN 'University Village - 1500'
		WHEN address_streetAddress LIKE '1600 W Plum%' THEN 'University Village - 1600'
		WHEN address_streetAddress LIKE '1700 W Plum%' THEN 'University Village - 1700'
		WHEN address_streetAddress LIKE '501 W Lake%' THEN 'Walnut'
		WHEN address_streetAddress LIKE '1009 W Laurel%' THEN 'Westfall Hall'
			--General Campus Buildings
		WHEN address_streetAddress LIKE '900 Oval%' THEN 'Admin Building'
		WHEN address_streetAddress LIKE '1350 Center%' THEN 'Anatomy/Zoology'
		WHEN address_streetAddress LIKE '350 W Pitkin%' THEN 'Animal Sciences'
		WHEN address_streetAddress LIKE '1100 Meridian%' THEN 'Aylesworth Hall'
		WHEN address_streetAddress LIKE '410 W Pitkin%' THEN 'BSB'
		WHEN address_streetAddress LIKE '701 W Pitkin%' THEN 'Alumni Center'
		WHEN address_streetAddress LIKE '1301 Center%' THEN 'Chemistry Building'
		WHEN address_streetAddress LIKE '1200 Center%' THEN 'Clark Building'
		WHEN address_streetAddress LIKE '701 Oval%' THEN 'Danforth Chapel'
		WHEN address_streetAddress LIKE '400 Isotope%' THEN 'Engineering Building'
		WHEN address_streetAddress LIKE '1251 S Mason%' THEN 'GSB'
		WHEN address_streetAddress LIKE '920 Oval%' THEN 'Gibbons Hall'
		WHEN address_streetAddress LIKE '502 W Lake%' THEN 'Gifford Building'
		WHEN address_streetAddress LIKE '451 Isotope%' THEN 'Glover Building'
		WHEN address_streetAddress LIKE '750 Meridian%' THEN 'Green Hall - CSUPD'
		WHEN address_streetAddress LIKE '750 S Meridian%' THEN 'Green Hall - CSUPD'
		WHEN address_streetAddress LIKE '911 W Plum%' THEN 'HES Building'
		WHEN address_streetAddress LIKE '501 W Plum%' THEN 'Engineering Lot'
		WHEN address_streetAddress LIKE '251 W Pitkin%' THEN 'Biology Building'
		WHEN address_streetAddress LIKE '531 W Plum%' THEN 'CSU Transit Center'
		WHEN address_streetAddress LIKE '555 S Howes%' THEN 'HSBC'
		WHEN address_streetAddress LIKE '821 W Plum%' THEN 'Indoor Practice Facility'
		WHEN address_streetAddress LIKE '251 W Laurel%' THEN 'Industrial Sciences'
		WHEN address_streetAddress LIKE '950 Libbie Coy%' THEN 'Johnson Hall'
		WHEN address_streetAddress LIKE '600 University%' THEN 'The Lagoon'
		WHEN address_streetAddress LIKE '700 Oval%' THEN 'Laurel Hall'
		WHEN address_streetAddress LIKE '1101 Center%' THEN 'Lory Student Center'
		WHEN address_streetAddress LIKE '401 W Pitkin%' THEN 'Microbiology Building'
		WHEN address_streetAddress LIKE '251 University%' THEN 'Military Science Building'
		WHEN address_streetAddress LIKE '951 W Plum%' THEN 'Moby Arena'
		WHEN address_streetAddress LIKE '1201 Center%' THEN 'Morgan Library'
		WHEN address_streetAddress LIKE '201 W Pitkin%' THEN 'Motor Pool'
		WHEN address_streetAddress LIKE '1345 Center%' THEN 'MRB'
		WHEN address_streetAddress LIKE '400 University%' THEN 'Natural Resources Building'
		WHEN address_streetAddress LIKE '1111 S Mason%' THEN 'Seed Lab (NCGRP)'
		WHEN address_streetAddress LIKE '850 Oval%' THEN 'Occupational Therapy Building'
		WHEN address_streetAddress LIKE '1005 W Laurel%' THEN 'Palmer Center'
		WHEN address_streetAddress LIKE '1508 Center%' THEN 'Lake St Parking Garage'
		WHEN address_streetAddress LIKE '300 W Lake%' THEN 'Pathology'
		WHEN address_streetAddress LIKE '630 W Lake%' THEN 'PERC'
		WHEN address_streetAddress LIKE '400 W Lake%' THEN 'Physiology'
		WHEN address_streetAddress LIKE '307 University%' THEN 'Plant Sciences'
		WHEN address_streetAddress LIKE '151 W Laurel%' THEN 'Routt Hall'
		WHEN address_streetAddress LIKE '700 S Mason%' THEN 'Sage Hall'
		WHEN address_streetAddress LIKE '301 University%' THEN 'Shepardson Building'
		WHEN address_streetAddress LIKE '150 Old Main%' THEN 'Spruce Hall'
		WHEN address_streetAddress LIKE '921 Oval%' THEN 'Statistics Building'
		WHEN address_streetAddress LIKE '951 Meridian%' THEN 'Student Rec Center'
		WHEN address_streetAddress LIKE '201 W Lake%' THEN 'Surplus Property'
		WHEN address_streetAddress LIKE '1400 Remington%' THEN 'UCA'
		WHEN address_streetAddress LIKE '801 Oval%' THEN 'TILT Building'
		WHEN address_streetAddress LIKE '2400 Research%' THEN 'CSU Tennis Courts'
		WHEN address_streetAddress LIKE '1130 Max Guideway%' THEN 'University Max Station'
		WHEN address_streetAddress LIKE '601 S Howes%' THEN 'USC'
		WHEN address_streetAddress LIKE '300 W Drake%' THEN 'VTH'
		WHEN address_streetAddress LIKE '3745 E Prospect%' THEN 'Visitors Center'
		WHEN address_streetAddress LIKE '1380 CENTER AVE%' THEN 'Physics/Physiology'
		WHEN address_streetAddress LIKE '1231 LIBBIE COY%' THEN 'NESB'
		WHEN address_streetAddress LIKE '551 W PITKIN%' THEN 'Visual Arts'
		WHEN address_streetAddress LIKE '851 Oval%' THEN 'Statisics Building'
		WHEN address_streetAddress LIKE '951 Amy Van%' THEN 'Wagar Building'
		WHEN address_streetAddress LIKE '501 W Laurel%' THEN 'Rockwell Hall'
		WHEN address_streetAddress LIKE '430 N College%' THEN 'Engines Lab'
		WHEN address_streetAddress LIKE '600 Hughes%' THEN 'Hartshorn'
		WHEN address_streetAddress LIKE '901 S College%' THEN 'Glenn Morris Field House'
		WHEN address_streetAddress LIKE '1203 CENTER%' THEN 'The Plaza'
		WHEN address_streetAddress LIKE '1803 Bay%' THEN 'Horticulture Farm'
		WHEN address_streetAddress LIKE '522 W Lake%' THEN 'Richardson Design Center'
		WHEN address_streetAddress LIKE '1150 S Mason%' THEN 'Jack Track'
		WHEN address_streetAddress LIKE '121 W Pitkin%' THEN 'S College Parking Garage'
		WHEN address_streetAddress LIKE '1231 CENTER%' THEN 'Eddy Hall'
		WHEN address_streetAddress LIKE '950 W Plum%' THEN 'Durrell Center'
		WHEN address_streetAddress LIKE '2304 RESEARCH%' THEN 'Tennis Complex'
		WHEN address_streetAddress LIKE '1504 REMINGTON%' THEN 'University House on Remington'
		WHEN address_streetAddress LIKE '300 W PITKIN%' THEN 'Weed Research Facility'
		WHEN address_streetAddress LIKE '151 W LAKE%' THEN 'CSU Medical Center'
		WHEN address_streetAddress LIKE '751 W PITKIN%' THEN 'Canvas Stadium'
		WHEN address_streetAddress LIKE '1330 CENTER AV%' THEN 'Yates Hall'
		WHEN address_streetAddress LIKE '501 W PROSPECT%' THEN 'Aggie Village Family'
		WHEN address_streetAddress LIKE '523 W LAUREL%' THEN 'Rockwell West'
		ELSE address_streetAddress
	END AS 'location'
	,OEE.startDate AS 'date_impounded'
	,OEP.BikeBrand_Description AS 'brand'
	,OEP.color AS 'color'
	,OEP.serial AS 'serial'
	,OEP.ReleaseDate AS 'release_date'
	,OEP.registrationNumber AS 'registration_number'
	,ROW_NUMBER() OVER (partition BY OE.Number ORDER BY OE.Number) AS 'incident_count'
FROM
	Reporting.OtherEvent OE
	LEFT JOIN Reporting.OtherEventEvent OEE
		ON OE.Id = OEE.OtherEvent_Id
	INNER JOIN Reporting.OtherEventProperty OEP
		ON OE.Id = OEP.OtherEvent_Id
WHERE
	OEE.startDate > DATEADD(MILLISECOND, -3, '01/01/2021')
	AND
	OE.Number LIKE '%IMP%'
	AND
	OEP.ReleaseDate IS NULL
)
SELECT
	number
	,case_number
	,location
	,date_impounded
	,release_date
	,DATEDIFF(dd, date_impounded, GETDATE()) AS 'days_in_impound'
	,brand
	,color
	,serial
	,registration_number
FROM
	incidents
WHERE
	incident_count = 1;