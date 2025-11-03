/*  STRING FUNCTION   */

--TASK:Convert the customer's first name to lower case
USE MyDatabase;
SELECT
first_name,
LOWER(first_name) AS low_name
FROM customers;

--TASK:Transform the customer's first name to upper case
SELECT
first_name,
UPPER(first_name) AS up_name
FROM customers;

--TASK:Show a list of customer's first names together with their country in one column
SELECT
first_name,
country,
CONCAT(first_name,'_' ,country) AS name_cou
FROM customers;

--TASK:Find customers whose first name  contains leading or trailing spaces
SELECT 
first_name
FROM customers
WHERE first_name != TRIM(first_name)


--TASK:Remove dashes(-) from a phone number
SELECT
'123-456-7890' AS phone,
REPLACE('123-456-7890','-','/') AS clean_phone


--TASK:Replace File Extence from txt to csv
SELECT
'report.txt' AS file_name,
REPLACE('report.txt' ,'.txt' ,'.csv') AS newfile_name;

--TASK:Calculate the length of each customer's first name
SELECT 
first_name,
LEN(first_name) AS len_name
FROM customers;

--TASK:Retrieve the first two characters of each first name
SELECT 
first_name,
LEFT(TRIM(first_name) ,2) AS first_two_char
FROM customers;

--TASK:Retrieve the last two characters of each first name
SELECT 
first_name,
RIGHT (TRIM(first_name),2) AS last_two_char
FROM customers;

--TASK:Retrieve a lsit of customers' first names removing the first character
SELECT
first_name,
SUBSTRING(TRIM(first_name),2,LEN(first_name)) AS sub_name
FROM customers;


/*   NUMERICAL FUNCTIONS       */
--TASK:Round of any dcimal no to different decimal places 
SELECT 
3.516,
ROUND(3.516 , 2) AS round_2,
ROUND(3.516 , 1) AS round_1,
ROUND(3.516 , 0) AS round_0;

--TASK:Convert neg num to positive
SELECT 
-10,
ABS(-10) AS pos;

/*  DATE & TIME FUNCTION   */
USE  SalesDB;
SELECT 
OrderID,
OrderDate,
ShipDate,
CreationTime FROM Sales.Orders;

--Three sources to query the date
SELECT 
OrderID,
CreationTime,    --columns from our database
'2025-08-20' AS Hardcoded,  --Hardcoded constant String value
GETDATE() AS Today  --Using GTDATE() function
FROM Sales.Orders;

--TASK: Check the month,year & day at which the item is created
SELECT 
OrderID,
CreationTime,
YEAR(CreationTime) Year,
MONTH(CreationTime) Month,
DAY(CreationTime) Day
FROM Sales.Orders;
--TASK: Extract diff information using DATEPART function
SELECT 
OrderID,
CreationTime,
DATEPART(Year,CreationTime) Year_dp,
DATEPART(Month ,CreationTime) Month_dp,
DATEPART(Day ,CreationTime) Day_dp,
DATEPART(Hour ,CreationTime) Hour_dp,
DATEPART(quarter ,CreationTime) Quarter_dp,
DATEPART(week,CreationTime) week_dp
FROM Sales.Orders;

--TASK: Extract diff information using DATENAME function
SELECT 
OrderID,
CreationTime,
DATENAME(month,CreationTime) month_dn,
DATENAME(weekday,CreationTime) day_dn,
DATENAME(year,CreationTime) year_dn
FROM Sales.Orders;

--TASK: DATETRUNC EXAMPLES
SELECT 
OrderID,
CreationTime,
DATETRUNC (minute, CreationTime) AS Minute_dt,
DATETRUNC (day, CreationTime) AS day_dt,
DATETRUNC (year, CreationTime) AS year_dt
FROM Sales.Orders;

--TASK:EOMONTH EXAMPLES
SELECT 
OrderID,
CreationTime,
EOMONTH ( CreationTime) AS EndOfMonth
FROM Sales.Orders;

--TASK:How many orders were placed each year?
 SELECT 
 YEAR(OrderDate),
 COUNT(*) AS NoofOrders
 FROM Sales.Orders
 GROUP BY YEAR(OrderDate);

 --TASK:How many orders were placed each year?
 SELECT 
DATENAME (Month ,OrderDate) AS Month_name,
COUNT(*) AS NoofOrders
 FROM Sales.Orders
 GROUP BY DATENAME (Month ,OrderDate);

 --TASK:Show all orders that were placed in the  month of february
SELECT * FROM Sales.Orders
 WHERE MONTH(OrderDate) =2; 

 --TASK:Represent the format of CreationTime in the formt of USA and EUROPe
 SELECT 
 OrderID,
 CreationTime,
 FORMAT( CreationTime,'MM-dd-yyyy') AS USA_Format,
 FORMAT(CreationTime,'dd-MM-yyyy') AS  EURO_Format
 FROM Sales.Orders;

 --TASK: Show creationTime using the following format:
 --Day Wed Jan Q1 2025 12:34:56 PM
 SELECT
 OrderID,
 CreationTime, 
 'Day '+ FORMAT(CreationTime,'ddd MMM') +
 'Q'+ DATENAME(quarter,CreationTime)+' '+
 FORMAT(CreationTime,'yyyy hh:mm:ss tt') AS CustomeFormat
 FROM Sales.Orders;

--TASK:Aggregation using FORMAT
SELECT 
FORMAT(OrderDate,'MMM yy') OrderDate,
COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy');

--TASK:Casting  the data
SELECT
CONVERT(INT, '123') AS [String to Int convert],
CONVERT(DATE,'2025-08-20') AS [String to date convert],
CreationTime,
CONVERT (DATE,CreationTime) AS [Datetime to date convert]
FROM Sales.Orders;


--TASK:Casting & formatting the data
SELECT
CreationTime,
CONVERT (DATE,CreationTime) AS [Datetime to date convert],
CONVERT(VARCHAR ,CreationTime, 32) AS [USA Std.Style:32],
CONVERT(VARCHAR ,CreationTime, 34) AS [EURO Std.Style:34]
FROM Sales.Orders;

--TASK:Cast function 
SELECT
CAST('123' AS INT) AS [String to Int],
CAST(123 AS VARCHAR) AS [Int to String],
CAST('2025-08-20' AS DATE) AS [String to date],
CAST('2025-08-20' AS DATETIME) AS [String to datetime],
CreationTime,
CAST(CreationTime AS DATE) AS[Datetime to date]
FROM Sales.Orders;

