# SQL
Here is where I will keep logs of what I am learning!

---------------------------------------------------------------------------
## Welcome to "SQL-Learning" For Data Analysis!
* In this Git repo, I'll embark on a SQL learning adventure to become a SQL master. Over the next couple of weeks, I'll dive into the world of databases, queires, and data manipulation!
* Get ready to explore SQL fundamentals, tackle complex JOINS, unleash the power of subqueries, and discouver the magic of aggregate functions. With each passing day, I'll levelup my SQL skills.
* Let's make data dance to our tunes!!


# Learning Logs
Days         | Skill learned  | Topic Content
----------   | -------------  | -------------
Day 1-7      | Basic SQL      | SQL, DBMS, SQL Commands, DDL, DML
Day 8-9      | Aggregrate Function, LIKE & Wildcards, Aliases  | AVG, MIN, MAX, SUM, COUNT,AS, IN, TOP, LIKEr
Day 10-12    | SQL Joins  | Inner Join, Outer Join, Left/Right Join ,Self Join
Day 13-16    | Intermediate SQL  | UNION, GROUP BY, HAVING, EXISTS, PARTITION BY
Day 22-24    | CASE Statement  | CASE
Day 25-29    | Common Table Expression  | CTE
Day 30       | Temporary Tables   |
Day 31-34    | String Functions  | UPPER, LOWER, SUBSTRING, CONCAT, TRIM
Day 35-36    | Window Function  | RANK, DENSE RANK, ROW NUMBER, LEAD/LAG
Day 37+      | Advance SQL  | PARTITION BY, Store Procedure, View, Temp Table
SQL Project  | [Project](https://github.com/Aayush-Basnet/SQL/tree/main/SQL%20Project)

---------------------------------------------------------------------------------------------------------------------

| SQL Projects  |    
| ---------------- |
| [COVID-19 Data Exploration](https://github.com/Aayush-Basnet/SQL/blob/main/SQL%20Project/Covid%20Exploration%20Project.sql)   |
| [Nashville Housing Data Cleaning](https://github.com/Aayush-Basnet/SQL/blob/main/SQL%20Project/Nashville%20Housing%20Data%20Cleaning.sql)   |
| [SQL Murder Mystery Game](https://github.com/Aayush-Basnet/SQL/blob/main/SQL%20Project/SQL-Murder-Mystery.sql)  |
| [Company Layoffs](https://github.com/Aayush-Basnet/SQL/blob/main/SQL%20Data%20Cleaning.sql)   |
| [Adidas Sales Analysis](https://github.com/Aayush-Basnet/SQL/blob/main/SQL%20Project/Adidas%20Sales%20Analysis.sql)|

---------------------------------------------------------------------------------------------------------------------------------------------
# DAY 1 of 'Learning SQL'


### What is SQL?
  SQL (Structured Query Language) is a standard language for accessing and manipulating database. SQL Lets you access and manipulate database.
  Although SQL is an ANSI/ISO standard, there are different versions of the SQL language. However, to be compliant with ANSI standard, they all support at least the major commands (such as SELECT, UPDATE, DELETE, INSERT, WHERE) in a similar manners.

What can SQL do? 
* Insert, update, delete record from database
* Create new database
* Create new tables in a database
* Execute queries against a database
* Retrieve data from database

## Database Management System (DBMS)
  * DBMS is a collection of program that enables you to enter the data to the database, organize the data in the database and select data from the database.
  * DBMS manages the process of storing and retrieving data as well as providing users access to the database,
## DBMS Software
Oracle, SQ Lite, MicroSoft SQL, IBM DB, MySQL, PostgreSQL, Hadoop HDF


SQL   |  Description    | Commands
----- |---------------- |------------
Data Definition Language (DDL) | DDL commands are used to define and manage the structure of the database, including tables, views, indexes, and constraints. |CREATE, ALTER, DROP, TRUNCATE, RENAME
Data Manipulation Language (DML) |DML commands are used to manipulate and retrieve data within the database. | SELECT, INSERT, UPDATE, DELETE.


* Today I learn about SQL syntax used during data analysis.
SQL statement consists of keyworks.
  Some of the most important SQL commands
  *	SELECT – Extracts data from database
  *	UPDATE – update data in a database
  *	DELETE – delete data from a database
  *	INSERT INTO – Insert new data into a database
  *	CREATE DATABASE – creates a database
  *	ALTER DATABASE – modifies a database
  *	CREATE TABLE – creates a new table
  *	ALTER TABLE – modifies a table
  *	DROP TABLE – delete a table
  *	CREATE INDEX – creates an index (search key)
  *	DROP INDEX – deletes an index



### Data Definition Language 
SQL Commands   |  Description
---------------|-------------
CREATE         |This command is used to create the database or its objects (like table, index, function, views, store procedure, and triggers)
ALTER         | 	This is used to alter the structure of the database.
DROP          | This command is used to delete objects from the database.
TRUNCATE      | This is used to remove all records from a table, including all spaces allocated for the records are removed.


# DAY 2
###  CREATE Table
It is used to create table in a database.
syntax:
```SQL
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    column3 datatype,
   ....
);
```
  ![alt text](https://github.com/Aayush-Basnet/SQL/blob/9cb0d5125b0ba59938389be6d92adc5366d771c7/Asset/Create%20Table.png)


###  ALTER Table
It is used to add or remove columns,keys,constraints and modify the data types of columns.<br>
Syntax:
```SQL  
ALTER TABLE table_name
ADD column_name datatype;
```
  ![alt text](https://github.com/Aayush-Basnet/SQL/blob/9cb0d5125b0ba59938389be6d92adc5366d771c7/Asset/Alter%20Table.png)
###  DROP Table
It is used to drop existing table from the databases.
<br>
Syntax:
```SQL
DROP TABLE table_name;
```
  ![alt text](https://github.com/Aayush-Basnet/SQL/blob/9cb0d5125b0ba59938389be6d92adc5366d771c7/Asset/Drop%20Table.png)
###  TRUNCATE Table
It is used to delete the data inside the table but not the table itself.
<br>
Syntax:
```SQL
TRUNCATE TABLE table_name;
```
  ![alt text](https://github.com/Aayush-Basnet/SQL/blob/9cb0d5125b0ba59938389be6d92adc5366d771c7/Asset/Truncate%20Table.png)

# Day 3

:large_blue_diamond: SQL SELECT Statement
* The ```SELECT``` Statement is used to select data from database
* FROM is used to specify location of data

```SQL
SELECT column1, column2, ...
FROM table_name
;
```
Example:
```SQL
SELECT *
FROM Customer
```

:large_blue_diamond: SQL SELECT DISTINCT Statement
The ```SELECT DISTINCT``` Statement is used to return only distinct(different) values

```SQL
SELECT DISTINCT column1, column2, ...
FROM table_name
;
```
```SQL
SELECT DISTINCT CustomerName
FROM Customer
// Ignore duplicate name
;
```

:large_blue_diamond: SQL WHERE Clause
The ```WHERE``` clause is used to filter records. It is used to extract only those records that fulfill specified condition.

```SQL
SELECT column1, column2, ...
FROM table_name
WHERE Contion
;
```

Example
```SQL
SELECT *
FROM Customer
WHERE Country = 'Mexico'
;
```



# Day 4 & 5
* Today I learn about the Data Manipulation Languages and it's commands


## SQL INSERT

SQL Commands   |  Description
---------------|-------------
SELECT         |Retrieves data from one or more tables based on specified conditions
INSERT         | 	Inserts new data into a table.
DELETE          | Deletes data from a table based on specified conditions.
UPDATE      | Modifies existing data in a table.


## SQL INSERT 
```INSERT INTO``` Statement is used to insert new records in a table
Syntax:
```SQL
INSERT INTO table_name (column1, column2, column3, ...)
VALUES (value1.1, value1.2, value1.3, ...),
(value2.1, value2.2, value2.3, ...)
;
```

```SQL
INSERT INTO table_name VALUES
VALUES (value1.1, value1.2, value1.3, ...),
(value2.1, value2.2, value2.3, ...)
;
```

Example:
```SQL
Insert Into Customers values
(1,'Alfreds Futterkiste','Maria Anders','Berlin','12209','German'),
(2,'Ana Trujillo','Ana Trujillo', 'Tokyo','13235','Japan'),
```

## SQL UPDATE
```UPDATE``` Statement is used to modify the existing records in a table
Syntax:
```SQL
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

Example:
```SQL
UPDATE Customer
SET Country  = 'Mexico'
WHERE CustomerID = 1;
```
## SQL DELETE
```DELETE``` Statement is used to delete existing records from a table.

Syntax:
```SQL
DELETE FROM table_name WHERE condition;
```
Example:
```SQL
DELETE FROM Customer
WHERE Country = 'Brazil';
```

Deleting all records from table
```SQL
DELETE From Customer;
```

To delete table completely
```SQL
DROP TABLE Customer
```

# Day 6 & 7

SQL Commands   |  Description
-------------- | -------------
LIMIT          | The LIMIT clause is used to restrict the number of rows returned by a SELECT statement
ORDER BY       | The ORDER BY statement allows us to sort our results using the data in any column
Operators      | Operators are used to give result based on condition applied


:large_blue_diamond:LIMIT: 
LIMIT is used for restricting the number of rows retrieved from databases.
Example:
```SQL
Retrieve only 10 rows of data from Customer

SELECT * FROM Customer
LIMIT 10
```
## SQL ORDER BY
```ORDER BY``` Statement is used to sort the result-set in ascending or descending order

syntax:
```SQL
SELECT Column1, Column2,......
FROM table_name
WHERE Condition
ORDER BY Column1, Column2,...
;

```

Example:
```SQL
SELECT *
FROM orders
ORDER BY price DESC 
;
// Result are ordered in descending order
```

# SQL Operators
Operators      |  Sign
---------------|-------------
Arithmetric    | +,-,/,*
Logical        | OR, AND, NOT
Comparision    | =, <=,>= <>,!=

## SQL AND
```AND``` operator is used to filter records based on more than one condition. ```AND``` operator display a record if all condition are TRUE.
syntax:
```SQL
SELECT Column1, Column2,......
FROM table_name
WHERE Condition1 AND Condition2........
;
```

Example:
```SQL
SELECT *
FROM Customer
WHERE Country = 'Germany' AND City = 'Berlin'
;
```

## SQL OR
```OR``` operator is used to filter records based on more than one condition.  ```OR``` operator display a record if any of condition are TRUE.
syntax:
```SQL
SELECT Column1, Column2,......
FROM table_name
WHERE Condition1 OR Condition2........
;
```

Example:
```SQL
SELECT *
FROM Customer
WHERE Country = 'Germany' OR City = 'Tokyo'
;
```
## SQL NOT
```NOT``` operator is used in combination with other operators to give opposite result i.e. negative result. 
syntax:
```SQL
SELECT Column1, Column2,......
FROM table_name
WHERE NOT Condition
;
```

Example:
```SQL
SELECT *
FROM Customer
WHERE NOT Country  = 'Germany' 
;
```

```SQL
SELECT *
FROM Customer
WHERE Country NOT IN  ('Germany','Brazil') 
;
```

```SQL
SELECT *
FROM Customer
WHERE NOT price > 1500
;
```
We can use operators like  =, <=,>= <>,!= to filter the search.
The following operators can be used in WHERE Clause
Example:
```SQL
SELECT *
FROM Customer
WHERE CustomerID Between 10 AND 20  // Between is used to determine certain range of values
;


SELECT *
FROM Customer
WHERE City LIKE 's%'  // City name that started by S
; 
```

# Day 8

:large_blue_diamond: COUNT:
COUNT() is a built in function that retrieves the number of rows that matches the query crietaria .
```SQL
SELECT COUNT(column_name)
FROM table_name
WHERE Condition
;
```
Example:
```SQL
SELECT COUNT(*)
FROM Customer
;

// Ignore Dupicate
SELECT COUNT(DISTINCT price)
FROM order
;
```

## SQL MIN 
```MIN()``` return smallest value of selected column
syntax:
```SQL
SELECT MIN(column_name)
FROM table_name
WHERE Condition
;
```

Example
```SQL
SELECT MIN(price)
FROM Order

;
```

## SQL MAX 
```MAX()``` return largest value of selected column
syntax:
```SQL
SELECT MAX(column_name)
FROM table_name
WHERE Condition
;
```

Example
```SQL
SELECT MAX(price)
FROM Order
;
```

## SQL SUM
```SUM()``` function returns total sum of numeric column
syntax:
```SQL
SELECT SUM(column_name)
FROM table_name
WHERE Condition
;
```

Example
```SQL
SELECT SUM(price)
FROM Order
;

SELECT SUM(price* quantity) As total_sum
From Orders
// As is Alias which gives temporary name to column
```

## SQL AVG
```SUM()``` function returns the average value
syntax:
```SQL
SELECT AVG(column_name)
FROM table_name
WHERE Condition;
```

Example
```SQL
SELECT AVG(price)
FROM Order;
```

# Day 9

:large_blue_diamond: SQL NULL Values
A field with ```NULL Values``` is a field with no value. We will have to use ```IS NULL``` or  ```IS NOT NULL``` operator
syntax:
```SQL
SELECT column_name
FROM table_name
WHERE column_name IS NULL
;
```

:large_blue_diamond: SQL SELECT TOP
The ```SELECT TOP``` clause is used to specify the number of records to return
Example:
```SQL
// Select only first 3 records of Customer
SELECT TOP 3 *
FROM Customer;

// SQL TOP Percent
Select Top 50 PERCENT
FROM Customer;

```
Note: Not all database system support the ```SELECT TOP``` clause. MYSQL support ```LIMIT```, while ORACLE use FETCH FIRST n Rows only and ROWNUM 

:large_blue_diamond: SQL Aliases
An ```Alias``` is creates with ```AS``` keyword. It is used to give temporary name to columns
Example
```SQL
SELECT AVG(price) AS average_price
FROM Order;
```
When Joining two tables
```SQL
SELECT o.orderID, o.orderDate, c.CustomerName
FROM Customer c,
order o
WHERE c.customerName ='ABC' AND C.customerID = o.CustomerID;
```

:large_blue_diamond: SQL IN 
```IN``` operator allows you to specify multiple values in WHERE clause
syntax
```SQL
SELECT column1, column2,.....
FROM table_name
WHERE column_name IN (value1, value2,.......)
```
Example
```SQL
SELECT *
FROM Customers
WHERE Country IN ('France','Brazil');
```

## SQL LIKE & WILDCARDS
```LIKE``` operator is used in a WHERE clause to search for a specified pattern in a column
syntax
```SQL
SELECT column1, column2,.....
FROM table_name
WHERE column LIKE pattern;
```
The Wildcards
```_Wildcard``` represent a single character
Example
```SQL
SELECT *
FROM Customer
WHERE City LIKE 'L_nd_n';
// It display values where city is London
```
The % Wildcard represent any number of characters, even characters.
```SQL
SELECT *
FROM Customer
WHERE City LIKE '%L%';
// It display values where city contain letter L. Example: London, Berlin, Marseille

// Select all customers that ends with 'a'
SELECT *
FROM Customer
WHERE Customer_Name LIKE '%a';

// Return all customers that starts with 'a' and are atleast 3 character in length
SELECT *
FROM Customer
WHERE Customer_Name LIKE 'a___%';

// Return all customers starting with either 'b', 's', or 'p'
SELECT *
FROM Customer
WHERE Customer_Name LIKE '[bsp]%';

// Return all customers starting with 'a','b','c','d', 'e', or 'f'
SELECT *
FROM Customer
WHERE Customer_Name LIKE '[a-f]%';
```

# DAY 10
## SQL JOINS
```JOIN``` clause is used to combine rows from two or more tables, based on related column between them.

Example
```SQL
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers ON Orders.CustomerID=Customers.CustomerID;
```
![alt text](https://github.com/Aayush-Basnet/SQL/blob/504323f7cbd460e309c9f6621190641951402805/Asset/Screenshot%202024-04-10%20164630.png)

Here are the differetn types of JOINS in SQL:
* ```INNER JOIN```: Returns records that have matching values in both tables
* ```LEFT (OUTER) JOIN``` : Returns all records from the left table, and the matched records from the right table
* ```RIGHT (OUTER) JOIN``` : Returns all records from the right table, and the matched records from the left table
* ```FULL(OUTER) JOIN``` : Returns all records when there is a match in either left or right table

:large_blue_diamond: INNER JOIN
```INNER JOIN``` keyword selects records that have matching values in both tables.
Syntax
```SQL
SELECT column_name(s)
FROM table1
INNER JOIN table2
ON table1.column_name = table2.column_name;
```

Example:
```SQL
SELECT ProductID, ProductName, CategoryName
FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID;

Note: The ```INNER JOIN``` keyword returns only rows with a match in both tables. Which means that if you have a product with no CategoryID, or with a CategoryID that is not present in the Categories table, that record would not be returned in the result.
```
## JOIN or INNER JOIN
```JOIN``` and ```INNER JOIN``` will return the same result. ```INNER``` is default join type for ```JOIN```, so when you write ```JOIN``` the parser actually writes ```INNER JOIN```.

## JOIN Three Tables
Example:
```SQL
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);
```
# DAY 11
:large_blue_diamond: LEFT JOIN
```LEFT JOIN``` keyword selects records all records from the left table (table1) and matching records from the right table (table2). The result is 0 records from the right side, if there is no match.
Syntax:
```SQL
SELECT column_name(s)
FROM table1
LEFT JOIN table2
ON table1.column_name = table2.column_name;
```
Example:
```SQL
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;

Note: The ```LEFT JOIN``` keyword returns all records from the left table (Customers), even if there are no matches in the right table (Orders).
```

:large_blue_diamond: RIGHT JOIN
```RIGHT JOIN``` keyword selects records all records from the right table (table2) and matching records from the left table (table1). The result is 0 records from the left side, if there is no match.
Syntax:
```SQL
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;
```
Example:
```SQL
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
ORDER BY Orders.OrderID;

Note: The ```RIGHT JOIN``` keyword returns all records from the right table (Employees), even if there are no matches in the left table (Orders).
```

# DAY 12
:large_blue_diamond: SQL FULL OUTER JOIN
```FULL OUTER JOIN``` keyword selects records all records all records when there is a match in left (table1) or right(table2) table records.

Syntax:
```SQL
SELECT column_name(s)
FROM table1
FULL OUTER JOIN table2
ON table1.column_name = table2.column_name
WHERE condition;
```
Example:
```SQL
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID
ORDER BY Customers.CustomerName;
```

:large_blue_diamond: SQL Self JOIN
```Self JOIN``` is a regular join, but the table is joined with itself.

Syntax:
```SQL
SELECT column_name(s)
FROM table1 T1, table1 T2
WHERE condition;
```
Example:
```SQL
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;
```

# Day 13 & 14
## SQL UNION Operator
The ```UNION``` operator is used to combine the result set of two or more ```SELECT``` statement.
* Every ```SELECT``` statement with ```UNION``` must have the same number of columns.
* The columns must also have similar data types.
* The columns in every ```SELECT``` statement must also be in same order.

Note: To allow duplicate values, use UNION ALL
Syntax:
```SQL
SELECT column_name(s)
FROM table1 T1
UNION
SELECT column_name(s);
```
Example:
```SQL
SELECT City, Country
FROM Customers
Where Country = 'Germany'
UNION
SELECT City, Country
FROM Suppliers
Where Country = 'Germany'
ORDER BY City;
```

## GROUP BY
The ```GROUP BY``` statement groups rows that have same values into summary rows, like 'find the number of customers in each country'.
The ```GROUP BY``` statement is often used with aggregate functions (```COUNT()```,```MAX()```,```MIN()```,```SUM()```,```AVG()```) to group the result-set by one or more columns.
Syntax:
```SQL
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
ORDER BY column_name(s);
```

Example:
```SQL
SELECT COUNT(CustomerID), Country
FROM Customers
GROUP BY Country
ORDER BY COUNT(CustomerID) DESC;
```

### GROUP BY With JOIN 
Example:
```SQL
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;;
```
# SQL HAVING Clause
The ```HAVING``` clause was added to SQL because the ```WHERE``` keyword cannot be used with aggregate functions.
Syntax:
```SQL
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);
```

Example:
```SQL
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders
FROM (Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID)
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;
```
