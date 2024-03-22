# Cleaning and Analysis of Trading Data using SQL 
This project was initally designed for the [Week 8 2023 Data Preparation Challenge](https://www.preppindata.com/challenges) to be completed in Tableau. However, it has been entirely implemented using SQL.
## Dataset
There are 12 files in total, one for each month of the year, containing information on the stock purchased, the price it was purchased at and the person who authorized the purchase.

The column headings are identical across all files; id (Primary Key), first_name, last_name, Ticker, Sector, Market, Stock Name, Market Cap, Purchase Price.

## Objective
The challenge is to find the top 5 trades for each categorization of the purchase price and market capitalisation, and output the results in a single file.

## Tools
- SQL Server Management Studio

## Instructions
The following instructions were given in order to complete the challenge:
- Create a 'file date' using the month found in the file name
  - The Null value should be replaced as 1
- Clean the Market Cap value to ensure it is the true value as 'Market Capitalisation'
	- Remove any rows with 'n/a'
- Categorise the Purchase Price into groupings
  - 0 to 24,999.99 as 'Low'
  - 25,000 to 49,999.99 as 'Medium'
  - 50,000 to 74,999.99 as 'High'
  - 75,000 to 100,000 as 'Very High'
- Categorise the Market Cap into groupings
  - Below $100M as 'Small'
  - Between $100M and below $1B as 'Medium'
  - Between $1B and below $100B as 'Large' 
  - $100B and above as 'Huge'
- Rank the highest 5 purchases per combination of: file date, Purchase Price Categorisation and Market Capitalisation Categorisation.
- Output only records with a rank of 1 to 5

## Output
As specified in the requirements of the challenge, the final result should be a single file with the following columns: 
- Market Capitalisation Categorisation
- Purchase Price Categorisation
- File Date
- Ticker
- Sector
- Market
- Stock Name
- Market Capitalisation
- Purchase Price
- Rank

The result has been exported as a csv file, results.csv.

## Acknowledgements
Special thanks to [preppindata.com](https://www.preppindata.com) for providng an endless supply of datasets and challenges.
