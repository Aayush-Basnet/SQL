select * from Employee

Select * From EmployeeSalary


Select Emp.EmployeeName, Gender, Salary,
count(Gender) over (Partition By Gender) As [Total Gender]
, Avg(Salary) over (Partition By Gender) As [Average Salary as per Gender]
From Employee As Emp
Join EmployeeSalary As SEMP
ON Emp.EmployeeID = SEMP.EmployeeID



Select Emp.EmployeeName, Gender, count(Gender) As GenderCount
From Employee As Emp
Join EmployeeSalary As SEMP
ON Emp.EmployeeID = SEMP.EmployeeID
Group By Emp.EmployeeName,Gender