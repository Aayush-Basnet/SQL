/*
This is SQL project where I'll analyze Adidas Sales Dataset. This dataset is downloaded from kaggle.

Objective
1. Update Table, Add require column & Check Duplicate values
2. Total sales based on different category; Gender, City, Month
3. Top Selling Product:  Identifing the top-selling products based on quantity sold or total revenue generated
4. Customer Segmentation: Group customers based on purchase history (frequency, amount), demographics (region, city), or product preferences.
5. Sales Method: Online, In-store, Outlet
6. Most Popular product based on Month, City, Gender
*/


Select * 
From PortfolioProject..AdidasSales;


/* There are 9,648 rows and 14 columns, Given the sample dataset containing information like Retailer,
Invoice Date, State, City, Product, Sales, Profit, etc., here's a breakdown of potential analyses using SQL queries,
*/

Create Procedure Adidas As
Select * From PortfolioProject..AdidasSales
Go;

Exec Adidas
-------------------------------------------------------------------------
-- Let's find Gender of our customer

Select Product,
	SUBSTRING(Product,1,1) As Gender
From PortfolioProject..AdidasSales


Alter Table PortfolioProject..AdidasSales
Add Gender nvarchar(2);

Update PortfolioProject..AdidasSales
Set Gender = SUBSTRING(Product,1,1);

Update PortfolioProject..AdidasSales
Set Gender = REPLACE(Gender, 'W','F')


Select * 
From PortfolioProject..AdidasSales

---------------------------------------

-- Adding Month and Year in our dataset

Select [Invoice Date],
DATENAME(month,[Invoice Date]) As [Month Name],
DATENAME(YEAR,[Invoice Date]) As [Year Name]
From PortfolioProject..AdidasSales



Alter Table PortfolioProject..AdidasSales
Add [Month] varchar(12);

Update PortfolioProject..AdidasSales
Set [Month] = DATENAME(month,[Invoice Date])

Update PortfolioProject..AdidasSales
Set [Month] = SUBSTRING([Month],1,3);

ALTER TABLE PortfolioProject..AdidasSales
ADD [Year] INT;

UPDATE PortfolioProject..AdidasSales
SET [Year] = CAST(YEAR([Invoice Date]) AS INT);



Exec Adidas

---------------------------------------------------------------------------------

-- Checking Duplicate Values

Select *,
ROW_NUMBER() Over(Partition By Retailer, [Retailer ID],[Invoice Date],Region, State, City, Product, [Price Per Unit],
[Units Sold],[Total Sales],[Operating Profit],[Operating Margin],[Sales Method],Gender, Year, Month
order by Retailer
) As row_num
From PortfolioProject..AdidasSales;


With CTE As 
(
Select *,
ROW_NUMBER() Over(Partition By Retailer, [Retailer ID],[Invoice Date],Region, State, City, Product, [Price Per Unit],
[Units Sold],[Total Sales],[Operating Profit],[Operating Margin],[Sales Method],Gender, Year, Month
order by Retailer
) As row_num
From PortfolioProject..AdidasSales
)
Select * 
From CTE
Where row_num > 1;

-- There is no duplicate value. 

--------------------------------------------------------------------------------------
-- Now  here's a breakdown of potential analyses using SQL queries


-- Calculating Total Sales based on different category

SELECT 
  Gender,
  SUM([Total Sales]) AS Total_Sales_Gender,
  ROUND((SUM([Total Sales]) / (SELECT SUM([Total Sales]) FROM PortfolioProject..AdidasSales) * 100), 2) AS Percentage_of_Total_Sales
FROM PortfolioProject..AdidasSales
GROUP BY Gender
ORDER BY Gender;


SELECT 
  Gender,
  SUM([Operating Profit]) AS Total_profit_Gender,
  ROUND((SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM PortfolioProject..AdidasSales) * 100), 2) AS Percentage_of_Total_Operatingprofit
FROM PortfolioProject..AdidasSales
GROUP BY Gender
ORDER BY Gender;


-- Male leads in both sales and operating profit with 54.03% of total sales & 54.01% of operating profit among 52 City generating $486,228,556M in revenue

Select Distinct City
From PortfolioProject..AdidasSales

Select City,
SUM([Total Sales]) As Total_Sales_City,
ROUND((SUM([Total Sales]) / (SELECT SUM([Total Sales]) FROM PortfolioProject..AdidasSales) * 100), 2) As Per_total_sales_city
From PortfolioProject..AdidasSales
Group By City
Order By Per_total_sales_city DESC


SELECT 
  City,
  SUM([Operating Profit]) AS Total_profit_city,
  ROUND((SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM PortfolioProject..AdidasSales) * 100), 2) AS Per_tot_opearing_profit
FROM PortfolioProject..AdidasSales
GROUP BY City
ORDER BY Per_tot_opearing_profit DESC;

-- Charleston City did most sales generating $39,974,797M (4.44%) in revenue & 4.69% in profit, followed by New York City with 4.42 % in total sales & 4.18% in profit


Select MONTH,		-- sales trends over time
Sum([Total Sales]) As total_sales_month,
ROUND((SUM([Total Sales]) / (SELECT SUM([Total Sales]) FROM PortfolioProject..AdidasSales) * 100), 2) As per_total_sales_month
From PortfolioProject..AdidasSales
Group by Month
Order By per_total_sales_month DESC
 
SELECT 
  Month,
  SUM([Operating Profit]) AS Total_Sales_month,
  ROUND((SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM PortfolioProject..AdidasSales) * 100), 2) AS Percentage_of_Total_Operatingprofit
FROM PortfolioProject..AdidasSales
GROUP BY Month
ORDER BY Percentage_of_Total_Operatingprofit DESC;

-- Jul and Aug saw highest sales, 10.61% & 10.24% of total sales & profit of 10.25% & 10.37%, month followed by Dec with 9.53%. Mar month has lowest sales & profit.


-------------------------------------------------------------------------------------------------------------------------------

-- Top Selling Product:  Identifing the top-selling products based on quantity sold or total revenue generated.

Select Distinct Product
From PortfolioProject..AdidasSales   -- We have total of 6 product, 3 Men's and 3 Women's Product

Select Product, [Units Sold],[Total Sales]
From PortfolioProject..AdidasSales


Select Product,
	sum([Units Sold]) As total_unit_sold,
	sum([Total Sales]) As total_sales_per_product,
	sum([Operating Profit]) As product_profit
From PortfolioProject..AdidasSales
Group By Product
Order by total_sales_per_product DESC, product_profit ,total_unit_sold 


-- Men's Street Footwear is most sold product with 593,320 unit sold, generating $208,826,244M in revenue & $82,802,260.62M in profit
-- Women's Athletic Footwear is second least sold product, generating least profit and sales compared to others.

-------------------------------------------------------------------------------------------------------------------

-- Customer Segmentation: Group customers based on purchase history (frequency, amount), demographics (region, city), or product preferences.

Exec Adidas;


With CustomerPurchase As 
(
Select Retailer,
count(*) As PurchaseCount
From PortfolioProject..AdidasSales
Group By Retailer
)
Select 
	Retailer,
	PurchaseCount,
	CASE 
		WHEN PurchaseCount <=800 Then 'Occasional Buyer'
		WHEN PurchaseCount <=1600 Then 'Regular Buyer'
		Else 'Frequent Buyer'
	End As CustomerSegmentation
From CustomerPurchase;


-- Product having average sales greater than total average

Select AVG([Total Sales]) As total_avg_sales   -- $93,273.4373
From PortfolioProject..AdidasSales;



With highestsales As
(
Select Product,
	AVG([Total Sales]) As Average_sales_per_product
From PortfolioProject..AdidasSales
Group By Product
)
Select * 
From highestsales
Where Average_sales_per_product > (Select AVG([Total Sales])
From PortfolioProject..AdidasSales);

-- Comparing to total average sales, only 3 product have higher average sales value than total average sales
----------------------------------------------------------------------------------------------------------------

-- Sales Method: Online, in-store, or Outlet

Select
	[Sales Method], 
	COUNT(*) As purchase_number,
	SUM([Total Sales]) As total_sales,
	sum([Operating Profit]) As total_operating_profit,
	ROUND((SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM PortfolioProject..AdidasSales) * 100), 2) As operating_profit_per_platform,
	AVG([Operating Margin])*100 as average_operating_margin
From PortfolioProject..AdidasSales
Group By [Sales Method]


Select 
	[Sales Method], 
	Product, 
	sum([Total Sales]) as total_sales,
	RANK() over(Partition By [Sales Method]
		order by sum([Total Sales]) DESC) as ranks
From PortfolioProject..AdidasSales
Group by [Sales Method], Product

/*  # Findings
1. In-store has less number of purchase count but has highest sales. Whereas customers buy most through online, but it has lowest sales among 3.
2. Online has highest operating margin(55.6%) compared to other platform.
3. Average opearting margin of each platform looks like this. online (46.41%), In-Store(35.61%), and outlet(39.49%)
4. Men's Street Footware is most sold and Women's Street Footwear is least sold product in all platform
*/

Select *
From PortfolioProject..AdidasSales
Where [Sales Method] = 'In-store';

-------------------------------------------------------------------------------------------------

-- Most Popular/sold product

Create View monthlysales 
As
With top_product as
(
Select [Month],
		Product,
	SUM([Units Sold]) as total_unit_sold
From PortfolioProject..AdidasSales
Group By [month], Product
)
Select [Month], Product,
RANK() over(Partition By [Month] order by total_unit_sold DESC) As product_rank
FROM top_product

Select 
[Month], Product 
From monthlysales
Where product_rank = 1 or product_rank = 2;

-- Men's Street Footware is more sold product of all time.


With states_sales As
(
Select State, 
	Product,
	SUM([Units Sold]) as total_unit_sold,
DENSE_RANK() over(Partition by State 
						order by SUM([Units Sold]) DESC) as ranks
From PortfolioProject..AdidasSales
Group By State, Product
)
Select State, Product
From states_sales
Where ranks = 1;

--  Men's Street Footwear is the most sold product in all state


Select
	Gender,
	Product,
	sum([Total Sales]) as total_sales,
	RANK() over(Partition by gender 
		order by sum([Total Sales]) DESC) as ranks
From PortfolioProject..AdidasSales
Group By Gender, Product

/*
This is most sold product(in order) among Male and Female.
Female top sold products are: Apparel, Street Footwear, and Athletic Footwear
Male top sold product are: Street Footwear, Athletic Footwear and Apparel
*/
---------------------------------------------------------------------------------------------------------------------------
Exec Adidas

