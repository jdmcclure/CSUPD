DECLARE @ThreeYearsAgo DATE = DATEADD(YEAR, -3, GETDATE())

;WITH traffic_violations AS (

SELECT
	CASE
		WHEN Citation.Number LIKE 'CS20-%' THEN LTRIM(REPLACE(Citation.Number, 'CS20-00', ''))
		WHEN startDate <= '20201231' THEN LTRIM(REPLACE(Citation.Number, 'CSUP_', ''))
		ELSE Citation.Number
	END AS 'citation_number'
	,startDate AS 'date'
	,CitationCharge.ViolationCodeReference_Code AS	'CRS'
	,CitationCharge.ViolationCodeReference_Description AS 'original_charge'
	,CASE
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%BICYCLE RIDER ON (SIDEWALK%'	THEN 'Drove on Sidewalk'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%DROVE ON SIDEWALK%'			THEN 'Drove on Sidewalk'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%RODE BIKE ON SIDE%'			THEN 'Drove on Sidewalk'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%SIDEWALKS & TRAILS%'			THEN 'Drove on Sidewalk'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%WITH ONE BRAKE%'				THEN 'Brake Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%CARELESS DRIVING%'			THEN 'Careless Driving'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%CHILD RESTRAINT%'				THEN 'Child Restraint Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%SEATBELT%'					THEN 'Seatbelt Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%SAFETY BELT%'					THEN 'Seatbelt Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%DRIVER%%%LICENSE%'			THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LICENSE UNDER RESTRAINT%'		THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%UNLICENSED%'					THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%INSTRUCT/PERMIT%'				THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%DROVE SUSP/REVOKED%'			THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%DRIVERS LIC%'					THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%REVOCATION%'					THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%VIOLATED RESTRICTIONS ON TEMP%'	THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LICENSE REVOKED%'				THEN 'Driver''s License Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%DRIVING ON LAWN%'				THEN 'Driving on Lawn or Path'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FAST FOR CONDITIONS%'			THEN 'Driving Too Fast for Conditions'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%1101(3)%'						THEN 'Driving Too Fast for Conditions'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%MARIJUANA%'					THEN 'Drug Law Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%USE OF NATURAL MEDICINE%'		THEN 'Drug Law Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FAILED TO DIM LIGHTS%'		THEN 'Failed to Dim Lights'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LANE%'						THEN 'Traffic Lane Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%TRAFFIC CONTROL%'				THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%TRAFF CONTROL%'				THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%RAILROAD SIGNAL%'				THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%TRAFFIC CNTRL SIGNAL%'		THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FAILED TO STOP AT RED LIGHT%'	THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%VIOL RED LIGHT%'				THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%STOP SIGN%'					THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%PED FAIL OBEY%'				THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%OBEY TRAFF CNTRL%'			THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%ENTER HWY STOP%'				THEN 'Traffic Control Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FAILED TO YIELD RIGHT-OF-WAY%'THEN 'Failure to Yield Right of Way'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FAIL YIELD TO%'				THEN 'Failure to Yield Right of Way'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%YIELD ROW%'					THEN 'Failure to Yield Right of Way'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FAIL OBEY PED%'				THEN 'Failure to Yield Right of Way'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%IMPROPER PASSING%'			THEN 'Improper Passing'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%TURN%'						THEN 'Improper Turn'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%INSURANCE%'					THEN 'Insurance Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%UNINSURED%'					THEN 'Insurance Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%PLATES%'						THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%EXPIRED TEMPORARY PERMIT%'	THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%EXPIRED TEMP PERMIT%'			THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%Expired Temporary Plate%'		THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LICENSE PLATE REQUIRE%'		THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LICENSE PLATE FASTEN%'		THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%PLATE OBSTRUCTED%'			THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%NUMBER PLATE%'				THEN 'License Plate Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LAMPS%'						THEN 'Light/Headlamp Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%ALCOHOL%'						THEN 'Liquor Law Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%OPEN CONTAINER%'				THEN 'Liquor Law Violation'
		WHEN CitationCharge.ViolationCodeReference_Description IS NULL								THEN 'Missing'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%OTHER (SPECIFY)%'				THEN 'Other - Not Classified'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%OTHER STATE%'					THEN 'Other - Not Classified'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%RECKLESS%'					THEN 'Reckless Driving'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%REGIST%'						THEN 'Registration Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%DISMOUNT ZONE%'				THEN 'Riding in a Dismount Zone'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%EXHIBITION%'					THEN 'Speed Exhibition'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%SPEED CONTEST%'				THEN 'Speed Exhibition'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%SPEEDING 1-4%'				THEN 'Speeding 01-04 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%5-9 MPH%'						THEN 'Speeding 05-09 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%5 TO 9 MPH%'					THEN 'Speeding 05-09 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%10-19 MPH%'					THEN 'Speeding 10-19 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%10 TO 19%'					THEN 'Speeding 10-19 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%20-24%'						THEN 'Speeding 20-24 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%20 TO 24%'					THEN 'Speeding 20-24 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%25-39%'						THEN 'Speeding 25-39 Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%40+%'							THEN 'Speeding 40+ Over'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%SPEED LIMIT VIOLATION%'		THEN 'Speeding (Unspecified)'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%1101(1)%'						THEN 'Speeding (Unspecified)'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%TURN SIGNAL%'					THEN 'Turn Signal Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%UNSAFE BACKING%'				THEN 'Unsafe Backing'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%INTERLOCK%'					THEN 'Interlock Device Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%ONE-WAY%'						THEN 'Wrong Way on One-Way'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%ONE WAY%'						THEN 'Wrong Way on One-Way'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%WRONG SIDE OF ROAD%'			THEN 'Drove on Wrong Side of Road'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%PARK%'						THEN 'Parking Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%PARKING STRUCTURE FEES%'		THEN 'Parking Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%ENTERING ROADWAY%'			THEN 'Entering Roadway Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%EXIT/ENTER%'					THEN 'Entering Roadway Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FOLLOWING TOO CLOSELY%'		THEN 'Following Too Closely'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LEFT PLACE OF SAFETY%'		THEN 'Left Place of Safety'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%OBSTRUC DRIVER%'				THEN 'Vision Obstructed'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%VISION OBSTRUC%'				THEN 'Vision Obstructed'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%TEXTING%'						THEN 'Texting While Driving'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%EQUIPMENT%'					THEN 'Equipment Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%LIGHT EQUIP%'					THEN 'Equipment Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%BLUE LIGHT%'					THEN 'Equipment Violation'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%THEFT%'						THEN 'Theft'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%CRIMINAL MISCHIEF%'			THEN 'Criminal Mischief'
		WHEN CitationCharge.ViolationCodeReference_Description LIKE '%FALSE REPORTING%'				THEN 'False Reporting'
		ELSE 'Other'
	END AS 'description'

FROM
	InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_Citation Citation
	INNER JOIN InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_CitationEvent CitationEvent
		ON Citation.Id = CitationEvent.Citation_Id
	INNER JOIN InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_CitationCharge CitationCharge
		ON Citation.Id = CitationCharge.Citation_Id
WHERE
	startDate > DATEADD(millisecond, -3, '01/01/2017')
)
SELECT
	CASE
		WHEN citation_number IN ('27454', 
								'27456', 
								'27576', 
								'27577', 
								'27579', 
								'27580', 
								'27581', 
								'27578',
								'25440',
								'25546',
								'25547',
								'25630',
								'25631',
								'26113',
								'26116',
								'26156',
								'26307') AND date < '12/31/2020' THEN citation_number + '-1'
		ELSE citation_number
	END AS 'citation_number'
	,date
	,CRS
	,original_charge
	,description
	,CASE
		WHEN description LIKE 'Speeding%' THEN 'Speed'
		ELSE description
	END AS 'summary'
	,CASE
		WHEN description IN ('Other',
							'Missing',
							'Unsafe Backing',
							'License Plate Violation',
							'Registration Violation',
							'Insurance Violation',
							'Other - Not Classified',
							'Equipment Violation',
							'Interlock Device Violation',
							'Brake Violation',
							'Seatbelt Violation',
							'Failed to Dim Lights',
							'Failure to Pay Parking Fees',
							'Driver''s License Violation',
							'Light/Headlamp Violation')
			THEN 'Other'
		WHEN description IN ('Drug Law Violation',
							'Liquor Law Violation')
			THEN 'Substance'
		ELSE 'Safety'
	END AS 'classification'
	,CASE
		WHEN citation_number LIKE '5S%' OR citation_number IN ('5286155')
			THEN 'Court'
		WHEN description IN ('Drug Law Violation',
							'Liquor Law Violation')
			THEN 'CSUSA'
		ELSE 'TEEP'
	END AS 'type'
	,CASE
		WHEN date < '09/01/2019' AND description IN ('Drove on Sidewalk', 
													'Improper Turn', 
													'Wrong Way on One-Way',
													'Traffic Control Device Violation') 
														THEN 85
		WHEN date >= '09/01/2019' AND description IN ('Drove on Sidewalk',
													'Improper Turn',
													'Wrong Way on One-Way',
													'Traffic Control Device Violation') 
														THEN 100
		WHEN date < '09/01/2019' AND description IN ('Speeding 05-09 Over',
													'Unsafe Backing')
														THEN 50
		WHEN date >= '09/01/2019' AND description IN ('Speeding 05-09 Over')
														THEN 75
		WHEN date < '09/01/2019' AND description IN ('Speeding 10-19 Over'
													,'Careless Driving'
													,'Failure to Yield Right of Way'
													,'Careless Driving')
														THEN 100
		WHEN date >= '09/01/2019' AND description IN ('Speeding 10-19 Over'
													 ,'Careless Driving'
													 ,'Failure to Yield Right of Way'
													 ,'Careless Driving')
														THEN 125
		ELSE NULL
	END AS 'fee'
FROM
	traffic_violations;