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


/* 
An Adidas sales dataset is a collection of data that includes information on the sales of Adidas products. This type of dataset
may include details such as the number of units sold, the total sales revenue, the location of the sales, the type of product sold,
and any other relevant information.
Adidas sales data can be useful for a variety of purposes, such as analyzing sales trends, identifying successful products or marketing
campaigns, and developing strategies for future sales. It can also be used to compare Adidas sales to those of competitors, or to analyze
the effectiveness of different marketing or sales channels.

There are a variety of sources that could potent
There are 9,648 rows and 14 columns, Given the sample dataset containing information like Retailer,
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
-- Now  here's a breakdown of potential analysis using SQL queries

Exec Adidas;

-- Basic Queries

-- Retrieve the total number of units sold.
Select sum([Units Sold]) as total_units_sold,
	SUM([Operating Profit]) as total_profit
From PortfolioProject..AdidasSales;


-- Calculate the total revenue and profit generated from sales.
Select SUM([Total Sales]) as Total_Sales
From PortfolioProject..AdidasSales;


-- Identify the highest-priced products.
Select Product, [Price per Unit]
From PortfolioProject..AdidasSales
Order By [Price per Unit] DESC


-- Identify the most common Product ordered.
Select Product,sum([Units Sold]) as [Units Sold]
From PortfolioProject..AdidasSales
Group By Product
Order By [Units Sold] DESC;


-- List all unique cities where customers are located.
Select Distinct State
From PortfolioProject..AdidasSales


-- Count the number of orders placed in Per Year.
Select YEAR([Invoice Date]) as [Year] ,
	SUM([Units Sold]) as total_unit_sold
From PortfolioProject..AdidasSales
Group By YEAR([Invoice Date]);


-- Find the total sales per Product
Select Product,
	sum([Total Sales]) as Total_Sales
From PortfolioProject..AdidasSales
Group By Product
Order By Total_Sales DESC;


-- Count order sold  from each state.
Select State, count([Retailer ID]) as Number_of_Orders
From PortfolioProject..AdidasSales
Group By State;


--  Calculate the total units sold per month in 2021.
Select 
	DATENAME(MONTH,[Invoice Date]) as Month_Name,
	sum([Units Sold]) total_unit_sold
From PortfolioProject..AdidasSales
Where YEAR([Invoice Date]) = 2021
Group By DATENAME(MONTH,[Invoice Date])
Order by  Month_Name


--  Find the average number of units sold , grouped by Retailer.
With avg_sales As(
Select Retailer, sum([Units Sold]) as total_sales
From PortfolioProject..AdidasSales
Group by Retailer
)
Select Avg(total_sales) as avg_unit_sales
From avg_sales

--  Calculate the percentage of total revenue contributed by each product category.
Select 
	Product, sum([Total Sales]) as Product_Total_Sales,
	Round((
		sum([Total Sales])/
		(Select sum([Total Sales]) from PortfolioProject..AdidasSales)*100),2) as Total_Sales_Percentage
From PortfolioProject..AdidasSales
Group by Product
Order By Total_Sales_Percentage DESC;




-- Calculating Percentage of Sales and Operating Profit based on Different Category;Gender, City, & Time:

		-- Gender
SELECT 
  Gender,
  SUM([Total Sales]) AS Total_Sales_Gender,
  ROUND((SUM([Total Sales]) / (SELECT SUM([Total Sales]) FROM PortfolioProject..AdidasSales) * 100), 2) AS Percentage_of_Total_Sales,
  SUM([Operating Profit]) AS Total_profit_Gender,
  ROUND((SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM PortfolioProject..AdidasSales) * 100), 2) AS Percentage_of_Total_Operatingprofit
FROM PortfolioProject..AdidasSales
GROUP BY Gender
ORDER BY Gender DESC;
-- Male leads in both sales and operating profit with 54.03% of total sales & 54.01% of operating profit among 52 City generating $486,228,556M in revenue



	-- City Wise Distribution
Select Distinct City
From PortfolioProject..AdidasSales

Select City,
SUM([Total Sales]) As Total_Sales_City,
ROUND((SUM([Total Sales]) / (SELECT SUM([Total Sales]) FROM PortfolioProject..AdidasSales) * 100), 2) As Per_total_sales_city
From PortfolioProject..AdidasSales
Group By City
Order By Per_total_sales_city DESC
--  Men's Street Footwear is the most sold product in all state

SELECT 
  City,
  SUM([Operating Profit]) AS Total_profit_city,
  ROUND((SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM PortfolioProject..AdidasSales) * 100), 2) AS Per_tot_opearing_profit
FROM PortfolioProject..AdidasSales
GROUP BY City
ORDER BY Per_tot_opearing_profit DESC;
-- Charleston City did most sales generating $39,974,797M (4.44%) in revenue & 4.69% in profit, followed by New York City with 4.42 % in total sales & 4.18% in profit



		-- Sales Trend Over Time
Select MONTH,		-- Total Sales % Per Month
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
-- Jul and Aug saw the highest sales, 10.61% & 10.24% of total sales & profit of 10.25% & 10.37%, month followed by Dec with 9.53%. Mar month has lowest sales & profit.

---------------------------------------------------------------------------------------------------------------------------------------------------

--  Calculate the total revenue generated by each retailer, and rank them by revenue.
With top_retailer As(
Select Retailer,sum([Total Sales]) as total_sales
From PortfolioProject..AdidasSales
Group by Retailer
)Select *,
	RANK()over(order by total_sales DESC) as retailer_rank
From top_retailer;


-- Calculate the year-over-year growth rate of total sales.
With sales_rate as(
Select Year([Invoice Date]) as [Year],
	sum([Total Sales]) as sales
From PortfolioProject..AdidasSales
Group by YEAR([Invoice Date])
)
Select [Year], sales, ((sales- LAG(sales,1)over(order by [Year]))/ lag(sales,1) over(order by [Year]))*100 as year_growth_rate
From sales_rate;


-- Calculate the month-over-month growth rate of total sales
With month_sales_rate as(
Select Year([Invoice Date]) as [Year],
	Month([Invoice Date]) as [Month],
	sum([Total Sales]) as sales
From PortfolioProject..AdidasSales
Group by YEAR([Invoice Date]), Month([Invoice Date])
)
Select [Year],[Month], sales, ((sales- LAG(sales,1)over(order by [Year],[Month]))/ lag(sales,1) over(order by [Year],[Month]))*100 as month_growth_rate
From month_sales_rate;
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


-- Percentage Contribution of each product to sales and profit
Select Product,
	Round((sum([Total Sales])/(select sum([Total Sales]) from PortfolioProject..AdidasSales)*100),2) as Per_Sales_Contribution,
	Round((sum([Operating Profit])/(select sum([Operating Profit]) from PortfolioProject..AdidasSales)*100),2) as Per_Profit_Contribution
From PortfolioProject..AdidasSales
Group By Product
Order By Per_Sales_Contribution

-- Men's Street Footwear is most sold product with 593,320 unit sold, generating $208,826,244M in revenue & $82,802,260.62M in profit
-- Women's Athletic Footwear is second least sold product, generating least profit and sales compared to others.

-------------------------------------------------------------------------------------------------------------------

-- Retailer Segmentation: Group customers based on purchase history (frequency, amount), demographics (region, city), or product preferences.

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


With Retailer_Sold As(
Select Retailer, sum([Units Sold]) as unit_sold
From PortfolioProject..AdidasSales
Group By Retailer
)
Select Retailer, unit_sold,
CASE 
	WHEN unit_sold <= (select avg(unit_sold) from Retailer_Sold) Then 'Low Seller Retailer'
	Else 'High Seller Retailer'
	End as RetailerSegmentation
From Retailer_Sold
Order by unit_sold;


--  top 3 retailer who sold the most units in each year.
With top_retailer As(
Select *,
	RANK()over(Partition By [Year] order by [Year],[unit_sold] DESC) as ret_rank
From (
select YEAR([Invoice Date]) as [Year],
	Retailer, sum([Units Sold]) as unit_sold
From PortfolioProject..AdidasSales
Group by YEAR([Invoice Date]), Retailer) as A
)
Select [Year],Retailer, unit_sold
From top_retailer
Where ret_rank <=3;



-- Find the Product having average sales greater than total average

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
/* Comparing to total average sales, only 3 product have higher average sales value than total average sales*/


--  Calculate the moving average of order values for each retailer over their order history.
Select [Retailer ID],[Invoice Date], [Units Sold],
	AVG([Units Sold]) over(Partition by [Retailer ID] order by [Invoice Date] rows between 2 preceding and current row) as moving_avg
From (
Select [Retailer ID], [Invoice Date], [Units Sold]
From PortfolioProject..AdidasSales) as a;

----------------------------------------------------------------------------------------------------------------

-- Sales Method: Online, in-store, or Outlet

Select
	[Sales Method], 
	SUM([Units Sold]) As units_sold,
	SUM([Total Sales]) As total_sales,
	sum([Operating Profit]) As total_operating_profit,
	ROUND((SUM([Operating Profit]) / (SELECT SUM([Operating Profit]) FROM PortfolioProject..AdidasSales) * 100), 2) As operating_profit_per_platform,
	AVG([Operating Margin])*100 as average_operating_margin
From PortfolioProject..AdidasSales
Group By [Sales Method];


--  Rank the Sales Method based on sales
Select 
	[Sales Method], 
	Product, 
	sum([Total Sales]) as total_sales,
	RANK() over(Partition By [Sales Method]
		order by sum([Total Sales]) DESC) as ranks
From PortfolioProject..AdidasSales
Group by [Sales Method], Product

/*  # Findings
1. In-store has sold less units compared to others but has highest sales. Whereas customers buy most through online, but it has lowest sales among 3.
2. Online has highest operating margin(55.6%) compared to other platform.
3. Average opearting margin of each platform looks like this. online (46.41%), In-Store(35.61%), and outlet(39.49%)
4. Men's Street Footware is most sold and Women's Street Footwear is least sold product in all platform
*/

Select *
From PortfolioProject..AdidasSales
Where [Sales Method] = 'In-store';

-------------------------------------------------------------------------------------------------

-- Most Popular/Sold product

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
/* Men's Street Footware is more sold product of all time.*/


-- Analyze the cumulative revenue generated over time.
Select [Invoice Date], revenue,
	SUM(revenue) over(Order by [Invoice Date]) as cumulative_revenue
From (
Select [Invoice Date], SUM([Total Sales]) as revenue
From PortfolioProject..AdidasSales
Group by [Invoice Date]
-- Order by [Invoice Date]
) as rev_table;



-- Find the most sold product in all states
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



-- Find popular product among Gender based on sales
Select
	Gender,
	Product,
	sum([Total Sales]) as total_sales,
	RANK() over(Partition by gender 
		order by sum([Total Sales]) DESC) as ranks
From PortfolioProject..AdidasSales
Group By Gender, Product;
/*
Female top sold products are: Apparel, Street Footwear, and Athletic Footwear
Male top sold product are: Street Footwear, Athletic Footwear and Apparel
*/


-- Determine the top 3 most ordered product based on revenue.
With top_product as(
Select Product,total_sales,
Dense_Rank() over(order by total_sales DESC) as product_rank
From(
Select Product, SUM([Total Sales]) as total_sales
From PortfolioProject..AdidasSales
Group by Product) as a
)
Select Product, total_sales
From top_product
Where product_rank<=3;
/*Top 3 most ordered products are Men's Street Footwear, Women's Apparel & Men's Atheltic Footwea.*/



---------------------------------------------------------------------------------------------------------------------------
Exec Adidas

