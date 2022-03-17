
-------------------------------- FUNCTIONS IN SQL SERVER --------------------------------------------

/*
							FUNCTIONS IN PROGRAMMING
	A function is a block of code that performs a specific task.
	Functions usually "Take in" data, process it, and "return" a result.
	Once a function is written, it can be used over and over again, it means functions can be reused.

							FUNCTIONS IN SQL SERVER
	SQL Server Functions are useful objects in SQL Server databases.
	A function is a set of SQL statements that perform a specific task.
	Functions faster code reusability.
	If you have to repeatedly write large SQL scripts to perform the same task, you can create a function that
	performs that task.
	Next time instead of rewriting the SQL, you can simply call that function.
	A function accepts inputs in the form of parameters and returns a value.

	SQL Server comes with a set of built-in functions that perform a variety of tasks.
	In SQL Server, a function is a STORED PROGRAM that you can pass parameters into and return a value.
	A SQL Server function is a code snippet that can be executed on a SQL Server.
	Ofcourse, you could create a stored procedure to group a set of SQL statements and execute them, however,
	stored procedures cannot be called within SQL statements.
	Therefore, if you are using functions with large data sets, you can hit performance issues.

	In T-SQL, a function is considered an object. Here are some of the rules when creating functions in SQL Server.
	* A function must have a name and a function name can never start with a special character such as @, $, #, and so on.
	* Functions only work with SELECT Statement.
	* Functions can be used anywhere in SQL, like AVG, COUNT, SUM, MIN, DATE and so on with select statements.
	* Functions compile every time.
	* Functions must return a value or result.
	* Functions only work with input parameters.
	* TRY and CATCH statements are not used in functions.

								SQL SERVER FUNCTIONS TYPES
	SQL Server supports two types of functions - user defined and system.
	
	* USER DEFINED FUNCTION: User defined functions are created by a user.

	* SYSTEM DEFINED FUNCTION: System functions are built in database functions.

	There are three types of user-defined functions in SQL Server.
	1. Scalar Functions
	2. Inline Table Valued Functions
	3. Multi-Statement Table Valued Functions

								WHAT ARE SCALER FUNCTIONS	
	SQL Server scalar function takes one or more parameters and returns a single(scalar) value.
	The returned value can be of any data type, except text, ntext, image, cursor and timestamp.

*/

-- Steps To Do:
/* Create a function without Parameter */
CREATE Function ShowMessage()
Returns varchar(100)
AS
BEGIN
	return 'Welcome To Function'
END

Select dbo.ShowMessage();


/* Create a function with a single Parameter */
CREATE Function TakeANumber(@num as int)
Returns int
AS
BEGIN
	return (@num * @num)
END

Select dbo.TakeANumber(5);


/* Create a function with multiple Parameters */
CREATE Function Addition(@num1 as int, @num2 as int)
Returns int
AS
BEGIN
	return (@num1 + @num2)
END

SELECT dbo.Addition(6,5);
SELECT dbo.Addition(4,5);


/* Alter a function */
Alter Function TakeANumber(@num as int)
Returns int
AS
BEGIN
	return (@num * @num * @num)
END

Select dbo.TakeANumber(5);


/* Drop a function */
Drop Function TakeANumber;


/*
								SQL SERVER SCALAR FUNCTION
	The following are some key takeaway of the scalar functions:
	* Scalar functions can be used almost anywhere in T-SQL statements.
	* Scalar functions accept one or more parameters but return only one value, therefore, they must include
	  a RETURN statement.
	* Scalar functions can use logic such as IF blocks or WHILE loops.
	* Scalar functions cannot update data. They can access data but this is not a good practice.
	* Scalar function can call other functions.
*/

------- Scalar functions can use logic such as IF blocks or WHILE loops ----------
Create function CheckVotersAge(@age as int)
returns varchar(100)
AS
BEGIN
	Declare @str varchar(100)
	if @age >= 18
	BEGIN
		set @str = 'You are eligible to Vote'
	END
	else
	BEGIN
		set @str = 'You are not eligible to Vote'
	END
	return @str
END

Select dbo.CheckVotersAge(20)


--------- Scalar function can call other functions ---------------
Create function GetMyDate()
returns DateTime
AS
BEGIN
	return GetDate();
END

Select dbo.GetMyDate();