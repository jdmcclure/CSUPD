DECLARE @ThreeYearsAgo DATE = DATEADD(YEAR, -3, GETDATE())

;WITH citations AS(
SELECT
	CASE
		WHEN Citation.Number LIKE 'CS20-%' THEN LTRIM(REPLACE(Citation.Number, 'CS20-00', ''))
		WHEN startDate <= '20201231' THEN LTRIM(REPLACE(Citation.Number, 'CSUP_', ''))
		ELSE Citation.Number
	END AS 'citation_number'
	,CitationEvent.startDate AS 'date'
	,CitationEvent.address_streetAddress AS 'location'
	,CitationEvent.address_latitude AS 'latitude'
	,CitationEvent.address_longitude AS 'longitude'

FROM
	InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_Citation Citation
	INNER JOIN InformRMSSummaries.Reporting.CSUPOLICEDEPARTMENT_CitationEvent CitationEvent
		ON Citation.Id = CitationEvent.Citation_Id
WHERE
	startDate > DATEADD(millisecond, -3, '01/01/2017')
	AND
	Citation.Number NOT IN('2711', '999999', 'CS-CIT-0000000001')
)
SELECT
	CASE
		WHEN citation_number IN ('27454', 
					 '27456', 
					 '27576', 
					 '27577', 
					 '27579', 
					 '27580', 
					 '27581', 
					 '27578',
					 '25440',
					 '25546',
					 '25547',
					 '25630',
					 '25631',
					 '26113',
					 '26116',
					 '26156',
					 '26307') AND date < '12/31/2020' THEN citation_number + '-1'
		ELSE citation_number
	END AS 'citation_number',
	CASE
		WHEN citation_number LIKE '5S%' OR citation_number IN ('5286155') THEN 'Court'
		WHEN citation_number LIKE '2%' 
			OR citation_number LIKE '1%' 
			OR citation_number LIKE 'T%' 
			OR citation_number LIKE 'B%' THEN 'TEEP'
		WHEN citation_number LIKE 'S%'	THEN 'SA'
		ELSE 'Error'
	END AS 'type',
	date,
	location,
	latitude,
	longitude

FROM
	citations
WHERE
	citation_number = '25440' AND
	citation_number NOT LIKE '5S%';
