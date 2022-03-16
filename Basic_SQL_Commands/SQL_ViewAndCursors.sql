
						/* SQL-Views */
/* 
	In SQL, a view is a virtual table based on the result-set of an SQL statement.
	View does not contain any data.
	The fields in a view are fields from one or more real tables in the database.
	You can add SQL functions, WHERE, and JOIN statements to a view and present the data as if the data 
	were coming from one single table
*/

----- View from single table ------------
select * from employee_info;

CREATE VIEW vwEmployeeInfo
AS
SELECT * from employee_info;

select * from vwEmployeeInfo;

sp_helptext 'vwEmployeeInfo'


----- View from two table ------------

select * from employee_info;
select * from Employees;

CREATE VIEW vwEmployeeMultiTable
AS
Select emi.EmployeeID,emi.FirstName,emi.LastName,emi.City,em.Age,em.Dept_ID
From employee_info emi
JOIN Employees em
on emi.EmployeeID=em.Emp_ID;

select * from vwEmployeeMultiTable;


/*	How to UPDATE the Metadata of a SQL VIEW	*/

select * from employee_info;

CREATE VIEW vwEmployeeInfo
AS
SELECT * from employee_info;

select * from vwEmployeeInfo;

ALTER Table employee_info Add Country Varchar(100)

EXEC sp_refreshview vwEmployeeInfo


/*	How to create Schema Binding SQL VIEW	*/
CREATE VIEW vwEmployeeList
AS
SELECT * from employee_info;

select * from vwEmployeeList;
ALTER Table employee_info Drop Column Country

CREATE VIEW vwEmployeeListWithSchemaBinding
WITH SCHEMABINDING
AS
Select EmployeeID,FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State,JOB_ROLE
from dbo.employee_info	------ Now, No-one can alter our table

ALTER Table employee_info Drop Column JOB_ROLE
ALTER Table employee_info Alter Column City Varchar(100)   ---- Throw an error message


----------------------------------------------------------------------------------------

/*
	WHY TO USE VIEW?
	HIDE THE COMPLEXITY OF QUERY
	ROW LEVEL SECURITY
	COLUMN LEVEL SECURITY
*/
Create View vwRowLevel
AS
SELECT * FROM employee_info Where EmployeeID > 7;

select * from vwRowLevel;

-------- COLUMN LEVEL SECURITY ----------
Create View vwColumnLevel
AS
SELECT FirstName,LastName,Gender,City,Salary FROM employee_info;

select * from vwColumnLevel;

------------------------------------------------------------------------

/*
	UPDATING VIEWS
		* WE CAN USE DML OPERATION ON A SINGLE TABLE ONLY
		* VIEW SHOULD NOT CONTAIN GROUP BY, HAVING, DISTINCT CLAUSES
		* WE CANNOT USE A SUBQUERY IN A VIEW  IN SQL SERVER
		* WE CANNOT USE SET OPERATORS IN A SQL VIEW
	DELETE FROM VIEW
	INSERT INTO VIEW
NOTE:- Data is changed in original table then it shows in View table.
*/

Create View vwDemo
AS 
Select * from employee_info;

Select * from vwDemo

INSERT INTO vwDemo(FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State,JOB_ROLE) Values
	('Sumit','Rawat','Civil Line','Gorakhpur','7845128956',700000,GETDATE(),'M','UP','Snr Developer')

DELETE FROM vwDemo Where EmployeeID=14
UPDATE vwDemo Set LastName='Singh' Where EmployeeID=12;


----------------------------------------------------------------------------------

/*
WITH CHECK OPTION
	It is applicable to a updatable view.
	If the view is not updatable, then there is no meaning of this.
	The WITH CHECK OPTION clause is used to prevent the insertion of rows in the view where the condition in the 
	WHERE Clause in create view statement is not satisfied.
*/

Create View vwCheckOptionDemo
AS
Select * from employee_info where City='Gorakhpur'
WITH CHECK OPTION

Select * from vwCheckOptionDemo

INSERT INTO vwCheckOptionDemo (FirstName,LastName,Address,City,PhoneNumber,Salary,StartDate,Gender,State,JOB_ROLE) Values
	('Anushka','Verma','Civil Line','Gorakhpur','9845128956',400000,GETDATE(),'F','UP','Jnr Developer')


--------------------------------------------------------------------------------------------------------------

				/*	SQL Server CURSOR	*/

/*
What is a database cursor?
A database cursor is an object that enables traversal over the rows of a result set. 
It allows you to process individual row returned by a query.
