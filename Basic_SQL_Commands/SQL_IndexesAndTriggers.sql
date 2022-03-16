
-----------------------------------INDEXES---------------------------------------------

/*
Indexes are special data structures associated with tables or views that help speed up the query.
WHAT IS INDEX?
* An index is a pointer to  data in a table.
* An index in a database is very similiar to an index in the back of a book.
* An index helps to speed up SELECT queries and WHERE clauses.
* Indexes can be created or dropped with no effect on the data.

						TYPES OF INDEXES
1) CLUSTERED INDEX:-
	* Each table has only one clustered index because data rows can be only sorted in one order.
	* A clustered index is a special index which physically orders the data according to the indexed columns.
	* The leaf nodes of the index store the data for the rest of the columns in the table.

2) NON-CLUSTERED INDEX:-
	* A table may have one or more non clusterd.
	* A non-clustered index is just like the index of a book.
	* It points back to the actual page that contains the data. (In other words, it points back to the clustered index)
*/

Create Table EmployeesIndex
(
	Id int primary key identity,
	[Name] nvarchar(50),
	Email nvarchar(50),
	Department nvarchar(50)
)

SET NOCOUNT ON
Declare @counter int = 1

While(@counter <= 1000000)
Begin
	Declare @Name nvarchar(50) = 'ABC ' + RTRIM(@counter)
	Declare @Email nvarchar(50) = 'abc' + RTRIM(@counter) + '@startech.com'
	Declare @Dept nvarchar(10) = 'Dept ' + RTRIM(@counter)

	Insert into EmployeesIndex values (@Name, @Email, @Dept)

	Set @counter = @counter +1

	If(@Counter%100000 = 0)
		Print RTRIM(@Counter) + ' rows inserted'
End

----In SQL Server Management Studio click on Include Actual Execution Plan icon and then execute the following query
Select * from EmployeesIndex where Id = 932000

/*
Notice, the operation is Clustered Index Seek, meaning the database engine is using the clustered index on the employee Id 
column to find the employee row with Id = 932000

Number of rows read = 1
Actual number of rows for all executions = 1
Number of rows read, is the number of rows SQL server has to read to produce the query result. 
In our case Employee Id is unique, so we expect 1 row and that is represented by Actual number of rows for all executions.

With the help of the index, SQL server is able to directly read that 1 specific employee row we want. 
Hence, both, Number of rows read and Actual number of rows for all executions is 1.

So the point is, if there are thousands or even millions of records, SQL server can easily and quickly find the data 
we are looking for, provided there is an index that can help the query find data.

----------Clustered Index Scan----------
In this example, there is a clustered index on EmployeeId column, so when we search by employee id, 
SQL Server can easily and quickly find the data we are looking for. What if we serach by Employee name? 
At the moment, there is no index on the Name column, so there is no easy way for sql server to find the data 
we are looking for. SQL server has to read every record in the table which is extremely inefficient 
from performace standpoint. 
Execute the following query with Include Actual Execution Plan turned ON
*/

Select * from EmployeesIndex Where Name = 'ABC 932000'

/*
Notice, the operation is Clustered Index Scan. Since there is no proper index to help this query, 
the database engine has no other choice than to read every record in the table. This is exactly the reason 
why Number of rows read is 1 million, i.e every row in the table

Number of rows read = 1000000
Actual number of rows for all executions = 1

How many rows are we expecting in the result? Well, only one row because there is only one employee whose 
Name = 'ABC 932000'. So, to produce this 1 row as the result, SQL server has to read all the 1 million rows 
from the table because there is no index to help this query. This is called Index Scan and in general, 
Index Scans are bad for performance.
*/

/*	
---------Non-Clustered Index in SQL Server-----------

This is when we create a non-clustered index on the Name column.

In an non-clusterd index we do not have table data. We have key values and row locators.

We created a non-clustered index on the Name column, so the key values, in this case Employee names are sorted 
and stored in alphabetical order.

The row locators at the bottom of the tree contain Employee Names and cluster key of the row. In our example, 
Employee Id is the cluster key.
*/
USE [DB_Programming]
GO
CREATE NONCLUSTERED INDEX IX_EmployeesIndex_Name
ON [dbo].[EmployeesIndex] ([Name])
GO

----Execute the following query again with Include Actual Execution Plan turned ON
Select * from EmployeesIndex Where Name = 'ABC 932000'

/*
						NON CLUSTERED INDEX
* A non-clustered index doesn't sort the physical data inside the table.
* In fact, a non-clustered index is stored at one place and table data is stored in another place.
* This is similar to a textbook where the book content is located in one place and the index is located in another.
* This allows for more than one non-clustered inex per table.

						SQL SERVER UNIQUE INDEX
* A unique index ensures the index key columns do not contain any duplicate values.
* A unique index may consist of one or many columns.
* A unique index can be clustered or non-clustered.

						WHERE TO APPLY INDEX
* Indexes are meant to speed up the performance of a database, so use indexing whenever it significantly improves the 
performance of your database.
* Check query and find reason for slow performance.
* Find column in query which is used frequently for searching.

						DISADVANTAGES OF INDEXING
* In case of update(change in indexed column) and delete a record, the database might need to move the entire row into
row into a new position to keep the rows in sorted order.

*/