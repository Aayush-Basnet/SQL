/*
Subqueries (in the select, from and where statement)
*/

Select * from EmployeeSalary

-- subquery in select


Select EmployeeID, Salary, (Select Avg(salary) From EmployeeSalary) As AvgSalary
From EmployeeSalary

-- How to do it with Partition By
Select EmployeeID, Salary, Avg(salary) over() As AvgSalary
From EmployeeSalary

-- why Group By doesn't work
Select EmployeeID, Salary, Avg(salary) As AvgSalary
From EmployeeSalary
Group By EmployeeID,Salary
Order By 1,2

-- Subquery in From

Select a.EmployeeID, AvgSalary
From (Select EmployeeID, Salary, Avg(salary) over() As AvgSalary
		From EmployeeSalary) a 

-- Subquery in where
Select EmployeeID, JobTitile, Salary
from EmployeeSalary
Where EmployeeID in ( 
	select  EmployeeID from Employee
	Where Age>30
	)