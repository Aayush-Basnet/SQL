 
 -- Temp Tables

 create table #temp_employeeinfo(
 EmployeeID int,
 EmployeeName varchar(50),
 JobTitile varchar(50),
 Salary int)

 select * from #temp_employeeinfo

 Insert Into #temp_employeeinfo values 
 (1001, 'Aayush', 'Executive', 70000)

 Insert Into #temp_employeeinfo
 select * from EmployeeSalary

 Delete from #temp_employeeinfo
 where EmployeeName = 'Aayush'


 Create table #Temp_Employee2(
 JobTitile varchar(50),
 EmployeePerSalary int,
 AvgAge Int,
 AvgSalary int)

 Insert into #Temp_Employee2
 SELECT JobTitile, COUNT(Jobtitile), avg(age), avg(salary)
 from Employee
 join EmployeeSalary 
 on Employee.EmployeeID = EmployeeSalary.EmployeeID
 group by JobTitile

 select * from #Temp_Employee2