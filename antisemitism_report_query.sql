USE InformRMSSummaries

DECLARE @begin AS datetime
DECLARE @end AS datetime
set @begin = '01/01/2023'
set @end = '12/31/2023'

SELECT
	I.CaseNumber
	,E.startDate

FROM
	Reporting.CSUPOLICEDEPARTMENT_Incident I
	INNER JOIN Reporting.CSUPOLICEDEPARTMENT_IncidentEvent E
		ON I.Id = E.Incident_Id
	INNER JOIN Reporting.CSUPOLICEDEPARTMENT_IncidentNarrative N
		ON I.Id = N.Incident_Id
	LEFT JOIN Reporting.CSUPOLICEDEPARTMENT_IncidentOfficer O
		ON I.Id = O.Incident_Id

WHERE
	O.officerName_Code LIKE 'C%'
	AND
	E.startDate >= @begin AND E.startDate <= @end
	AND
	(
	text LIKE '%holocaust%'
	OR
	text LIKE '%hitler%'
	OR
	text LIKE '%jew%'  --Note, this pulls cases that mention jewelry
	OR
	text LIKE '%swastika%'
	OR
	text LIKE '%semit%'
	OR
	text LIKE '%nazi%'
	OR
	text LIKE '%kike%'
	OR
	text LIKE '%hillel%'
	OR
	text LIKE '%chabad%'
	)
GROUP BY
	I.CaseNumber, E.startDate;