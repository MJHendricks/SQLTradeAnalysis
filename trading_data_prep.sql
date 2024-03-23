-- ADD file_date column to all tables
ALTER TABLE [MOCK_DATA$]
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-2$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-3$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-4$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-5$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-6$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-7$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-8$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-9$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-10$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-11$']
ADD file_date DATE;
ALTER TABLE [dbo].['MOCK_DATA-12$']
ADD file_date DATE;

-- update tables with month data
UPDATE [MOCK_DATA$]
SET file_date = '2023/01/01';
UPDATE ['MOCK_DATA-2$']
SET file_date = '2023/02/01';
UPDATE ['MOCK_DATA-3$']
SET file_date = '2023/03/01';
UPDATE ['MOCK_DATA-4$']
SET file_date = '2023/04/01';
UPDATE ['MOCK_DATA-5$']
SET file_date = '2023/05/01';
UPDATE ['MOCK_DATA-6$']
SET file_date = '2023/06/01';
UPDATE ['MOCK_DATA-7$']
SET file_date = '2023/07/01';
UPDATE ['MOCK_DATA-8$']
SET file_date = '2023/08/01';
UPDATE ['MOCK_DATA-9$']
SET file_date = '2023/09/01';
UPDATE ['MOCK_DATA-10$']
SET file_date = '2023/10/01';
UPDATE ['MOCK_DATA-11$']
SET file_date = '2023/11/01';
UPDATE ['MOCK_DATA-12$']
SET file_date = '2023/12/01';



-- create Market Capitalisation column
ALTER TABLE [MOCK_DATA$]
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-2$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-3$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-4$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-5$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-6$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-7$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-8$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-9$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-10$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-11$']
ADD Market_Capitalisation BIGINT;
ALTER TABLE [dbo].['MOCK_DATA-12$']
ADD Market_Capitalisation BIGINT;

-- Remove rows where Market Cap is NULL 
DELETE FROM [MOCK_DATA$] 
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-2$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-3$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-4$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-5$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-6$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-7$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-8$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-9$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-10$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-11$']
WHERE [Market Cap] = 'n/a';
DELETE FROM ['MOCK_DATA-12$']
WHERE [Market Cap] = 'n/a';


-- Just realized i set Market_Capitalisation as an BIGINT, so while working with the data, i'll use a VARCHAR Data Type for a temp column
ALTER TABLE [MOCK_DATA$]
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-2$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-3$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-4$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-5$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-6$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-7$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-8$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-9$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-10$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-11$']
ADD Market_Capitalisation_TEMP VARCHAR(255);
ALTER TABLE [dbo].['MOCK_DATA-12$']
ADD Market_Capitalisation_TEMP VARCHAR(255);

-- Change B's and M's to the correct amount of zeroes, remove dollar signs.
UPDATE ['MOCK_DATA-12$']
SET Market_Capitalisation_TEMP = REPLACE([Market Cap], '$', '');

UPDATE ['MOCK_DATA-12$']
SET Market_Capitalisation_TEMP =
   CASE
        WHEN LEN(Market_Capitalisation_TEMP) - CHARINDEX('.', Market_Capitalisation_TEMP) = 2 -- ONE DECIMAL PLACE
		THEN 
			CASE
				WHEN RIGHT(Market_Capitalisation_TEMP, 1) = 'M' 
				THEN REPLACE(Market_Capitalisation_TEMP, 'M', '00000')

				WHEN RIGHT(Market_Capitalisation_TEMP, 1) = 'B' 
				THEN REPLACE(Market_Capitalisation_TEMP, 'B', '00000000')
            END

		WHEN LEN(Market_Capitalisation_TEMP) - CHARINDEX('.', Market_Capitalisation_TEMP) = 3 -- TWO DECIMAL PLACES
		THEN 
			CASE
				WHEN RIGHT(Market_Capitalisation_TEMP, 1) = 'M' 
				THEN REPLACE(Market_Capitalisation_TEMP, 'M', '0000')

				WHEN RIGHT(Market_Capitalisation_TEMP, 1) = 'B' 
				THEN REPLACE(Market_Capitalisation_TEMP, 'B', '0000000')
            END

		WHEN CHARINDEX('.', Market_Capitalisation_TEMP) < 0 -- NO DECIMAL PLACES
		THEN 
			CASE
				WHEN RIGHT(Market_Capitalisation_TEMP, 1) = 'M' 
				THEN REPLACE(Market_Capitalisation_TEMP, 'M', '000000')

				WHEN RIGHT(Market_Capitalisation_TEMP, 1) = 'B' 
				THEN REPLACE(Market_Capitalisation_TEMP, 'B', '000000000')
            END
	END;

UPDATE ['MOCK_DATA-12$']
SET Market_Capitalisation_TEMP =
	REPLACE(Market_Capitalisation_TEMP, '.', '')

-- convert from string in Market_Capitalisation_TEMP to int in Market_Capitalisation
UPDATE [MOCK_DATA$]
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-2$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-3$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-4$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-5$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-6$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-7$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-8$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-9$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-10$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-11$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);
UPDATE ['MOCK_DATA-12$']
SET Market_Capitalisation = TRY_CAST(Market_Capitalisation_TEMP AS BIGINT);

-- Drop temp column and market cap column
ALTER TABLE [MOCK_DATA$]
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-2$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-3$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-4$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-5$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-6$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-7$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-8$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-9$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-10$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-11$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];
ALTER TABLE [dbo].['MOCK_DATA-12$']
DROP COLUMN Market_Capitalisation_TEMP, [Market Cap];

SELECT float_column = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
FROM [dbo].[MOCK_DATA$]

 -- add column for purchase price group
ALTER TABLE [MOCK_DATA$]
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-2$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-3$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-4$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-5$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-6$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-7$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-8$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-9$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-10$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-11$']
ADD Purchase_Price_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-12$']
ADD Purchase_Price_Group VARCHAR(24);

 -- add a pruchase price float column to work with the data
ALTER TABLE [MOCK_DATA$]
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-2$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-3$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-4$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-5$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-6$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-7$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-8$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-9$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-10$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-11$']
ADD Purchase_Price_Float FLOAT;
ALTER TABLE [dbo].['MOCK_DATA-12$']
ADD Purchase_Price_Float FLOAT;

UPDATE [dbo].[MOCK_DATA$]
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-2$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-3$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-4$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-5$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-6$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-7$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-8$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-9$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-10$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-11$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)
UPDATE [dbo].['MOCK_DATA-12$']
SET Purchase_Price_Float = CAST(REPLACE([Purchase Price], '$', '') AS FLOAT)

-- Update groupings based on value of Purchase_Price_Float FOR ALL TABLES
UPDATE [dbo].['MOCK_DATA-12$']
SET Purchase_Price_Group = 
	CASE
		WHEN Purchase_Price_Float < 24999.99
		THEN 'Low'
		
		WHEN Purchase_Price_Float < 49999.99
		THEN 'Medium'
		
		WHEN Purchase_Price_Float < 74999.99
		THEN 'High'

		WHEN Purchase_Price_Float < 100000
		THEN 'Very High'
	END;

-- drop temp column Purchase_Price_Float
ALTER TABLE [dbo].[MOCK_DATA$]
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-2$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-3$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-4$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-5$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-6$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-7$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-8$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-9$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-10$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-11$']
DROP COLUMN Purchase_Price_Float;
ALTER TABLE [dbo].['MOCK_DATA-12$']
DROP COLUMN Purchase_Price_Float;

-- Categorise the Market Cap into groupings
ALTER TABLE [MOCK_DATA$]
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-2$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-3$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-4$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-5$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-6$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-7$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-8$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-9$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-10$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-11$']
ADD Market_Cap_Group VARCHAR(24);
ALTER TABLE [dbo].['MOCK_DATA-12$']
ADD Market_Cap_Group VARCHAR(24);

-- Update groupings based on value of Market_Capitalisation FOR ALL TABLES
UPDATE [dbo].['MOCK_DATA-12$']
SET Market_Cap_Group = 
	CASE
		WHEN Market_Capitalisation < 100000000
		THEN 'Small'
		
		WHEN Market_Capitalisation < 1000000000
		THEN 'Medium'
		
		WHEN Market_Capitalisation < 100000000000
		THEN 'Large'

		WHEN Market_Capitalisation >= 100000000000
		THEN 'Huge'
	END;

-- find 5 highest purchase price in each table for each value of market_cap_group and purchase_price_group
-- Table 1
WITH Table1RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table1RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table1RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table1RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table1RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table1RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table1RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table1RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table1RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table1RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table1RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table1RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table1RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table1RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table1RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table1RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].[MOCK_DATA$]
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- TABLE 2
Table2RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table2RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table2RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table2RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table2RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table2RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table2RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table2RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table2RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table2RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table2RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table2RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table2RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table2RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table2RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table2RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-2$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- TABLE 3
Table3RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table3RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table3RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table3RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table3RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table3RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table3RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table3RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table3RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table3RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table3RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table3RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table3RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table3RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table3RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table3RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-3$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- Table 4
Table4RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table4RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table4RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table4RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table4RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table4RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table4RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table4RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table4RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table4RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table4RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table4RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table4RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table4RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table4RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table4RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-4$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- Table 5
Table5RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table5RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table5RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table5RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table5RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table5RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table5RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table5RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table5RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table5RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table5RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table5RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table5RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table5RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table5RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table5RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-5$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),

-- table 6
Table6RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table6RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table6RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table6RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table6RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table6RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table6RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table6RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table6RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table6RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table6RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table6RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table6RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table6RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table6RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table6RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-6$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- Table 7
Table7RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table7RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table7RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table7RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table7RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table7RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table7RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table7RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table7RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table7RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table7RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table7RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table7RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table7RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table7RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table7RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-7$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- Table 8
Table8RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table8RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table8RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table8RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table8RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table8RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table8RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table8RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table8RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table8RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table8RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table8RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table8RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table8RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table8RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table8RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-8$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- Table 9
Table9RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table9RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table9RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table9RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table9RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table9RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table9RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table9RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table9RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table9RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table9RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table9RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table9RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table9RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table9RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table9RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-9$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- Table 10
Table10RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table10RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table10RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table10RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table10RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table10RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table10RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table10RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table10RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table10RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table10RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table10RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table10RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table10RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table10RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table10RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-10$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
--Table 11
Table11RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table11RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table11RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table11RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table11RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table11RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table11RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table11RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table11RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table11RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table11RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table11RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table11RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table11RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table11RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table11RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-11$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
),
-- Table 12
Table12RankedData1 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Huge'
),
Table12RankedData2 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Huge'
),
Table12RankedData3 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Huge'
),
Table12RankedData4 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Huge'
),
Table12RankedData5 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Large'
),
Table12RankedData6 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Large'
),
Table12RankedData7 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Large'
),
Table12RankedData8 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Large'
),
Table12RankedData9 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Medium'
),
Table12RankedData10 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Medium'
),
Table12RankedData11 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Medium'
),
Table12RankedData12 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Medium'
),
Table12RankedData13 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Very High' AND Market_Cap_Group = 'Small'
),
Table12RankedData14 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'High' AND Market_Cap_Group = 'Small'
),
Table12RankedData15 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Medium' AND Market_Cap_Group = 'Small'
),
Table12RankedData16 AS (
    SELECT *,
           ROW_NUMBER() OVER (ORDER BY [Purchase Price] DESC) AS Rank
    FROM [dbo].['MOCK_DATA-12$']
	WHERE Purchase_Price_Group = 'Low' AND Market_Cap_Group = 'Small'
)

SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table1RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table2RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table3RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table4RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table5RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table6RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table7RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table8RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table9RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table10RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table11RankedData16
WHERE Rank <= 5

UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData1
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData2
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData3
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData4
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData5
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData6
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData7
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData8
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData9
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData10
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData11
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData12
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData13
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData14
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData15
WHERE Rank <= 5
UNION ALL
SELECT Market_Cap_Group, Purchase_Price_Group, file_date, Ticker, Sector, Market, [Stock Name], Market_Capitalisation, [Purchase Price], Rank
FROM Table12RankedData16
WHERE Rank <= 5