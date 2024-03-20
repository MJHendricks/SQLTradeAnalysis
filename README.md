# Cleaning and Analysis of Trading Data using SQL 

## Instructions
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
