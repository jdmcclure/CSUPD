DECLARE @Today DATE = GETDATE();
WITH idrc_incidents AS (
SELECT
    RMI.Master_Incident_Number AS 'Incident'
    ,Response_Date AS 'Response Date'
    ,Problem
    ,RVeh.Radio_Name AS 'Officer'
    ,ROW_NUMBER() OVER (partition by Master_Incident_Number ORDER BY Master_Incident_Number) AS incident_count
FROM
    Response_Master_Incident RMI 
		INNER JOIN Response_Vehicles_Assigned RVeh	
			ON	RMI.ID = RVeh.Master_Incident_ID
WHERE
    RMI.Address LIKE '3185 Rampart%'
    AND 
    NOT(RMI.location_name LIKE 'CDC%')
    AND
    MONTH(RMI.Response_Date) = MONTH(@Today)-1
)
SELECT
    *
FROM
    idrc_incidents
WHERE
    incident_count = 1
ORDER BY
    [Response Date]