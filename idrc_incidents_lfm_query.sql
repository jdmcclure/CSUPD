DECLARE @Today DATE = GETDATE();
WITH idrc_incidents AS (
SELECT
    RMI.Master_Incident_Number AS 'Incident'
    ,Response_Date AS 'Response Date'
    ,Case
        WHEN Problem LIKE '%EXTRA PATRO%' THEN 'Extra Patrol'
        WHEN Problem LIKE '%Directed Patro%' THEN 'Directed Patrol'
        ELSE Problem
    END AS 'Problem'
    ,RVeh.Radio_Name AS 'Officer'
    ,RMI.Address
    ,RMI.Location_Name
    ,DATEDIFF(s, RVeh.Time_Assigned, RVeh.Time_Call_Cleared)/60.0 AS 'mins_on_call'
    ,ROW_NUMBER() OVER (partition by Master_Incident_Number ORDER BY Master_Incident_Number) AS incident_count
FROM
    Response_Master_Incident RMI 
		INNER JOIN Response_Vehicles_Assigned RVeh	
			ON	RMI.ID = RVeh.Master_Incident_ID
WHERE
    RMI.Address LIKE '3185 Rampart%'
    AND 
    NOT(RMI.location_name LIKE 'CDC')
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
    [Response Date] ASC