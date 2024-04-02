SELECT
    CASE
        WHEN A.AgencyName LIKE 'CSU%' THEN 'CSUPD'
        WHEN A.AgencyName LIKE 'FORT%' THEN 'FCPS'
        WHEN A.AgencyName LIKE 'LARIMER%' THEN 'LCSO'
    END AS Agency,
    A.CaseNumber AS [Case Number],
    FORMAT(AE.startDate, 'MM/dd/yyyy HH:mm') AS [Date],
    CONCAT(AP.lastName, ', ', AP.firstName) AS Name,
	CONCAT(AE.address_streetAddress, ' ', AE.address_apartment) AS Address,
    AC.ViolationCodeReference_Description AS Charge
FROM   
    InformRMSSummaries.Reporting.Arrest AS A
INNER JOIN InformRMSSummaries.Reporting.ArrestCharge AS AC
    ON A.Id = AC.Arrest_Id 
INNER JOIN InformRMSSummaries.Reporting.ArrestPerson AS AP
    ON A.Id = AP.Arrest_Id
INNER JOIN InformRMSSummaries.Reporting.ArrestEvent AS AE
    ON A.Id = AE.Arrest_Id
WHERE 
    AE.startDate >= DATEADD(DAY, -7, GETDATE())
    AND (AC.ViolationCodeReference_Description LIKE 'FC-17-129%' OR AC.ViolationCodeReference_Description LIKE 'FC-17-131%')
    AND (A.AgencyName LIKE 'CSU%' OR A.AgencyName LIKE 'FORT%' OR A.AgencyName LIKE 'LARIMER%');
