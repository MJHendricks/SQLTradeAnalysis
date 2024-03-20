SELECT * FROM [dbo].[MOCK_DATA$];

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