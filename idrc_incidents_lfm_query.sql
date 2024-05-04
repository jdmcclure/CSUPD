DECLARE @Today DATE = GETDATE();
WITH idrc_incidents AS (
SELECT
    RMI.Master_Incident_Number AS 'Incident'
    ,Response_Date AS 'Response Date'
    ,Case
        WHEN Problem LIKE '%Extra Patro%' THEN 'Extra Patrol'
        WHEN Problem LIKE '%Directed Patro%' THEN 'Directed Patrol'
        ELSE UPPER(LEFT(Problem,1)) + LOWER(RIGHT(Problem, LEN(Problem)-1))
    END AS 'Problem'
    ,RMI.Call_Disposition AS 'Disposition'
    ,RVeh.Radio_Name AS 'Unit'
    ,RMI.Address
    ,RMI.Location_Name
    ,DATEDIFF(s, RVeh.Time_Assigned, RVeh.Time_Call_Cleared)/60.0 AS 'mins_on_call'
    ,ROW_NUMBER() OVER (partition by Master_Incident_Number ORDER BY Master_Incident_Number) AS incident_count
FROM
    Response_Master_Incident RMI 
		INNER JOIN Response_Vehicles_Assigned RVeh	
			ON	RMI.ID = RVeh.Master_Incident_ID
WHERE
    RMI.Location_Name = 'IDRC'
    AND
    MONTH(RMI.Response_Date) = MONTH(@Today)-1
)
SELECT
    Incident
    ,FORMAT([Response Date], 'MM/dd/yyyy HH:mm') AS "Response Date"
    ,Problem
    ,CASE
        WHEN Disposition IS NULL THEN 'Completed (CMP)'
        ELSE Disposition
    END AS 'Disposition'
    ,Unit
    ,[Address]
    ,Location_Name AS 'Location Name'
    ,mins_on_call AS 'Mins on Call'

FROM
    idrc_incidents
WHERE
    incident_count = 1
ORDER BY
    [Response Date] ASC;