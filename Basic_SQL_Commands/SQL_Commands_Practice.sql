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
select * from employee_info;