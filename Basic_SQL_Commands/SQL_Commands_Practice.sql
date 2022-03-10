-----Welcome to DB Programming-----

-- Creating a database DB_Programming
create database DB_Programming;

exec sp_databases;   --Show all existing databases in shorts


-----------------------------------------------


---Ability create a employee info table in the DB_Programming database
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
Alter Table employee_info add State varchar(255);
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

UPDATE employee_info set State = 'UP' Where City = 'Varanasi'
UPDATE employee_info set State = 'MP' Where City = 'Jaunpur'


----------------Delete Commmand---------------------

Delete from employee_info where FirstName='Akash';    --- Delete a particular row
Delete from employee_info where EmployeeID=10;        --- Delete a particular row
select *  from employee_info                          --- Retrieving Records from Table

---------------Order By, Group By and Having Clause--------------

SELECT * FROM employee_info;
SELECT * FROM employee_info WHERE City='Varanasi';
SELECT * FROM employee_info WHERE City='Varanasi' Order By FirstName;
SELECT City, COUNT (*) FROM employee_info WHERE State = 'UP' Group By City Order By City;
SELECT City, COUNT (*) FROM employee_info WHERE State = 'MP' Group By City Order By City;
SELECT City, COUNT (*) FROM employee_info WHERE State = 'MP' Group By City HAVING COUNT (*) > 4 Order By City;


---------------Order By Clause in Details--------------

--When you use the SELECT statement to query data from a table, the order of rows in the result set is not guaranteed. 
--It means that SQL Server can return a result set with an unspecified order of rows.
--The only way for you to guarantee that the rows in the result set are sorted is to use the ORDER BY clause

--The ASC sorts the result from the lowest value to the highest value while the DESC sorts the result set from the highest value to the lowest one.
--If you don’t explicitly specify ASC or DESC, SQL Server uses ASC as the default sort order. Also, SQL Server treats NULL as the lowest value.
--When processing the SELECT statement that has an ORDER BY clause, the ORDER BY clause is the very last clause to be processed.

--A) Sort a result set by one column in ascending order
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
    FirstName;

--B) Sort a result set by one column in descending order
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
    FirstName DESC;

--C) Sort a result set by multiple columns
SELECT
    FirstName,
    LastName,
	City
FROM
    employee_info
ORDER BY
	City,
    FirstName;

--D) Sort a result set by multiple columns and different orders
SELECT
    FirstName,
    LastName,
	City
FROM
    employee_info
ORDER BY
	City DESC,
    FirstName ASC;

--E) Sort a result set by a column that is not in the select list
--It is possible to sort the result set by a column that does not appear on the select list. 
--For example, the following statement sorts the employee by the state even though the state column does not appear on the select list.
SELECT
    FirstName,
    LastName,
	City
FROM
    employee_info
ORDER BY
	State;

--F) Sort a result set by an expression
--The LEN() function returns the number of characters of a string. 
--The following statement uses the LEN() function in the ORDER BY clause to retrieve a employee list sorted by the length of the first name.
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LEN(FirstName) DESC;

--G) Sort by ordinal positions of columns
--SQL Server allows you to sort the result set based on the ordinal positions of columns that appear in the select list.
--The following statement sorts the employees by first name and last name. But instead of specifying the column names explicitly, 
--it uses the ordinal positions of the columns:
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	1,
	2;

--In this example, 1 means the FirstName column and 2 means the LastName column.


----------------------------------------------------------------------------------------

INSERT INTO employee_info (FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State) VALUES
('Sonali', 'Baranwal', 'Raj Nagar', 'Ghaziabad', '9873070519', 600000.00, '2019-01-03','F','UP'),
('Monika', 'Sharma', 'Vaishali', 'Ghaziabad', '7860650519', 700000.00, '2019-01-03','F','UP'),
('Rohit', 'Sharma', 'Wahnkhede', 'Mumbai', '9598650519', 800000.00, '2020-01-03','M','Maharashtra'),
('Subhash', 'Verma', 'Pune', 'Pune', '7898650519', 700000.00, '2020-01-03','M','Maharashtra');

select * from employee_info;
-------------------------SQL Server OFFSET FETCH----------------------

--Summary: in this tutorial, you will learn how to use the SQL Server OFFSET FETCH clauses to limit the number of rows returned by a query.
--The OFFSET and FETCH clauses are the options of the ORDER BY clause. They allow you to limit the number of rows to be returned by a query.

--The following illustrates the syntax of the OFFSET and FETCH clauses:

----ORDER BY column_list [ASC |DESC]
----OFFSET offset_row_count {ROW | ROWS}
----FETCH {FIRST | NEXT} fetch_row_count {ROW | ROWS} ONLY
----Code language: SQL (Structured Query Language) (sql)
----In this syntax:

--The OFFSET clause specifies the number of rows to skip before starting to return rows from the query. 
--The offset_row_count can be a constant, variable, or parameter that is greater or equal to zero.

--The FETCH clause specifies the number of rows to return after the OFFSET clause has been processed. 
--The offset_row_count can a constant, variable or scalar that is greater or equal to one.

--The OFFSET clause is mandatory while the FETCH clause is optional. Also, the FIRST and NEXT are synonyms respectively 
--so you can use them interchangeably.
--Note that you must use the OFFSET and FETCH clauses with the ORDER BY clause. Otherwise, you will get an error.

SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LastName,
    FirstName;

--To skip the first 5 Name and return the rest, you use the OFFSET clause as shown in the following statement:
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LastName,
    FirstName
OFFSET 5 ROWS;

--To skip the first 4 employees and select the next 3 products, you use both OFFSET and FETCH clauses as follows:
SELECT
    FirstName,
    LastName
FROM
    employee_info
ORDER BY
	LastName,
    FirstName
OFFSET 4 ROWS
FETCH NEXT 3 ROWS ONLY;

--To get the top 7 highest paid employees we can use both OFFSET and FETCH clauses:
SELECT
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC,
	FirstName ASC
OFFSET 0 ROWS
FETCH NEXT 7 ROWS ONLY;

select * from employee_info;


-----------Introduction to SQL Server SELECT TOP
--The SELECT TOP clause allows you to limit the number of rows or percentage of rows returned in a query result set.
--Because the order of rows stored in a table is unspecified, the SELECT TOP statement is always used in conjunction with the ORDER BY clause. 
--Therefore, the result set is limited to the first N number of ordered rows.

----WITH TIES
--The WITH TIES allows you to return more rows with values that match the last row in the limited result set. 
--Note that WITH TIES may cause more rows to be returned than you specify in the expression.

--For example, if you want to return the most expensive products, you can use the TOP 1. 
--However, if two or more products have the same prices as the most expensive product, then you miss the other most expensive products in the result set.

--To avoid this, you can use TOP 1 WITH TIES. It will include not only the first expensive product but also the second one, and so on.
--1) Using TOP with a constant value
SELECT TOP 5
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC,
	FirstName ASC
select * from employee_info;

--2) Using TOP to return a percentage of rows
SELECT TOP 30 PERCENT
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC,
	FirstName ASC
select * from employee_info;

--3) Using TOP WITH TIES to include rows that match the values in the last row
SELECT TOP 2 WITH TIES
    FirstName,
    LastName,
	Salary
FROM
    employee_info
ORDER BY
	Salary DESC
select * from employee_info;


---------------------------------------------------------------------------------------


----------SQL Server SELECT DISTINCT clause------------------
--Sometimes, you may want to get only distinct values in a specified column of a table. 
--To do this, you use the SELECT DISTINCT clause as follows:

--A) DISTINCT one column example
SELECT DISTINCT
    City
FROM
    employee_info
ORDER BY
    City;
--The query returns a distinct value for each group of duplicates. 
--In other words, it removed all duplicate cities from the result set.


--B) DISTINCT multiple columns example
--This statement returns distinct cities and states of all employees:
SELECT DISTINCT
    City,
	State
FROM
    employee_info


--C) DISTINCT with null values example
INSERT INTO employee_info (FirstName,LastName,Address,City,Salary,StartDate,Gender,State) VALUES
('Ankur', 'Yadav', 'Patna', 'Patna', 800000.00, '2020-01-03','M','Bihar'),
('Chadrawali', 'Yadav', 'Patna', 'Patna', 700000.00, '2020-01-03','F','Bihar');

--The following example finds the distinct phone numbers of the employees:
SELECT DISTINCT
    PhoneNumber
FROM
    employee_info
ORDER BY
    PhoneNumber;
select * from employee_info;
--In this example, the DISTINCT clause kept only one NULL in the phone column and removed the other NULLs.


------DISTINCT vs. GROUP BY------
--The following statement uses the GROUP BY clause to return distinct cities together 
--with state and zip code from the employee_info table:
SELECT 
	City, 
	State
FROM 
	employee_info
GROUP BY 
	City, State
ORDER BY
	City, State

--It is equivalent to the following query that uses the DISTINCT operator :
SELECT DISTINCT 
	City, 
	State
FROM 
	employee_info;

--Both DISTINCT and GROUP BY clause reduces the number of returned rows in the result set by removing the duplicates.
--However, you should use the GROUP BY clause when you want to apply an aggregate function on one or more columns.


------------------------SQL Server WHERE clause------------------------


--In the WHERE clause, you specify a search condition to filter rows returned by the FROM clause. 
--The WHERE clause only returns the rows that cause the search condition to evaluate to TRUE.
--The search condition is a logical expression or a combination of multiple logical expressions. 
--In SQL, a logical expression is often called a predicate.

--A) Finding rows by using a simple equality
SELECT
    FirstName,
    LastName,
    Salary,
    Gender,
    City
	State
FROM
    employee_info
WHERE
    State='UP'
ORDER BY
    Salary;

--B) Finding rows that meet two conditions
SELECT
    FirstName,
    LastName,
    Salary,
    Gender,
    City
	State
FROM
    employee_info
WHERE
    State='UP' AND Gender='M'
ORDER BY
    Salary;