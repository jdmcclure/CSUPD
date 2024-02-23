DECLARE @ThreeYearsAgo DATE = DATEADD(YEAR, -3, GETDATE())

SELECT
	Master_Incident_Number AS 'incident_number',
	V.Radio_Name AS 'officer_id',
	V.Time_Assigned AS 'assigned',
	V.Time_ArrivedAtScene AS 'arrived',
	V.Time_Call_Cleared AS 'cleared',
	V.Elapsed_Assigned_2_Enroute AS 'delay',
	DATEDIFF(s, V.Time_Assigned, V.Time_ArrivedAtScene) AS 'response_secs',
	DATEDIFF(s, V.Time_Assigned, V.Time_Call_Cleared) AS 'total_secs',
	V.Elapsed_Assigned_2_Clear AS 'time_on_call',
	PrimaryVehicleFlag AS 'primary_flag'
FROM
	Reporting_System.dbo.Response_Master_Incident M
	INNER JOIN Reporting_System.dbo.Response_Vehicles_Assigned V
		ON M.Id = V.master_incident_id
WHERE
	NOT(Master_Incident_Number IS NULL OR Master_Incident_Number = '')
	AND
	Master_Incident_Number IN (
		SELECT M.Master_Incident_Number AS 'incident_number'
		FROM Reporting_System.dbo.Response_Master_Incident M INNER JOIN Reporting_System.dbo.Response_Vehicles_Assigned V ON M.ID = V.Master_Incident_ID
		WHERE V.Radio_Name LIKE '5%' AND Response_Date > @ThreeYearsAgo)
	AND
	M.Response_Date > @ThreeYearsAgo;