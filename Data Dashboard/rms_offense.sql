DECLARE @ThreeYearsAgo DATE = DATEADD(YEAR, -3, GETDATE());
WITH offenses AS(
SELECT
	I.CaseNumber AS 'case_number'
	,ViolationCodeReference_Code AS 'crs_code'
	,LTRIM(SUBSTRING(IncidentOffense.ViolationCodeReference_Description, CHARINDEX(' ', IncidentOffense.ViolationCodeReference_Description) + 1, LEN(IncidentOffense.ViolationCodeReference_Description))) AS 'description'
	,CASE
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%THEFT%' THEN 'Theft'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%SUSPICIOUS%' THEN 'Suspicious'
		WHEN IncidentOffense.ViolationCodeReference_Description = ' AOA FORT COLLINS POLICE' THEN 'Assist Other Law Enforcement Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description = ' AOA COLORADO STATE PATROL' THEN 'Assist Other Law Enforcement Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description = ' AOA LOVELAND POLICE' THEN 'Assist Other Law Enforcement Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description = ' AOA LARIMER COUNTY SHERIFF' THEN 'Assist Other Law Enforcement Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CIRT ASSIST%' THEN 'Assist Other Law Enforcement Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description = ' AOA OTHER LAW AGENCY' THEN 'Assist Other Law Enforcement Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%MEDICAL AGENCY%' THEN 'Assist Medical Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%AMBULANCE%' THEN 'Assist Medical Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%POUDRE FIRE%' THEN 'Assist to Fire Agency'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%WELFARE%' THEN 'Welfare Check'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CONTRABAND%' THEN 'Drugs'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FENTANYL%' THEN 'Drugs'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%MARIJUANA%' THEN 'Drugs'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DRUG%' THEN 'Drugs'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CONTROLLED SUBSTANCE%' THEN 'Drugs'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%METH%' THEN 'Drugs'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%BARBITURATE%' THEN 'Drugs'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%METHAMPHETAMINE%' THEN 'Theft'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%WARRANT%' THEN 'Warrant Arrest'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CRIMINAL MISCHIEF%' THEN 'Criminal Mischief'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%INFORMATION ONLY%' THEN 'Information Report'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%THEFT%' THEN 'Theft'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%ERROR%' THEN 'Cancelled Case'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%TRESPASS%' THEN 'Criminal Trespass'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%MENTAL HEALTH%' THEN 'Mental Health Related'
		WHEN IncidentOffense.ViolationCodeReference_Description = ' LOST PROPERTY' THEN 'Lost Property'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%TAMPERING%' THEN 'Criminal Tampering'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%Extortion%' THEN 'Criminal Extortion'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%HARASSMENT%' THEN 'Harassment'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FRAUDULENT) (DRIVER''S%' THEN 'Fake ID'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%SEXUAL ASSAULT%' THEN 'Sexual Assault'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%UNLAWFUL SEXUAL CONTACT%' THEN 'Sexual Assault'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%ASSAULT%' THEN 'Assault'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%SUICIDE ATTEMPT%' THEN 'Suicide Attempt'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%Burglary%' THEN 'Burglary'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%VEHICULAR ELUDING%' THEN 'Vehicular Eluding'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DROVE VEHICLE WHILE UNDER THE INFLUENCE%' THEN 'DUI'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DUI%' THEN 'DUI'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DROVE%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%EXPIRED NUMBER%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CARELESS DRIVING%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FAILED TO GIVE INFORMATION%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%LEFT SCENE%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%UNREGISTERED VEHICLE%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FAILED TO DISPLAY LAMPS%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%RECKLESS DRIVING%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FAILED TO YIELD RIGHT-OF-WAY%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%UNSAFE BACKING%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%SPEED%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%STOP SIGN%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%UNINSURED%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DRIVE%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%ACCIDENT%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%UNSAFE BACKING%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%EXPIRED%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '42-%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DRIVING%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%WITHOUT REQUIRED REGISTRATION%' THEN 'Traffic Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%ALCOHOL%' THEN 'Alcohol Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DETOX%' THEN 'Alcohol Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%OPEN CONTAINER%' THEN 'Alcohol Related'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%OBSTRUCTING%' THEN 'Obstruction'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%OBSTRUCTION%' THEN 'Obstruction'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%INTERFERE WITH STAFF%' THEN 'Obstruction'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%INTERFERENCE W/PUBLIC%' THEN 'Obstruction'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DISORDERLY%' THEN 'Disorderly Conduct'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CITIZEN ASSIST%' THEN 'Citizen Assist'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DOMESTIC VIOLENCE%' THEN 'Domestic Violence'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%MENACING%' THEN 'Criminal Menacing'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%IMPERSONATION%' THEN 'Criminal Impersonation'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FALSE REPORTING%' THEN 'False Reporting'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FALSE CRIME REPORT%' THEN 'False Reporting'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%WEAPON%' THEN 'Weapon Offense'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%BODILY WASTE%' THEN 'Depositing Bodily Waste'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%Camping%' THEN 'Camping on Private Property'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%SEX OFFENDER%' THEN 'Sex Offender Offense'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%PARKING%' THEN 'Parking Offense'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%STALKING%' THEN 'Stalking'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FALSE IMPRISONMENT%' THEN 'False Imprisonment'
		WHEN IncidentOffense.ViolationCodeReference_Description = ' FOUND PROPERTY' THEN 'Found Property'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CIVIL STANDBY%' THEN 'Civil Standby'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%UNATTENDED DEATH%' THEN 'Unattended Death'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%ABANDONED VEHICLE%' THEN 'Abandoned Vehicle'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%ARSON%' THEN 'Arson'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FRAUD%' THEN 'Fraud'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%FINANCIAL TRANS%' THEN 'Fraud'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CHILD ABUSE%' THEN 'Child Abuse'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%VIOLATION OF A PROTECTION ORDER%' THEN 'Violation of a Protection Order'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%PUBLIC INDECENCY%' THEN 'Public Indecency'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%INDECENT EXPOSURE%' THEN 'Indecent Exposure'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%RESISTING ARREST%' THEN 'Resisting Arrest'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%CIVIL MATTER%' THEN 'Civil Matter'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DISTURBANCE%' THEN 'Disturbance'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%WINDOW PEEPING%' THEN 'Window Peeping'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%ONE OR MORE IDENTI%' THEN 'Criminal Possession of ID Documents'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%DISTURBING THE PEACE%' THEN 'Disturbance'
		WHEN IncidentOffense.ViolationCodeReference_Description LIKE '%LITTERING%' THEN 'Littering'
		ELSE 'Other'
	END AS 'summary_offense'
	,ViolationCodeReference_UcrCode AS 'ucr_code'
	,NcicCode AS 'ncic_code'
	,counts AS 'counts'
	,offenseLocation_Description AS 'location_type'
	,biasMotivation AS 'bias_motivation'
	,attemptedCompleted_Description 'att_comp'

FROM
	InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_Incident I
	INNER JOIN InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_IncidentEvent IE
		ON I.Id = IE.Incident_Id
	INNER JOIN InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_IncidentOffense IncidentOffense
		ON I.Id = IncidentOffense.Incident_Id
WHERE
	IE.startDate > @ThreeYearsAgo
	AND
	CaseNumber NOT IN('CS01-0000646')
)
SELECT
	case_number
	,crs_code
	,CASE
		WHEN description LIKE '%ONLY REPORT' THEN 'Informational Report'
		WHEN description = 'THEFT OF GOVERNMENT PROPERTY / $300 - $749- (M2) ' THEN 'Theft of Government Property $300-$749'
		ELSE description
	END AS 'description'
	,summary_offense
	,CASE 
        WHEN CHARINDEX('(', description) > 0 AND CHARINDEX(')', description) > 0
            AND LEN(SUBSTRING(
                        description, 
                        CHARINDEX('(', description) + 1, 
                        CHARINDEX(')', description) - CHARINDEX('(', description) - 1
                    )) <= 4
        THEN SUBSTRING(
                description, 
                CHARINDEX('(', description) + 1, 
                CHARINDEX(')', description) - CHARINDEX('(', description) - 1
            )
        ELSE NULL
    END AS 'level'
	,ucr_code
	,ncic_code
	,counts
	,bias_motivation
	,att_comp
FROM
	offenses