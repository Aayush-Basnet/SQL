
/*
-- Stored Procedures
stored Procedures is a group of sql statements that has ben created and stored in that database.
Stored Procedures can accept input parameters, that means single store procedure can be used over the network by several different users.
Stored procedure also reduce network traffic and increase performance

*/


 Select * From Customers
 ---------------------------------------------------
Create Procedure AllCustomers As
Select * From Customers
GO;

EXEC AllCustomers
-----------------------------------------
-- Stored Procedure with one parameter
-- It returns data of customer where city = London
CREATE PROCEDURE SelectAllCustomers @City nvarchar(30)
AS
SELECT * FROM Customers WHERE City = @City
GO;

EXEC SelectAllCustomers @City = 'London'

-------------------------------
-- Stored Procedure with multiplie Parameters

Create Procedure SelectAllCustomers2 @City nvarchar(20), @PostalCode nvarchar(20) As
Select * From Customers Where City = @City AND PostalCode = @PostalCode
GO;

Exec SelectAllCustomers2 @City = 'London' , @PostalCode='AB-538233'