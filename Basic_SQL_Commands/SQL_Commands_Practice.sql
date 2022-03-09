-----Welcome to DB Programming-----

-- Creating a database DB_Programming
create database DB_Programming;

exec sp_databases;   --Show all existing databases in shorts


-----------------------------------------------


---UC2 : Ability create a employee payroll table in the payroll service database
CREATE TABLE employee_info 
(
   EmployeeID int identity primary key,
   FirstName varchar(255) Not null,
   LastName varchar(255) Not null,
   Address varchar(255),
   City varchar(255),
   PhoneNumber varchar(50),
   Salary money default 1000,
   StartDate DateTime default GetDate()
);

select * from employee_info;

--drop table employee_info;  --- used to drop a table

-----------------------------------------------------


exec sp_help employee_info;   --- used to show datas of table in details

----- Insert values into database---------

INSERT INTO employee_info (FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate) VALUES
('Shubham', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '8173070519', 400000.00, '2020-01-03'),
('Ravi', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '7860650519', 400000.00, '2020-01-03'),
('Ajay', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '9598650519', 500000.00, '2020-01-03'),
('Shani', 'Seth', 'Kopa Patrahi Jaunpur', 'Jaunpur', '7898650519', 500000.00, '2020-01-03'),
('Pawan', 'Verma', 'DLW', 'Varanasi', '9598650519', 400000.00, GETDATE()),
('Suraj', 'Verma', 'Balrampur', 'Jaunpur', '8798650519', 400000.00, GETDATE()),
('Ashok', 'Singh', 'Durgakund', 'Varanasi', '8798650519', 400000.00, '2020-01-03'),
('Akash', 'Patel', 'Lanka', 'Varanasi', '8898650519', 400000.00, GETDATE()),
('Praveen', 'Patil', 'Azamgarh', 'Azamgarh', '7898650525', 400000.00, GETDATE()),
('Anjali', 'Singh', 'Durgakund', 'Varanasi', '8798650519', 400000.00, GETDATE());


---------------------------------------------------------------------

---------Practice on select command------------

--retrieve all the employee_info data 
select * from employee_info;          --Retrieving Records from Table

select salary from employee_info where FirstName = 'Shubham'; 
select salary from employee_info where FirstName = 'Shani'; 
select * from employee_info
where startDate BETWEEN CAST('2021-01-01' as DATE) AND GETDATE();


--Use Alter Table Command to add Field gender 
Alter Table employee_info add Gender varchar(1);
select *  from employee_info      --Retrieving Records from Table

SELECT TOP 10 * FROM [INFORMATION_SCHEMA].[COLUMNS] WHERE TABLE_NAME='employee_info'; --- show table information


------------Update Command----------------

-- Use Update Query to set the gender using where condition with the employee name.
UPDATE employee_info set Gender = 'M' where FirstName = 'Shubham';   --updating Gender of employees
UPDATE employee_info set Gender = 'M' where LastName = 'Seth' or FirstName = 'Suraj' or FirstName = 'Pawan' or FirstName = 'Ashok';
UPDATE employee_info set Gender = 'F' where FirstName = 'Anjali';   --updating Gender of employees

UPDATE employee_info set salary = 300000.00 where FirstName = 'Praveen'
UPDATE employee_info set salary = 500000.00 where FirstName = 'Anjali'
UPDATE employee_info set salary = 450000.00 where FirstName = 'Pawan'   --updating salary of employees
select *  from employee_info      --Retrieving Records from Table

UPDATE employee_info set FirstName = 'Radha', City = 'Varanasi', Gender= 'F' Where EmployeeID = 7
UPDATE employee_info set FirstName = 'Krishna', Address='Cantt Station Varanasi', City = 'Varanasi', Gender= 'M' Where EmployeeID = 9


----------------Delete Commmand---------------------

Delete from employee_info where FirstName='Akash';    --- Delete a particular row
Delete from employee_info where EmployeeID=10;        --- Delete a particular row
select *  from employee_info                          --- Retrieving Records from Table
