SELECT
    CASE
        WHEN Arrest.AgencyName LIKE 'CSU%' THEN 'CSUPD'
        WHEN Arrest.AgencyName LIKE 'ESTES%' THEN 'EPD'
        WHEN Arrest.AgencyName LIKE 'Drug%' THEN 'DTF'
        WHEN Arrest.AgencyName LIKE 'FORT%' THEN 'FCPS'
        WHEN Arrest.AgencyName LIKE 'LOVELAND%' THEN 'LPD'
        WHEN Arrest.AgencyName LIKE 'Larimer%' THEN 'LCSO'
        ELSE Arrest.AgencyName
    END AS 'Agency',
    Arrest.CaseNumber AS 'Case Number',
    Arrest.SequenceNotation AS 'Supp #',
    FORMAT(ArrestEvent.startDate, 'MM/dd/yyyy') AS 'Date',
    UPPER(ArrestPerson.lastName + ',' + ArrestPerson.firstName + ' ' + CASE WHEN ArrestPerson.middleName IS NULL THEN '' ELSE ArrestPerson.middleName END) AS 'Name',
    FORMAT(ArrestPerson.dateOfBirth, 'MM/dd/yyyy') AS 'DOB',
    ArrestCharge.ViolationCodeReference_Code AS 'Charge',
    ArrestCharge.ViolationCodeReference_Description AS 'Charge_Literal',
    ArrestCharge.FelonyMisdemeanor_Description AS 'Charge Level',
    ArrestEvent.address_streetAddress AS 'Arrest_Location',
    ArrestOfficer.officerName_Code AS 'Officer'
FROM
		InformRMSReports.Reporting.Arrest Arrest
	INNER JOIN	InformRMSReports.Reporting.ArrestEvent ArrestEvent 
		ON Arrest.Id = ArrestEvent.Arrest_Id
	INNER JOIN	InformRMSReports.Reporting.ArrestPerson ArrestPerson 
		ON Arrest.Id = ArrestPerson.Arrest_Id
	INNER JOIN	InformRMSReports.Reporting.ArrestCharge ArrestCharge 
		ON Arrest.Id = ArrestCharge.Arrest_Id
	INNER JOIN	InformRMSReports.Reporting.ArrestOfficer ArrestOfficer 
		ON Arrest.Id = ArrestOfficer.Arrest_Id
WHERE
    (Arrest.AgencyName LIKE 'CSU%'
    OR Arrest.AgencyName LIKE 'FORT%'
    OR Arrest.AgencyName LIKE 'Larimer%')
    AND ArrestOfficer.involvementDate BETWEEN DATEADD(DAY, DATEDIFF(day, 1, GETDATE()), '07:00:00')
    AND DATEADD(DAY, DATEDIFF(day, 0, GETDATE()), '07:00:00')
    AND ArrestPerson.InvolvementType_Code LIKE 'Arrestee'
    AND ArrestOfficer.involvementType_Code LIKE 'Report'
    AND NOT (
        ArrestCharge.ViolationCodeReference_Code LIKE '16-3-102%'
        OR ArrestCharge.ViolationCodeReference_Code LIKE 'Mittar%'
        -- (other conditions continue here)
    )
ORDER BY
    ArrestPerson.lastName;
