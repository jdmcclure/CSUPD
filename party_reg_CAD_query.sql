WITH complaints AS(
SELECT
	Master_Incident_Number AS 'incident'
	,Response_Date AS 'date'
	,Problem AS 'problem'
	,Address AS 'address'
	,CASE
		WHEN (MI.Apartment IS NULL OR MI.Apartment = '') AND LEN(MI.Location_Name) <= 9
			THEN MI.Location_Name
		WHEN MI.Location_Name IS NULL OR MI.Location_Name = ''
			THEN ''
		ELSE MI.Apartment
	END AS 'unit'
	,CASE 
		WHEN CHARINDEX('(', Call_Disposition) > 0 
		THEN SUBSTRING(Call_Disposition, 1, CHARINDEX('(', Call_Disposition) - 1) 
		ELSE Call_Disposition 
	 END AS 'Disposition'
FROM
	Reporting_System.dbo.Response_Master_Incident MI
WHERE
	Problem IN ('NOISE COMPLAINT', 'PARTY COMPLAINT')
	AND
	NOT(Master_Incident_Number LIKE 'EP%'
		OR
		Master_Incident_Number LIKE 'LP%'
		OR
		Master_Incident_Number LIKE 'TI%')
)
SELECT
	incident AS 'Incident'
	,FORMAT(date, 'MM/dd/yyyy HH:mm') AS 'Date'
	,CASE
		WHEN PROBLEM = 'PARTY COMPLAINT' THEN 'Party Complaint'
		WHEN problem = 'NOISE COMPLAINT' THEN 'Noise Complaint'
		ELSE problem 
	END AS 'Call_Type'
	,address + ' ' + unit AS 'Address'
	,disposition AS 'Disposition'
FROM
	complaints
WHERE
	date >= DATEADD(DD, -7, GETDATE());