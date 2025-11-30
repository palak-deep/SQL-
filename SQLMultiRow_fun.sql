/*  AGGREGATE FUNCTIONS  */

--TASK: Find the total no.of orders
Use MyDatabase
SELECT COUNT(*) AS total_no_of_orders 
FROM orders;

--Find the total sales of all orders
SELECT SUM(sales) AS total_sales
 FROM orders;

 --TASK:Find the average sales of all orders
 SELECT AVG(sales) AS Average_sales
 FROM orders;

 --TASK:Find the highest sales of all orders
 SELECT MAX(sales) AS Highest_sales
 FROM orders;

 --TASK:Find the lowest sales among customers
 SELECT MIN(sales) AS Lowest_sale
 FROM orders;


 /*  WINDOW FUNCTIONS   */

 --TASK: Find the total sales for each product 
 --additionally provide details such as order ID,order date
 USE SalesDB;
 SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProducts
FROM Sales.Orders;

--TASK:Find the total sales across all orders
 --additionally provide details such as order ID,order date
 SELECT OrderID,
 OrderDate,
 SUM(Sales) OVER() TotalSales
 FROM Sales.Orders;

--TASK:Find the total sales for each combination of product and order status
SELECT 
 OrderID,
 OrderDate,
 OrderStatus,
 SUM(Sales) OVER(PARTITION BY ProductId,OrderStatus) TotalSales
 FROM Sales.Orders;

 --TASK:Rank each order based on their sales from highest to lowest,additionally provide details such order id & order date
 SELECT 
	 OrderID,
	 OrderDate,
	 Sales,
	RANK() OVER(ORDER BY Sales DESC ) RankSales
FROM Sales.Orders;

--TASK: Query the data using partition clause,order  by clause as well as frame clause
SELECT
OrderId,
OrderDate,
OrderStatus,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
From Sales.Orders;

--TASK:Find the total sales for each order status, only for two products 101 & 102
--RULE: SQL executes window fun after WHERE clause
 SELECT
	OrderID,
	OrderDate,
	ProductID,
	SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID  IN (101 ,102);

--TASK:Rank Customers based on their total sales
--RULE:Window function can be used together with GROUP BY only if the same columns are used
SELECT	
	CustomerId,
	SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID;
