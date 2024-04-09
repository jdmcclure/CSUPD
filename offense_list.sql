/*
This query provides a list of all offenses used in the system. 
I use this to ensure the clery_offense_list is up to date with violation code.

I would recommend exporting to Excel to search for keywords in the description.
*/
SELECT
    ViolationCodeReference_Code AS 'code'
    ,ViolationCodeReference_Description AS 'description'
FROM
    InformRMSSummaries.Reporting.IncidentOffense
GROUP BY
    ViolationCodeReference_Code, ViolationCodeReference_Description;