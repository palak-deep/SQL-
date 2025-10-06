/*      SET OPERATORS    */
USE SalesDB;
--TASK:Combine the data from employees and customers into one table
 SELECT FirstName,LastName
 FROM Sales.Employees
 UNION 
 SELECT FirstName,LastName
 FROM Sales.Customers;

 --TASK:Combine the data from employees and customers into one table,including duplicates.
  SELECT FirstName,LastName
 FROM Sales.Employees
 UNION ALL
 SELECT FirstName,LastName
 FROM Sales.Customers;

 --TASK:Find emplopyees who are not customers at the same time
 SELECT FirstName,LastName
 FROM Sales.Employees
 EXCEPT
 SELECT FirstName,LastName
 FROM Sales.Customers;

 --TASK:Find the employees who are also customers
 SELECT FirstName,LastName
 FROM Sales.Employees
 INTERSECT
 SELECT FirstName,LastName
 FROM Sales.Customers;

 --TASK:Orders data are stored in seperate tables (ordres and archieve orders)
 --combine all orders data into one report without duplicates.

 SELECT
 'Orders' AS SourceTable
 , [OrderID]
 ,[ProductID]
 ,[CustomerID]
 ,[SalesPersonID]
 ,[OrderDate]
 ,[ShipDate]
 ,[OrderStatus]
 ,[ShipAddress]
 ,[BillAddress]
 ,[Quantity]
 ,[Sales]
 ,[CreationTime]
 FROM Sales.Orders
UNION
 SELECT 
 'OrderArchieve' AS SourceTable /*'Orders' AS SourceTable just helps tag the results,
not modify the table structure.*/
 ,[OrderID]
 ,[ProductID]
 ,[CustomerID]
 ,[SalesPersonID]
 ,[OrderDate]
 ,[ShipDate]
 ,[OrderStatus]
 ,[ShipAddress]
 ,[BillAddress]
 ,[Quantity]
 ,[Sales]
 ,[CreationTime]
 FROM Sales.OrdersArchive
 ORDER BY OrderID;