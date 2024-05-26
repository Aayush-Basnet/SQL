/*
SQL Project : Data Cleaning

We have dataset of layoff from Kaggle. In this project, at first we try to clean data as this dataset contain messed up, duplicate, and unmanaged data. 


*/

-- Let's look into data


Select *
From PortfolioProject..layoffs


/*
What are we doing in this project?
1. check for duplicates and remove any
2. standardize data and fix errors
3. Look at null values and see what
4. remove any columns and rows that are not necessary
*/

---------------------------------------------------------------------------------------------------------------------------

-- Removing Duplicates

Select *,
ROW_NUMBER() over(Partition By company, industry, total_laid_off, percentage_laid_off,'date'
Order By company
) as row_num
From PortfolioProject..layoffs ;  -- Detecting where table has duplicate value or not. This showed that it contains duplicate rows.



With Duplicate_CTE As
(
Select *,
ROW_NUMBER() over(Partition By company, industry, total_laid_off, percentage_laid_off,'date'
Order By company
) as row_num
From PortfolioProject..layoffs
)
Select *
From Duplicate_CTE
Where row_num >1;  -- It showed that there are many duplicate rows in table.



--  let's just look at some data to confirm

Select * 
From PortfolioProject..layoffs
Where company = 'Oda';



Select * 
From PortfolioProject..layoffs
Where company = 'OYO';



-- while it looks like there are all legitimate entries and shouldn't be deleted. We need to really look at every single row to be accurate


Select *,
ROW_NUMBER() over(Partition By company, location,industry, total_laid_off, percentage_laid_off,'date',stage,country,funds_raised_millions
Order By company
) as row_num
From PortfolioProject..layoffs  -- Here is our real duplicates



With Duplicate_CTE As
(
Select *,
ROW_NUMBER() over(Partition By company, location,industry, total_laid_off, percentage_laid_off,'date',stage,country,funds_raised_millions
Order By company
) as row_num
From PortfolioProject..layoffs
)
Select *
From Duplicate_CTE
Where row_num >1  -- This is real duplicate rows


-- To confirm final time, let's check it again

Select * 
From PortfolioProject..layoffs
Where company = 'Hibob';

-- Yes! We found our duplicates data
-- Now Delete duplicate rows


With Delete_CTE As(
Select * 
From (
	Select *,
		ROW_NUMBER() over(Partition By company, location,industry, total_laid_off, percentage_laid_off,'date',stage,country,funds_raised_millions
		Order By company
		) as row_num
	From PortfolioProject..layoffs
) duplicates
Where row_num >1
)
DELETE From Delete_CTE;

-- Duplicate Data has been Deleted


-----------------------------------------------------------------------------------------------------------------------------------

-- 2. Standardize Data

Select * From PortfolioProject..layoffs


-- It looks like we have some NULL rows, let's take a look at those

Select Distinct industry,count(*) as indu_count
From PortfolioProject..layoffs
Group BY industry
Order BY indu_count


Select * 
From PortfolioProject..layoffs
Where industry is NULL or industry = 'NULL'


Select *
From PortfolioProject..layoffs
Where company = 'Airbnb';  -- it looks like airbnb is a travle (industry), but this isn't just populated enough

/*
So What can we do here?
 => Write a query that if there is another row with same company, it will update it to the non-null industry values
 makes it easy so if there were thousands we wouldn't have to manually chech then all

*/


Update PortfolioProject..layoffs
Set industry = NULL
Where industry = 'NULL' -- not there are all null


-- now we need to populate those nulls if possible

Select * 
From layoffs l1
Join layoffs l2
ON l1.company= l2.company
Where l1.industry is NULL
And l2.industry is NOT NULL;



UPDATE layoffs
SET industry = 
    CASE 
        WHEN company = 'Carvana' THEN 'Transportation'
        WHEN company = 'Airbnb' THEN 'Travel'
        WHEN company = 'Juul' THEN 'Consumer'
        ELSE industry
    END;


----------------------------------------------------------------------------
-- Crypto has multiple differetn variations. We need to standardize that

Select Distinct industry
From PortfolioProject..layoffs
Order by industry



Update layoffs
Set industry = 'Crypto'
Where industry IN ('Crypto Currency','CryptoCurrency');




Select Distinct country
From PortfolioProject..layoffs
Order By country

-- We have some 'United States' and 'United States.'. Let's standardize this

Update layoffs
Set country = Replace(country,'United States.','United States');

----------------------------------------------------------------------------------------------------------------------------
-- Let's also fix the date columns

Select *
From PortfolioProject..layoffs


SELECT [date],CONVERT(Date, [date]) AS converted_date
FROM PortfolioProject..layoffs;  



Update PortfolioProject..layoffs
Set date = CONVERT(Date, [date]); -- While it showed rows affected but didn't show any changes in table, so there is another way I should try



Select [date]
From PortfolioProject..layoffs



ALTER TABLE PortfolioProject..layoffs
ALTER COLUMN [date] DATE;



-- 4. remove any columns and rows we need to


SELECT *
FROM PortfolioProject..layoffs
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


-- Delete Useless data we can't really use
DELETE FROM PortfolioProject..layoffs
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

---------------------------------------------------------------------------------------------------------------------------------

Select * From PortfolioProject..layoffs
where company = 'Netflix'

-- Well now we have 1992 rows and 9 column

-- Okay we did some cleaning stuff. Let's analyze what this data say now.

Select Count(Distinct company) As total_number_of_company,
count(Distinct industry) As different_industry
From PortfolioProject..layoffs

-- We have 1628 companies from 30 different industry


Select * 
From PortfolioProject..layoffs
Where total_laid_off IN (Select MAX(total_laid_off) from PortfolioProject..layoffs)
-- Google laid off 12000 employee at single time in 2023

-- Q1. Which company did maximum number of laid_off?

Select company, sum(total_laid_off) As total_laidoff
From PortfolioProject..layoffs
Group By company
Order By total_laidoff DESC
-- Amazon laid of maximum number of employee i.e. 18150, followed by Google, Meta, Salesforce, Microsoft,.......


-- Q2. Which industry has maximun number of lay off?
Select industry, sum(total_laid_off) As total_laidoff
From PortfolioProject..layoffs
Group By industry
Order By total_laidoff DESC

-- Direct to Consumer based company has maximum laid off i.e Consumer followed by Retail, Transportation, Finance, Healthcare,....

Select * 
From PortfolioProject..layoffs
Where industry = 'Consumer'
Order By total_laid_off DESC

-- Google, Meta, Twitter, Yahoo, GoPro are some of the Consumer based Company


-- Q3. In which year, most of the lay off happened>

Select Year(date) as year_basis, count(*)
From PortfolioProject..layoffs
Group By year(date);

Select year(date) AS Year_laid_off, sum(total_laid_off) As total_layoff
From PortfolioProject..layoffs
Group By year(date)
Order By year(date);

-- In 2022, maximum lay off happened. Let's see which company have maximum layoff


Select industry, sum(total_laid_off) AS total_layoff
From (
Select * From PortfolioProject..layoffs
Where year(date) = '2022'
) laidoff
Group By industry
 Order By total_layoff DESC

 -- In 2022, as per industry wise, Retail has maximum layoff

 Select * From PortfolioProject..layoffs
Where year(date) = '2022' And industry = 'Retail'
Order by total_laid_off DESC

 ----------------------------

 With CTE AS (
Select * From PortfolioProject..layoffs
Where year(date) = '2022'
) 
Select company,industry, sum(total_laid_off) as total_layoff
From CTE
Group By company,industry
Order By total_layoff DESC

-- But company wise, Meta laid off to maximum number of employee i.e. 11000 followed by Amazon 10150, Cisco, Peloton,......

-------------------------------------------------------------------------------------------------------------------------------
Select country, sum(total_laid_off) AS total_layoff
From PortfolioProject..layoffs
Group By country
Order by total_layoff DESC

-- United States did maximum laid off followed by India, Netherlands, Sweden, Brazil,........

Select country,YEAR(date) AS laidoff_year,sum(total_laid_off) AS total_layoff
From PortfolioProject..layoffs
Group By country, YEAR(date)
Order by total_layoff DESC,YEAR(date)

--  United Stated laid off 106381 employee in 2022, 89684 in 2023,50385 in 2020 and 9470 in 2021  



-- Thank You !!!!

