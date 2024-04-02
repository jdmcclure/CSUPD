DECLARE @begin AS datetime
DECLARE @end AS datetime
set @begin = '01/01/2023'
set @end = '12/31/2023'

SELECT
	Incident.CaseNumber AS 'case'
	,IncidentEvent.description_Description AS 'type'
	,IncidentOffense.ViolationCodeReference_Description AS 'offense'
	,IncidentEvent.dateReported AS 'date_reported'
	,IncidentEvent.address_streetAddress AS 'address'
FROM
	InformRMSSummaries.Reporting.Incident Incident
	INNER JOIN 
		InformRMSSummaries.Reporting.IncidentEvent IncidentEvent
			ON Incident.Id = IncidentEvent.Incident_Id
	INNER JOIN
		InformRMSSummaries.Reporting.IncidentOffense IncidentOffense
			ON Incident.Id = IncidentOffense.Incident_Id

WHERE
	--YEAR(IncidentEvent.dateReported) = '2022'
	IncidentEvent.dateReported >= @begin
	AND
	IncidentEvent.dateReported <= @end
	AND -- Clery Geo
	(	-- Main Campus
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.567000 AND 40.578500
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.096250 AND -105.076750)
		OR -- UCA/Flower Garden
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.568675 AND 40.571125
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.077125 AND -105.071950)
		OR -- South Campus/VTH
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.552450 AND 40.559000
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.088200 AND -105.080210)
		OR -- Aggie Family
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.563500 AND 40.567300
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.086900 AND -105.083350)
		OR -- West Campus (North)
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.588068 AND 40.597275
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.161800 AND -105.133850)
		OR -- West Campus (South)
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.575093 AND 40.586818
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.156425 AND -105.133938)
		OR -- HSBC to Campus
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.578075 AND 40.580818
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.081683 AND -105.080700)
		OR -- Home Management
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.578075 AND 40.578880
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.080216 AND -105.079798)
		OR -- Third Rock
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.578075 AND 40.578928
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.084400 AND -105.083625)
		OR -- Office of Inclusive Excellence
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.577840 AND 40.579034
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.097400 AND -105.095825)
		OR -- Plum Corridor (to UV/IH)
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.576480 AND 40.576655
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.100735 AND -105.095850)
		OR -- IH
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.574529 AND 40.576560
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.102000 AND -105.100632)
		OR -- UV (1500 and 1600)
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.576532 AND 40.578700
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.105415 AND -105.100610)
		OR -- UV (1700)
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.576450 AND 40.577500
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.109760 AND -105.105400)
		OR -- ELC (North)
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.560275 AND 40.566795
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.020615 AND -105.016800)
		OR -- ELC (South)
		(try_convert(numeric(12, 9), IncidentEvent.address_latitude) BETWEEN 40.551430 AND 40.560310
			AND
		try_convert(numeric(12, 9), IncidentEvent.address_longitude) BETWEEN -105.020450 AND -105.007678)
		OR IncidentEvent.address_streetAddress LIKE '%1504 Remington%' -- University House on Remington
		OR IncidentEvent.address_streetAddress LIKE '%705 S Shields%' -- Alpha Gamma Rho (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%1112 Birch%' -- Chi Omega (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%1307 Birch%' -- Delta Delta Delta (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%633 W Lake%' -- FarmHouse (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%733 S Shields%' -- Gamma Phi Beta (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%708 City Park%' -- Kappa Alpha Theta (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%412 W Laurel%' -- Kappa Delta (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%729 S Shields%' -- Kappa Kappa Gamma (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%801 S Shields%' -- Kappa Sigma (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%200 E Plum%' -- Phi Delta Theta (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%625 W Lake%' -- Pi Beta Phi (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%1300 Baystone%' -- Pi Kappa Phi (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%406 W Laurel%' -- Sigma Nu (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%121 E Lake%' -- Sigma Phi Epsilon (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%201 E Elizabeth%' -- Sigma Pi (Fraternity)
		OR IncidentEvent.address_streetAddress LIKE '%1225 Baystone%' -- Zeta Tau Alpha (Sorority)
		OR IncidentEvent.address_streetAddress LIKE '%3028 Timberline%'
		OR IncidentEvent.address_streetAddress LIKE '%1304 S Shields%'
		OR IncidentEvent.address_streetAddress LIKE '%2150 Centre%'
		OR IncidentEvent.address_streetAddress LIKE '%2301 Research%'
		OR IncidentEvent.address_streetAddress LIKE '%2243 Center%'  -- Crabtree Hall
		OR IncidentEvent.address_streetAddress LIKE '%6432 Grand Tree%'  -- Harmoney Center Golf Practice Facility
		OR IncidentEvent.address_streetAddress LIKE '%16321 W CR 44H%'  -- Mountain Campus
		OR IncidentEvent.address_streetAddress LIKE '%4825 W CR 52E%'  -- Tamasag
		OR IncidentEvent.address_streetAddress LIKE '%223 S Shields%'  -- ECC
		OR IncidentEvent.address_streetAddress LIKE '%430 N College%'  -- Powerhouse Energy Campus
		OR IncidentEvent.address_streetAddress LIKE '%3745 E Prospect%'  -- Visitors Center
	)
	AND 
	(IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0102%'  -- Murder/Manslaughter (6)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-102%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-103%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0103%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-104%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0104%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-105%'  -- Negligent Manslaughter (2)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-105%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-402%'  -- Sexual Assault (8)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0402%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-403%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0403%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-404%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0404%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-405%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0405%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '%SEXUAL ASSAUL%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-6-301%'  -- Incest (4)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-06-0301%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-6-302%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-06-0302%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-301%'  -- Robbery (6)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0301%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-302%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0302%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-303%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0303%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-202%'   -- Assault (8)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0202%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-203%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0203%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-204%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0204%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-205%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0205%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-202%'   -- Burglary (6)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0202%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-203%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0203%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-204%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0204%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-409%'  -- Motor Vehicle Theft (2)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0409%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-102%'  -- Arson (8)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0102%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-103%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0103%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-104%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-04-0104%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-4-105%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-040-0105%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-102%'  -- Weapon Violations (12)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-0102%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-105%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-0105%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-106%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-0106%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-108%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-12-0108%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-206%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0206%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-9-106%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-09-0106%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-428%'  -- Drug Offenses (8)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-0428%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-429%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-0429%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-403%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-0403%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-405%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-18-0405%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '12-47-901%'  --Alcohol Offenses(10)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-13-122%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-13-0122%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '42-4-1305%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '42-04-1305%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '42-4-805%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '42-04-0805%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '44-3-901%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '44-03-0901%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE 'FC-17-167%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-6-801%'  --Domestic Violence(4)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-06-0801%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-9-111%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-09-0111%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-3-602%'  -- Stalking (4)
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-03-0602%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-9-111%'
	OR IncidentOffense.ViolationCodeReference_Code LIKE '18-09-0111%'
	)
	
ORDER BY
	IncidentEvent.dateReported;