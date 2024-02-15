
-- CTE (Common Table Expression)

WITH CTE_EMPLOY AS (
SELECT Employee.EmployeeName, GENDER, SALARY,
COUNT(GENDER) OVER (PARTITION BY GENDER) AS TOTALGENDER
, AVG(SALARY) OVER (PARTITION BY GENDER) AS AVGSALARY
FROM Employee
JOIN EmployeeSalary ON
Employee.EmployeeID = EmployeeSalary.EmployeeID
WHERE SALARY > 45000
)
SELECT * FROM CTE_EMPLOY

------------------------------------------------------------------
Select * From [SQL Tutorial]..Customers2

Select Avg(Amount) As Avg_amount
from [SQL Tutorial]..Customers2

Select *
From [SQL Tutorial]..Customers2
Where Amount > (Select Avg(Amount) As Avg_amount
from [SQL Tutorial]..Customers2) 
-- With WITH Clause------
With avg_amount(avg_amt) as(
Select Avg(Amount)
from [SQL Tutorial]..Customers2
)
Select * From [SQL Tutorial]..Customers2 Cus, avg_amount am
Where Cus.Amount > am.avg_amt

-------------------------------------------------------------------


Create table Sales(
store_id int,
store_name varchar(50),
product varchar(50),
quantity int,
cost int
)

Insert Into Sales values
(1,'Apple Originals 1','iPhone 12 Pro',1,1000),
(1,'Apple Originals 1','MacBook pro 13',3,1200),
(1,'Apple Originals 1','iPhone 12',2,800),
(1,'Apple Originals 1','AirPods Pro',4,250),
(2,'Apple Originals 2','iPhone 13 Pro',2,1150),
(2,'Apple Originals 2','MacBook pro 13',1,1200),
(3,'Apple Originals 3','iPhone 12 Pro',5,1000),
(3,'Apple Originals 3','iPhone 14 Pro Max',1,1250),
(3,'Apple Originals 3','iPhone 12 Pro',2,1000),
(2,'Apple Originals 2','Apple Watch',5,6500),
(4,'Apple Originals 4','Apple Vision Pro',1,3500),
(4,'Apple Originals 4','iPhone 13',3,1190),
(4,'Apple Originals 4','iPhone 12 Pro',1,1000)

Select * From Sales

---------------------------------------------------------------------------------------------
-- Find stores who's sales were better than the average sales accross all stores

-- Total Sales per each store
Select store_id, sum(cost) as total_cost_per_store
From Sales
Group BY store_id

-- Average sales with respect to each of the store

Select avg(total_cost_per_store) As avg_cost_per_store
From (Select S.store_id, sum(cost) as total_cost_per_store
From Sales S
Group BY S.store_id) X;

-- Find the store where total sales > ave sales of all stores
Select * 
From (Select store_id, sum(cost) as total_cost_per_store
		From Sales
		Group BY store_id) total_sales
Join (Select avg(total_cost_per_store) As avg_cost_per_store
		From (Select S.store_id, sum(cost) as total_cost_per_store
		From Sales S
		Group BY S.store_id) X) avg_sales
on total_sales.total_cost_per_store > avg_sales.avg_cost_per_store


----------------------------------------------------------------------------------------------------------------
-- WITH Clause
With total_sales(store_id, total_cost_per_store) as
		(Select store_id, sum(cost) as total_cost_per_store
				From Sales
				Group BY store_id),
	avg_sales(avg_cost_per_store) as
	(Select avg(total_cost_per_store) as avg_cost_per_store
	from total_sales)
Select *
From total_sales ts
Join avg_sales av
On ts.total_cost_per_store >av.avg_cost_per_store



--------------------------------------------------------
Select *
From Sales

Select store_id, sum(cost) as total_cost_per_store
From Sales
Group By store_id


Select store_id, avg(cost) as avg_cost_per_store
From Sales
Group By store_id

Select avg(total_cost_per_store) as avg_cost_per_store   -- It takes avgerage cost from 4 stores total cost
From (Select store_id, sum(cost) as total_cost_per_store
From Sales
Group By store_id) x;


With total_sales(store_id, total_cost_per_store) as
	 (Select store_id, sum(cost) as total_cost_per_store
	From Sales
	Group By store_id),
	average_sales(avg_cost_per_store) as 
	(Select avg(total_cost_per_store)
	from total_sales)
Select * 
From total_sales ts
Join average_sales av
On ts.total_cost_per_store > av.avg_cost_per_store