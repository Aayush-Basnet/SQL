
-- Case Statement

Select Age, 
Case 
When Age > 30 Then 'Age is over 30'
When Age = 30 Then 'Age is 30'
Else 'Age is under 30'
End As AgeResult
from Employee

-- Case Statement using Partition By
Select EmployeeName, JobTitile, Salary, Avg(salary) over () As Avg_Salary,
Case
When Salary > Avg(salary) over() Then 'High paying Employee'
When Salary = AVG(salary) Over() Then 'Average paying Employee'
Else 'Lower paying Employee'
End As Avg_salaryResult
From EmployeeSalary

-- Case Statement using JOIN
Select Emp.EmployeeName, Sal.JobTitile ,Sal.Salary,
Case
When JobTitile = 'Sales Executive' Then (Salary * 0.1)
When JobTitile = 'Data Analytic' Then (Salary * 0.08)
Else (Salary * 0.05)
End As Bonus
From Employee As Emp
Join EmployeeSalary As Sal
on Emp.EmployeeID = Sal.EmployeeID
order by Bonus desc


