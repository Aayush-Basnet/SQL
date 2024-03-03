-----------------------------------------------------------------------------------------------------------------------------------------
-- Creating new table named as Customers
Create Table [SQL Tutorial]..Customers(
CustomerID int,
CustomerName varchar(100),
ContactName varchar(100),
Address varchar(100),
City varchar(50),
PostalCode varchar(50),
Country varchar(50)
)


-- Inserting data into Customer Table
Insert Into [SQL Tutorial]..Customers values
(1,'Alfreds Futterkiste','Maria Anders', 'Obere Str. 57','Berlin','12209','German'),
(2,'Ana Trujillo Emparedados y helados','Ana Trujillo', 'Avda. de la Consiticuion 2222','Tokyo','13235','Japan'),
(3,'Anatonio Moreno','Antonio Moreno', 'Mataderos 2312','Boston','12359 V','USA'),
(4,'Blauer See Delikatessen','Hanna Moos', 'Forsterstr. 57','Berlin','12209','German'),
(5,'Bon app','Laurence Lebihans', '12, rue des Bouchers','London','AB-538233','UK'),
(6,'Comerico Minerio','Pedro Afonso', 'Av. dos Lusiadas, 23','Mexico D.F','050284','Mexico'),
(7,'Du Monde entier','Janine Labrune', '67, rue des Cinquante Otages','Marseila','T2F5 8M4','France'),
(8,'Eastern Connection','Ann Devon', '35 King George','Buenos Aries','1010','Argentina'),
(9,'Ernst Handel','Ronald Mendel', 'Kirchgasse 6','Mexico D.F','05002','Mexico'),
(10,'Folies','Marine Rance', '184, chaussee','Berlin','London','UK')
-------------------------------------------------------------------------------------------------------------------------------------
-- Select everything from table
Select * From [SQL Tutorial]..Customers
-- EXEC Customer             Store Procedure, look at last 
------------------------------------------------------------------------------------------------------------------
--Number of unique country
Select count(Distinct Country) From [SQL Tutorial]..Customers
-- Name of country of customers
Select Distinct Country From [SQL Tutorial]..Customers

--------------------------------------------------------------------------------------------------------------------
-- Where Clause
-- Customer Details from Berlin only
Select * From [SQL Tutorial]..Customers
Where City ='Berlin'
-- Customer Details from customerid 4 to 8.
Select * From [SQL Tutorial]..Customers
Where CustomerID Between 4 AND 8;
-- Customer Details from country name starts with M
Select * From [SQL Tutorial]..Customers
Where Country Like 'M%';

--------------------------------------------------------------------------------------------------------------------
-- Order By
Select * From [SQL Tutorial]..Customers
Order By ContactName

-- Creating table name Products
Create Table [SQL Tutorial]..Products(
ProductID int,
ProductName varchar(100),
SupplierID int,
CategoryID int,
Unit varchar(100),
price int
)

Insert Into [SQL Tutorial]..Products Values
(1,'Chais',1,1, '10 boxes x 20 bags',18),
(2,'Chang',1,1, '24-12 oz bottles',19),
(3,'Aniseed Syrup',1,2, '12-550 ml bottles',10),
(4,'Chef Anton Cajun Seasoning',2,2, '48-6 oz jars',22),
(5,'Grandma Boysenberry',3,2, '12-8 oz jars',24),
(6,'Uncle Bob',3,7, '12-1 lb pkgs',30),
(7,'Northwoods Cranberry Sauce',4,6, '12-12 oz jars',40),
(8,'Ikura',4,8, '18-500 g pkgs',97),
(9,'Konbu',4,3, '2 kg box',6),
(10,'Tofu',5,7, '40-100g pkgs',24),
(11,'Genen Shouyu',6,5, '24-250 ml bottles',15.5),
(12,'Pavlova',7,3, '32-500g boxes',18),
(13,'Alice Mutton',5,6, '20-1 kg tins',39)

-- Products ordering by price from highest to lowest
Select * From [SQL Tutorial]..Products
Order by price DESC
-- Customers order by country and then by address
Select * From [SQL Tutorial]..Customers
Order By Country, Address

Select * From [SQL Tutorial]..Customers
Order By Country ASC, CustomerName DESC
-------------------------------------------------------------------------------------------------------------------------------------
-- Where clause can contain one or many AND operators
Select * From [SQL Tutorial]..Customers
Where Country = 'German' and CustomerName Like 'A%'

-- Combining AND and OR
Select * From [SQL Tutorial]..Customers
Where Country = 'Uk' AND (CustomerName Like 'B%' OR CustomerName Like 'R%');

Select * From [SQL Tutorial]..Customers
Where Country = 'Uk' OR CustomerName Like 'B%' AND CustomerName Like 'R%';

-- Where Clause can contain one or more OR operator
Select * From [SQL Tutorial]..Customers
Where Country = 'Uk' OR CustomerName Like 'B%' OR CustomerName Like 'R%';

Select * From [SQL Tutorial]..Customers
Where CustomerName Like '%A' or Country = 'German' or Country = 'UK';

-----------------------------------------------------------------------------------------------------------------------------------------
--NOT Operator
Select * From [SQL Tutorial]..Customers
Where NOT Country = 'German' ;

-- NOT Like
Select * From [SQL Tutorial]..Customers
Where  CustomerName NOT Like 'A%';

-- NOT Between
SELECT * FROM [SQL Tutorial]..Customers
WHERE CustomerID NOT BETWEEN 5 AND 7;

-- NOT In
SELECT * FROM [SQL Tutorial]..Customers
WHERE City NOT IN ('Berlin', 'London');
----------------------------------------------------------------------------------------------------------------------------------------
-- Insert Into
Insert Into[SQL Tutorial].. Customers(CustomerID, CustomerName, City, Country) values
(11,'Fork Honk','Austin','USA')

-- NULL Values
Select * From [SQL Tutorial]..Customers
Where ContactName is NULL;
------------------------------------------------------------------------------------------------------------------------------------
-- Update
Update [SQL Tutorial]..Customers
Set CustomerName = 'Follies Henry'
Where CustomerID=10;
-- updating multiple records
Update [SQL Tutorial]..Customers
Set CustomerName = 'June Alias'
Where City = 'Boston';

--------------------------------------------------------------------------------------------------------------------------------------------
-- Delete
-- Delete records from table
Delete From [SQL Tutorial]..Customers
Where ContactName is NULL;


--Delete From Customers         // Delete all records

--To delete table compeletly:        
Drop Table [SQL Tutorial]..Customers
----------------------------------------------------------------------------------------------------------------------------
-- SQL Select TOP
Select Top 8 * from [SQL Tutorial]..Products  -- select only first 8 records of products
Order BY price DESC


Select Top 35 percent * from [SQL Tutorial]..Products  -- select only first 35% records of products
Order BY price DESC

--------------------------------------------------------------------------------------------------------------
-- MIN, MAX, AVG, SUM
Select * From [SQL Tutorial]..Products
Select MIn(price) From [SQL Tutorial]..Products;

Select Max(price) From [SQL Tutorial]..Products;

Select Avg(price) From [SQL Tutorial]..Products;

Select sum(price) From [SQL Tutorial]..Products;

-- Return all products with a higher price than average
Select * From [SQL Tutorial]..Products
Where price >(Select Avg(price) From Products);

Select Min(price) As Minimum_price,
Max(price) As Maximum_price,
Avg(price) As Average_price,
Sum(price) As total_price
From [SQL Tutorial]..Products;


Select CategoryID, count(CategoryID) As [Number of item],
Min(price) As Minimum_price,
Max(price) As Maximum_price,
Avg(price) As Average_price,
Sum(price) As total_price
From [SQL Tutorial]..Products
Group By CategoryID;

-------------------------------------------------------------------------------------------------------------------------------
-- SQL Count
Select count(price) From [SQL Tutorial]..Products   --13

Select Count(Distinct SupplierID) From [SQL Tutorial]..Products  

------------------------------------------------------------------------------------------------------------------------------
-- SQL LIKE and WildCards
Select * From [SQL Tutorial]..Customers
Where Country Like 'U%'

Select * From [SQL Tutorial]..Customers
Where City Like 'L_N_O_'
-- Select From Customers whose name starts from A,B and C.
Select * From [SQL Tutorial]..Customers
Where CustomerName LIke '[ABC]%';
--Select all customers whose name starts with a and ends with e
Select * From [SQL Tutorial]..Customers
Where CustomerName Like 'A%E';
-- Return all customers from city that contain letter L
Select * From [SQL Tutorial]..Customers
Where City Like '%L%';
-- Return all customers from city that ends with letter n
Select * From [SQL Tutorial]..Customers
where city like '%n';

-- Return all [SQL Tutorial]..customers where city name not starts with L,B and M.
Select * From Customers
Where City Like '[^LBM]%'
-- Return all products where productname name from a,b,c,d,e,b
Select * From [SQL Tutorial]..Products
Where ProductName LIke '[a-f]%'

--------------------------------------------------------------------------------------------------------

Select A.CustomerName As Naeme1, B.CustomerName As A2, A.city
From [SQL Tutorial]..Customers A, [SQL Tutorial]..Customers B
Where A.CustomerID = B.CustomerID
And A.city = B.City
Order By A.city

--Drop Table Orders
Create Table Orders(
OrderID int,
CustomerID int,
EmployeeID int,
ShipperID int
)
Insert Into Orders Values
(10248, 5, 4, 3),
(10249, 4, 5, 2),
(10250, 7, 3, 2),
(10251, 8, 4, 1),
(10252, 6, 2, 1),
(10253, 5, 6, 3),
(10254, 1, 8, 2),
(10255, 9, 7,  1),
(10256, 2, 9, 3),
(10257, 3, 2, 2),
(10258, 8, 1, 3)

Select * From Orders
-----------------------------------------------------------------------------
Create Table Shippers(
ShipperID int,
ShipperName varchar(50),
Phone varchar(50)
)
Insert Into Shippers Values
(1,'Speedy Express','(503) 555-9831)'),
(2,'United Package','(503) 555-3199)'),
(3,'Federal Shipping','(503) 555-9931)')

Select * From Shippers
--------------------------------------------------------------------------------------------------------
-- SQL Joins
Select * From [SQL Tutorial]..Customers

Select * From Shippers

Select * From Orders


Select * From [SQL Tutorial]..Customers
Join Orders
On Customers.CustomerID = Orders.CustomerID

Select Orders.OrderID, Customers.CustomerName, Customers.Address
From [SQL Tutorial]..Customers
Join Orders
On Customers.CustomerID = Orders.CustomerID

-- Left/Right/FUll Outer Join
Select * From [SQL Tutorial]..Customers
Full Outer Join Orders
On Customers.CustomerID = Orders.CustomerID

Select * From [SQL Tutorial]..Customers
Left Outer Join Orders
On Customers.CustomerID = Orders.CustomerID

Select * From [SQL Tutorial]..Customers
Right Outer Join Orders
On Customers.CustomerID = Orders.CustomerID

Select Orders.OrderID, Customers.CustomerName, Customers.Address
From [SQL Tutorial]..Customers
Full outer Join Orders
On Customers.CustomerID = Orders.CustomerID

-- Join Three table
Select Orders.OrderID,Customers.CustomerName, Shippers.ShipperName
From ((Orders
Join Customers ON Orders.CustomerID = Customers.CustomerID)

Join Shippers on Orders.ShipperID = Shippers.ShipperID);

-----------or-----------
Select Orders.OrderID,Customers.CustomerName, Shippers.ShipperName
From Orders
Join Customers ON Orders.CustomerID = Customers.CustomerID
Join Shippers on Orders.ShipperID = Shippers.ShipperID;


-- Self Join
Select Cus1.CustomerName, Cus2.City
From Customers Cus1
Join Customers Cus2
On Cus1.CustomerID = Cus2.CustomerID
-----------------------------------------------------------------------------------------------------------------------------------------------
Create Table Suppliers(
SupplierID int,
SupplierName varchar(100),
ContactName varchar(50),
Address varchar(80),
City varchar(50),
PostalCode varchar(50),
Country varchar(50)
)
Insert Into Suppliers Values
(1 ,'Exotic Liquid ','Charlotte Cooper','49 Gilbert St.','Londona', 'EC1 4SD', 'UK') ,
(2 ,'New Orleans Cajun Delights','Shelley Burke','P.O. Box 78934',' New Orleans' ,'	70117 ','USA' ), 
(3 	,'Grandma Kelly Homestead',' Regina Murphy' ,'707 Oxford Rd. '	,'Ann Arbor ',	'48104' 	,'USA '), 
(4 ,'Tokyo Traders ','Yoshi Nagase', '9-8 Sekimai Musashino-shi','Tokyo' ,'100 ','Japan' ),
(5 ,'Cooperativa de Quesos Las Cabras' ,'Antonio del Valle Saavedra ','Calle del Rosal 4', 'Oviedo',' 33007',' Spain')
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Union
Select * From Customers
Union
Select * From Suppliers


Select City From Customers
Union 
Select City From Suppliers


Select City From Customers
Union ALL
Select City From Suppliers

Select City,Country From Customers
Where Country = 'USA'
Union
Select City, Country From Suppliers
Where Country= 'USA'
Order By City

Select City,Country From Customers
Where Country = 'USA'
Union ALL
Select City, Country From Suppliers
Where Country= 'USA'
Order By City

----------------------------------------------------------------------------------------------------------------------------
-- Group BY
Select * From Products

Select count(ProductID) 
From Products
Group BY SupplierID

Select * From Customers

Select Count(CustomerID), Country
From Customers
Group BY Country
Order BY Count(CustomerID) DESC

Select Shippers.ShipperName, COUNT(Orders.OrderID) As NumberofOrders
From Orders
Join Shippers 
ON Orders.ShipperID = Shippers.ShipperID
Group BY ShipperName

--------------------------------------------------------------------------------------------------------------------------------------------------
-- Having
Select count(ShipperID)
From Orders
Group BY ShipperID
Having count(ShipperID) > 3


SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 2
ORDER BY COUNT(CustomerID) DESC;
-----------------------------------------------------------------------------------------------------------------------------------------
-- SQL Exsits
/* used to test for the existence of any record in a subquery
Example: Return True and list suppliers with a product price less than 20
*/
Select SupplierName 
From Suppliers
where Exists( Select ProductName 
from Products
Where products.SupplierID = Suppliers.SupplierID and price < 20)

--------------------------------------------------------------------------------------------------------------------
-- Select Into Statement: Copies data from one table into new table

Create Table #Temp_table(         -- #Temp_table is temporary table, talk about it later.
CustomerID int,
CustomerName varchar(50),
ContactName varchar(50),
Address varchar(50),
City varchar(50),
PostalCode varchar(50),
Country varchar(50)
)

Select * Into Temp_table
From Customers

Select  * From Temp_table

-- Insert Into Select: copies data from one table and insert into another table

Insert Into Temp_table
Select * From Customers

Select  * From Temp_table

Drop table Temp_table
---------------------------------------------------------------------------------------------------------------------------------
-- SQL Case Statement

Select ProductName, price,
Case 
When price > 20 Then 'Price is greater than 20'
When price = 20 Then 'Price is 20'
Else 'Price is less than 20'
End As PriceResult
From Products
Order By price


Select CustomerName, City, Country
from Customers
Order BY (Case
When City is Null Then Country
Else City
End)


Select ProductName, price,
Case 
When price >30 Then (Price*1.5)
When price <30 Then (Price * 1.2)
When Price = 30 Then price
Else price
End As NewPrice
From Products
Order By price DESC


-----------------------------------------------------------------------------------------------------------
-- Temporary Table 
/*
Why create temporary table?
- Temporary table will be deleted when current session is terminated
- faster than creating a real table
- useful for complex queries using subsets and joins
*/
	-- Creating temporary table
Create Table #Temp_tab(
id int,
name char(50),
age int
)

Insert Into #Temp_tab values
(1, 'Aayush', 20),
(2, 'Sarjit', 19),
(3, 'John', 21),
(4, 'Bikash', 22),
(5, 'Aakash', 18)

Select * From #Temp_tab
-------------------------------------------------------------------------------------------------------------------------
-- String Function: Trim, Replace, Substring, UPPER, Lower, Concatenate

Select name, Trim(name) as trimname,
LTRIM(NAME) as lefttrim,
RTRIM(name) as righttrim
from #Temp_tab

		
		-- Using Replace
Select name,
REPLACE(name,'-123','Basnet') As NewName
from #Temp_tab

Select name,
REPLACE(name,'Aakash','Hello World') As New_name
from #Temp_tab

		-- Substring

Select CustomerName
From Customers

Select CustomerName,
SUBSTRING(CustomerName,1,5),
Address,
CHARINDEX(',',Address) As char_index,
SUBSTRING(Address,1,CHARINDEX(',',Address)) As char_substring
From Customers


Select Address,
Replace(Address,',','.') As replace_address,
PARSENAME(Replace(Address,',','.'),1) As parse_1,
PARSENAME(Replace(Address,',','.'),2) As parse_2
From Customers

		-- Upper and Lower
Select name,UPPER(name), LOWER(name)
from #Temp_tab

-- Concatenation

Select 
CONCAT(Address, City, Country) As Addresses1,
Address+', '+City+', '+ Country As Addresses2
--Address ||'('|| City||')'||'('|| Country||')' As Addresses3
From Customers

----------------------------------------------------------------------------------------------
-- NULL FUnctions
Select * From Products

Update Products
Set Price = NULL
Where productID = 10

Select price,price*10 as New_Price
from Products


Select price,price + COALESCE(price,10),COALESCE(price,50)
from Products
-- COALESCE return an alternative values if an expression is NULL

---------------------------------------------------------------------------------------------------------------
-- Store Procedure
Select * From Customers

Create Procedure Customer As
Select * From Customers
Go;

EXEC Customer


Create Procedure Customer2 @City nvarchar(50) As
Select * From Customers where City = @City

Exec Customer2 @City='Berlin'

---------------------------------------------------------------------------------------
-- View
Create View view_name As
Select CustomerName 
From Customers

Select * From view_name

Drop view view_name

-------------------------------------------------------------------
-- Alter Table
Alter Table [SQL Tutorial]..Customers
Add Gender varchar(50)  -- Add column Gender in table Customers

Insert Into Customers (Gender) Values
('Male'),
('Female')

Alter Table Customers
Drop Column Gender -- Delete column Gender from table Customers
----------------------------------------------------------------------------
Select * From [SQL Tutorial]..Customers2

Insert Into [SQL Tutorial]..Customers2 values
(1,'Alfreds Futterkiste','Maria Anders', 'Male',47249),
(2,'Ana Trujillo helados','Ana Trujillo', 'Female',37482),
(3,'Anatonio Moreno','Antonio Moreno', 'Male',30893),
(4,'Blauer See Delikatessen','Hanna Moos', 'Male',83947),
(5,'Bon app','Laurence Lebihans', 'Female',57294),
(6,'Comerico Minerio','Pedro Afonso','Female',83743),
(7,'Du Monde entier','Janine Labrune', 'Male',98784)

-- Partition BY

Select CustomerName, Gender, Amount,
Count(Gender) over(partition by Gender) as [Total Gender],
Avg(Amount) over (partition by Gender) as [Avg Salary]
From [SQL Tutorial]..Customers2

-------------------------------WITH Clause-------------------------------------------------------------------------------------------
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


-------------------------------------------
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

-----------------------
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


----------------------------------------
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



-------------------------------------------------------------------------------------------
Drop Table [SQL Tutorial]..Customers

Drop Table [SQL Tutorial]..Customers2

Drop Table [SQL Tutorial]..CustomersB
Select * From  [SQL Tutorial]..CustomersB

Drop Table [SQL Tutorial]..Orders

Drop Table [SQL Tutorial]..Products

Drop Table [SQL Tutorial]..Shippers

Drop Table [SQL Tutorial]..Suppliers

Drop Table [SQL Tutorial]..Temp_table


Drop Database [SQL Tutorial]
----------------------------------------------------------------------------------------
-- End Well

