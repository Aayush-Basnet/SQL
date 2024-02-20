/*

String Functions - TRIM, LTRIM, RTRIM, Replace, Substring, Upper, Lower

*/
-- Drop Table EmployeeErrors

CREATE TABLE EmployeeErrors(
EmployeeID varchar(50),
EmployeeName varchar(50)
)
Insert Into EmployeeErrors values 
('1001','Jimbo Halbert'),
('1002','Pamela Beasely'),
('1005', 'Toby Flendrson-Fired')

update EmployeeErrors
set EmployeeID= '  1002  '
where EmployeeName = 'Pamela Beasely';

Select * from EmployeeErrors

--Using Trim, Left-Trim, Right-Trim
Select EmployeeID, Trim(EmployeeID) As TrimID
from EmployeeErrors

Select EmployeeID, LTrim(EmployeeID) As LTrimID
from EmployeeErrors

Select EmployeeID, RTrim(EmployeeID) As RTrimID
from EmployeeErrors

--Using Replace
Select EmployeeName, REPLACE(EmployeeName, '-Fired','')
from EmployeeErrors

-- Using Substring
-- Buzzy match
Select SUBSTRING(EmployeeName,3,3)
from EmployeeErrors

Select Err.EmployeeName,substring(Err.EmployeeName,2,3),Emp.EmployeeName, substring(Emp.EmployeeName,2,3)
from EmployeeErrors As Err
Join [SQL Tutorial].dbo.Employee As Emp
on substring(Err.EmployeeName,2,3)= substring(Emp.EmployeeName,2,3)


-- Using UPPER and LOWER
Select EmployeeName, upper(EmployeeName) AS UpperName
from EmployeeErrors

Select EmployeeName, LOWER(EmployeeName) As LowerName
from EmployeeErrors

-- CONCAT() returns concatenated string
SELECT CONCAT('abc','def');

SELECT CONCAT('abc',' ','def');

-- LEFT() returns the leftmost number of characters as specified
SELECT LEFT('asdfhgl',4)

-- RIGHT() returns the rightmost number of characters as specified
SELECT Right('asdfhgl',4)

-- Length() returns the length of a string
Select LEN('adfghgf')


-- Reverse() reverse the order of characters in a string
Select REVERSE('apple')
