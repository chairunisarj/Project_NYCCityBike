-- Check the data

SELECT *
FROM NYCCityBike..NYCBikeShare



--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------LOOKING FOR DUPLICATE ROWS THEN DELETE IT-------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

WITH CTE (
[F1], [Trip Duration], [Start Time], [Stop Time], [Start Station ID], [End Station ID], [Bike ID], duplicatecount)
AS
	(SELECT [F1], [Trip Duration], [Start Time], [Stop Time], [Start Station ID], [End Station ID], [Bike ID],
		ROW_NUMBER() OVER(PARTITION BY [Start Time], [Stop Time], [Start Station ID], [End Station ID], [Bike ID]
		ORDER BY [F1]) AS DuplicateCount
		FROM NYCCityBike..NYCBikeShare)
--SELECT *
--FROM CTE
DELETE FROM CTE
WHERE DuplicateCount > 1


------------------------------------------------------------------------------------------------------------------------------
----------------------------------------ADD SEVERAL COLUMN FOR ANALYSIS-------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


-- ADD "NameofDay" and "NameofMonth" Column from "Start Time"
-------------------------------------------------------------

SELECT [Start Time], DATENAME(DW,[Start Time]) as NameOfDay, DATENAME(M,[Start Time]) as Month
FROM NYCCityBike..NYCBikeShare

ALTER TABLE NYCCityBike..NYCBikeShare
ADD NameofDay nvarchar(255),
NameofMonth nvarchar(255);

Update NYCCityBike..NYCBikeShare
SET NameofDay = DATENAME(DW,[Start Time]),
NameofMonth = DATENAME(M,[Start Time])

Select [Start Time], NameofDay, NameofMonth 
FROM NYCCityBike..NYCBikeShare



--- Add a new column where '0, 1, 2' in "Gender" column change to 'Unknown, Male and Female' 
--------------------------------------------------------------------------------------------

ALTER TABLE NYCCityBike..NYCBikeShare
ADD GenderConverted nvarchar(255);

Update NYCCityBike..NYCBikeShare
SET GenderConverted = CONVERT(nvarchar(255),Gender)

Update NYCCityBike..NYCBikeShare
SET GenderConverted = CASE When Gender = '1' THEN 'Male'
	   When Gender = '2' THEN 'Female'
	   ELSE 'Unknown'
	   END

SELECT * 
FROM NYCCityBike..NYCBikeShare



--- CREATE AGE COLUMN
---------------------

SELECT [Start Time], (DATENAME(YEAR,[Start Time]) - [Birth Year]) Age
FROM NYCCityBike..NYCBikeShare

ALTER TABLE NYCCityBike..NYCBikeShare
ADD Age Float;

Update NYCCityBike..NYCBikeShare
SET Age = (DATENAME(YEAR,[Start Time]) - [Birth Year])

Select [Start Time], [Birth Year], Age
FROM NYCCityBike..NYCBikeShare



--- CREATE AGE GROUP COLUMN
---------------------------

ALTER TABLE NYCCityBike..NYCBikeShare
ADD AgeGroup nvarchar(255);

Update NYCCityBike..NYCBikeShare
SET AgeGroup = CASE WHEN Age < 18 THEN ' < 18 '
	WHEN Age < 25 THEN '18 - 24'
	WHEN Age < 35 THEN '25 - 34'
	WHEN Age < 45 THEN '35 - 44'
	WHEN Age < 55 THEN '45 - 54'
	WHEN Age < 65 THEN '55 - 64'
	WHEN Age < 75 THEN '65 - 74'
ELSE ' >= 75'
END

Select Age, AgeGroup 
FROM NYCCityBike..NYCBikeShare


------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------DELETE UNUSED COLUMNS---------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM NYCCityBike..NYCBikeShare
ORDER BY Age

ALTER TABLE NYCCityBike..NYCBikeShare
DROP COLUMN [Start Station Latitude], [Start Station Longitude], [End Station Latitude], [End Station Longitude]


------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------DIVE DEEPER INTO THE DATA--------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------


--- CALCULATE THE MIN AND MAX OF "Age" and "Trip_Duration_in_min"
--- *to find whether there's an outlier
-----------------------------------------------------------------

SELECT MIN(Age) Min_Age,
		MAX(Age) Max_Age,
		MIN(Trip_Duration_in_min) ShortestDuration,
		MAX(Trip_Duration_in_min) LongestDuration
FROM NYCCityBike..NYCBikeShare



--- DELETE ROWS WITH AGE > 100
------------------------------

DELETE FROM NYCCityBike..NYCBikeShare
WHERE Age > 100



--- EXPORT THE TABLE FOR VISUALIZATIONS
---------------------------------------
