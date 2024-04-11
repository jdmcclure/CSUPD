-- A query that pulls bike thefts entered into the RMS system in the last 30 days.
SELECT
	CaseNumber AS 'case'
	,dateReported AS 'reported_date'
	,CASE
		WHEN address_streetAddress = '800 W PITKIN ST' THEN 'AV-Aspen Hall'
		WHEN address_streetAddress = '820 W PITKIN ST' THEN 'AV-Commons'
		WHEN address_streetAddress = '816 W PITKIN ST' THEN 'AV-Engineering'
		WHEN address_streetAddress = '810 W PITKIN ST' THEN 'AV-Honors'
		WHEN address_streetAddress = '511 W LAKE ST' THEN 'Aggie Cottonwood'
		WHEN address_streetAddress = '501 W PROSPECT RD' THEN 'Aggie Family'
		WHEN address_streetAddress = '521 W LAKE ST' THEN 'Aggie Lodgepole'
		WHEN address_streetAddress = '501 W LAKE ST' THEN 'Aggie Walnut'
		WHEN address_streetAddress = '551 W LAUREL ST' THEN 'Allison Hall'
		WHEN address_streetAddress = '500 W PITKIN ST' THEN 'Braiden Hall'
		WHEN address_streetAddress = '801 W LAUREL ST' THEN 'Corbett Hall'
		WHEN address_streetAddress = '1001 W LAUREL ST' THEN 'Durward Hall'
		WHEN address_streetAddress = '900 W PITKIN ST' THEN 'Edwards Hall'
		WHEN address_streetAddress = '1000 W PITKIN ST' THEN 'Ingersoll Hall'
		WHEN address_streetAddress = '1400 W ELIZABETH ST' THEN 'International House'
		WHEN address_streetAddress = '910 W PLUM ST' THEN 'LV-Alpine Hall'
		WHEN address_streetAddress = '920 W PLUM ST' THEN 'LV-Pavilion'
		WHEN address_streetAddress = '900 W PLUM ST' THEN 'LV-Pinon Hall'
		WHEN address_streetAddress = '700 W PITKIN ST' THEN 'Newsom Hall'
		WHEN address_streetAddress = '701 W LAUREL ST' THEN 'Parmelee Hall'
		WHEN address_streetAddress = '963 W PITKIN ST' THEN 'Summit Hall'
		WHEN address_streetAddress = '1009 W Laurel St' THEN 'Westfall Hall'
		WHEN address_streetAddress = '1500 W PLUM ST' THEN 'UV-1500'
		WHEN address_streetAddress = '1600 W PLUM ST' THEN 'UV-1600'
		WHEN address_streetAddress = '1700 W PLUM ST' THEN 'UV-1700'
		WHEN address_streetAddress = '900 OVAL DR' THEN 'Admin Building'
		WHEN address_streetAddress = '1350 CENTER AV' THEN 'Anatomy/Zoology'
		WHEN address_streetAddress = '350 W PITKIN ST' THEN 'Animal Sciences'
		WHEN address_streetAddress = '1100 MERIDIAN AV' THEN 'Aylesworth Hall'
		WHEN address_streetAddress = '410 W PITKIN ST' THEN 'BSB'
		WHEN address_streetAddress = '1301 CENTER AV' THEN 'Chemistry Building'
		WHEN address_streetAddress = '1200 CENTER AV' THEN 'Clark Building'
		WHEN address_streetAddress = '400 ISOTOPE DR' THEN 'Engineering Building'
		WHEN address_streetAddress = '1251 S MASON ST' THEN 'GSB'
		WHEN address_streetAddress = '502 W LAKE ST' THEN 'Gifford Building'
		WHEN address_streetAddress = '451 ISOTOPE DR' THEN 'Glover Building'
		WHEN address_streetAddress = '750 S MERIDIAN AV' THEN 'Green Hall - CSUPD'
		WHEN address_streetAddress = '251 W PITKIN ST' THEN 'Biology Building'
		WHEN address_streetAddress = '555 S HOWES ST' THEN 'HSBC'
		WHEN address_streetAddress = '821 W PLUM ST' THEN 'Indoor Practice Field'
		WHEN address_streetAddress = '700 OVAL DR' THEN 'Laurel Hall'
		WHEN address_streetAddress = '401 W PITKIN' THEN 'Microbiology Building'
		WHEN address_streetAddress = '251 UNIVERSITY AV' THEN 'Military Science Building'
		WHEN address_streetAddress = '951 W PLUM' THEN 'Moby Arena'
		WHEN address_streetAddress = '1201 CENTER AV' THEN 'Morgan Library'
		WHEN address_streetAddress = '1201 Center Avenue Mall' THEN 'Morgan Library'
		WHEN address_streetAddress = '1345 CENTER AV' THEN 'MRB'
		WHEN address_streetAddress = '400 UNIVERSITY AV' THEN 'Natural Resources Building'
		WHEN address_streetAddress = '1508 CENTER AV' THEN 'Lake St Parking Garage'
		WHEN address_streetAddress = '300 W DRAKE RD' THEN 'Vet Teaching Hospital'
		WHEN address_streetAddress = '551 W PITKIN ST' THEN 'Visual Arts Building'
		WHEN address_streetAddress = '951 MERIDIAN AVE' THEN 'Student Rec Center'
		WHEN address_streetAddress = '1231 CENTER AVENUE Mall' THEN 'Eddy Hall'
		WHEN address_streetAddress = '751 W Pitkin St' THEN 'Canvas Stadium'
		WHEN address_streetAddress = '701 W Pitkin St' THEN 'Alumni Center'
		WHEN address_streetAddress = '801 Oval Dr' THEN 'TILT Building'
		WHEN address_streetAddress = '841 Oval Sb Dr' THEN 'Weber Building'
		WHEN address_streetAddress = '1400 Remington St' THEN 'UCA'
		WHEN address_streetAddress = '1150 S Mason St' THEN 'Jack Track'
		WHEN address_streetAddress = '1385 Center Avenue Mall' THEN 'MRB'
		WHEN address_streetAddress = '201 W Lake St' THEN 'Surplus Property'
		WHEN address_streetAddress = '450 W Pitkin St' THEN 'Education Building'
		WHEN address_streetAddress = '950 W Plum St' THEN 'Durrell Center'
		WHEN address_streetAddress = '1231 Libbie Coy Way' THEN 'NESB'
		ELSE address_streetAddress
		END AS 'location'
	,IncidentEvent.callNumber AS 'incident'
	,FORMAT(startDate, 'MM/dd/yyyy') as 'from_date'
	,FORMAT(startDate, 'HH:mm') as 'from_time'
	,FORMAT(endDate, 'MM/dd/yyyy') AS 'to_date'
	,FORMAT(endDate, 'HH:mm') AS 'to_time'
	,CASE
		WHEN endDate IS NOT NULL THEN DATEADD(SECOND, DATEDIFF(SECOND,startDate, endDate)/2, startDate)
		ELSE startDate
	END AS 'split_date'
	,FORMAT(DATEDIFF(s, startDate, endDate)/3600.0, '0.00') AS 'hours'
	,CASE
		WHEN IncidentNarrative.text LIKE '%Cable and U%' THEN 'Both'
		WHEN IncidentNarrative.text LIKE '%Cable & U%' THEN 'Both'
		WHEN IncidentNarrative.text LIKE '%U-Lock%' THEN 'U-Lock'
		WHEN IncidentNarrative.text LIKE '%ULock%' THEN 'U-Lock'
		WHEN IncidentNarrative.text LIKE '%U Lock%' THEN 'U-Lock'
		WHEN IncidentNarrative.text LIKE '%Cable%' THEN 'Cable'
		WHEN IncidentNarrative.text LIKE '%Chain%' THEN 'Cable'
		WHEN IncidentNarrative.text LIKE '%Unlocked%' THEN 'Unlocked'
		WHEN IncidentNarrative.text LIKE '%Not Locked%' THEN 'Unlocked'
		ELSE 'Unknown'
		END AS 'lock_type'
	,IncidentProperty.make_Description AS 'brand'
	,CASE 
        WHEN CHARINDEX(',', Color) > 0 THEN 
            LEFT(Color, CHARINDEX(',', Color) - 1)
        WHEN CHARINDEX('/', Color) > 0 THEN 
            CASE 
                WHEN CHARINDEX(' ', Color) > 0 THEN 
                    LEFT(Color, CHARINDEX(' ', Color) - 1)
                ELSE 
                    SUBSTRING(Color, CHARINDEX('/', Color) + 1, LEN(Color))
            END
        WHEN CHARINDEX(' ', Color) > 0 THEN 
            LEFT(Color, CHARINDEX(' ', Color) - 1)
        ELSE 
            Color    
    END AS Color
	,'$' + convert(varchar(50), CAST(IncidentProperty.value as money), -1) AS 'Value'
	,'False' AS 'recovered'
FROM
	InformRMSReports.Reporting.CSUPOLICEDEPARTMENT_Incident Incident
	INNER JOIN InformRMSReports.Reporting.CSUPOLICEDEPARTMENT_IncidentEvent IncidentEvent
		ON Incident.Id = IncidentEvent.Incident_Id
	INNER JOIN InformRMSReports.Reporting.CSUPOLICEDEPARTMENT_IncidentNarrative IncidentNarrative
		ON Incident.Id = IncidentNarrative.Incident_Id
	INNER JOIN InformRMSReports.Reporting.CSUPOLICEDEPARTMENT_IncidentProperty IncidentProperty
		ON Incident.Id = IncidentProperty.Incident_Id

WHERE
	dateReported >= DATEADD(DD, -30, GETDATE())
	AND
	IncidentProperty.status_Code = '7'
	AND
	IncidentProperty.class_Description LIKE 'BIC%'

ORDER BY
	CaseNumber;