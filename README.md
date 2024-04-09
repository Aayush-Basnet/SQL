# SQL
Here is where I will keep logs of what I am learning!

---------------------------------------------------------------------------
## Welcome to "SQL-Learning" For Data Analysis!
* In this Git repo, I'll embark on a SQL learning adventure to become a SQL master. Over the next couple of weeks, I'll dive into the world of databases, queires, and data manipulation!
* Get ready to explore SQL fundamentals, tackle complex JOINS, unleash the power of subqueries, and discouver the magic of aggregate functions. With each passing day, I'll levelup my SQL skills.
* Let's make data dance to our tunes!!


# Learning Logs
Days         | Skill learned
----------   | -------------
Day 1-6      | Basic SQL
Day 7-9      | Aggregrate Function
Day 10-17    | Intermediate SQL
Day 18-21    | SQLJoins
Day 22-24    | CASE Statement
Day 25-29    | Common Table Expression
Day 30       | Temporary Tables
Day 31-34    | String Functions
Day 35-36    | Ranking Function
Day 37+      | Advance SQL



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


# DAY 2

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


# DAY 3
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

# Day 4

:large_blue_diamond: SQL SELECT Statement
* The ```SELECT``` Statement is used to select data from database
* FROM is used to specify location of data

```SQL
SELECT column1, column2, ...
FROM table_name
;
```
![alt text]()
:large_blue_diamond: SQL SELECT DISTINCT Statement
The ```SELECT DISTINCT``` Statement is used to return only distinct(different) values

```SQL
SELECT DISTINCT column1, column2, ...
FROM table_name
;
```
![alt text]()

:large_blue_diamond: SQL WHERE Clause
The ```WHERE``` clause is used to filter records. It is used to extract only those records that fulfill specified condition.

```SQL
SELECT column1, column2, ...
FROM table_name
WHERE Contion
;
```
![alt text]()


:large_blue_diamond: COUNT:
COUNT() is a built in function that retrieves the number of rows that matches the query crietaria .
```SQL
SELECT COUNT(*)
FROM table_name
WHERE Condition
;
```
![alt text]()

# Day 5 & 6
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
Example:
```SQL
DELETE From Customer;
```

To delete table completely
Example:
```SQL
DROP TABLE Customer
```

# Day 7
* Today I learn about different SQL Clauses. Here I learn about LIMIT, ORDER BY
SQL Commands   |  Description
---------------|-------------
LIMIT         |The LIMIT clause is used to restrict the number of rows returned by a SELECT statement
ORDER BY         | 	The ORDER BY statement allows us to sort our results using the data in any column.

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
