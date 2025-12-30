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


   /*AGGREGATE WINDOW FUNCTION*/

--TASK:Find the total no.of orders with details like orderId,Orderdate
SELECT
	OrderID,
	OrderDate,
	COUNT (*) OVER()AS TotalOrders
FROM Sales.Orders;


--TASK:Find the total no.of orders for each customer with details like orderId,Orderdate
SELECT 
	OrderID,
	OrderDate,
	CustomerID,
	COUNT (*) OVER(PARTITION BY CustomerID) TotalOrdersByCustomers
FROM Sales.Orders;

--TASK:Find total no.ofcustomers & provide all details
SELECT *,
COUNT(*) OVER() TotalCustomers
FROM Sales.Customers;

--TASK:Find total no.of scores for the customers

SELECT *,
COUNT(Score) OVER() TotalScore
FROM Sales.Customers;

--TASK:Check whether the table "Orders" contains any duplicate rows
SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM Sales.Orders;

--TASK:Check whether the table "OrdersAechive" contains any duplicate rows
SELECT 
	OrderID,
	COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM Sales.OrdersArchive;

--TASK:find the total sales across all orders & the total sales for each product.
--Additionally ,provide details such as OrderID & order date.
SELECT  OrderID,OrderDate,Sales,ProductID,
SUM(SALES) OVER()TotalSales,
SUM (Sales) OVER(PARTITION BY ProductId) SalesByProduct
FROM Sales.Orders; 

--TASK:Find the percentage contribution of each product's sales to total sales
SELECT 
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS FLOAT) /SUM(Sales) OVER ()* 100 ,2) AS Percentageotal
FROM Sales.Orders;

--Find the average sales across all orders,
--and the average sales for each product.
--Additionally ,provide details such as orderID and order date.

SELECT 
	OrderID, OrderDate, Sales,ProductID,
AVG(Sales) OVER() AvgSales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgProuctSales
FROM Sales.Orders; 

--TASK:Find average scores of customers and provide detilas as CustomerID & LastName
SELECT CustomerId, LastName,Score,
AVG(COALESCE(Score,0)) OVER() AvgScore
FROM Sales.Customers;

--TASK:Find all orders  where sales are higher than the average sales across all ordres
SELECT *                      --Because SQL syntax does not allow a subquery in the FROM clause without a name.
FROM (
	SELECT OrderId,Sales,
	AVG(Sales) OVER() AvgSales
	FROM Sales.Orders
)t WHERE  Sales >  AvgSales       --This is because SQL requires every subquery used in the FROM clause to have a name.

--TASK:Find the highest & lowest sales for all orders
--Find the highest & lowest sales for each product
--Additionally provide details such as orderID,orderDate

SELECT OrderId,OrderDate,Sales,ProductID,
MIN(Sales)  OVER() AS LowestSale,
MAX(Sales) OVER() AS HighestSale,
MIN(Sales) OVER(PARTITION BY ProductID) LowestByProduct,
MAX(Sales) OVER(PARTITION BY ProductID) HighestByProduct
FROM Sales.Orders;

--TASK:Show the employees with the highest salaries
SELECT *
FROM(
	SELECT *,
	MAX(Salary) OVER() HighSalary
	FROM Sales.Employees
)t WHERE Salary=HighSalary

--TASK:Calculate  the deviation of each sale from both the minimum & maximum sales amount
--USE CASE: Help to evaluate how well a value is performing relative to the extremes
SELECT OrderId,OrderDate,Sales,ProductID,
	MIN(Sales)  OVER() AS LowestSale,
	MAX(Sales) OVER() AS HighestSale,
	Sales -MIN(Sales) OVER() DeviationFromMin, --The lower the deviatiion,thecloser the data points is to extreme
	MAX(Sales) OVER() -Sales DeviationFromMax
FROM Sales.Orders;

--TASK:Calculate moving average of sales for each product over time
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovAvgByProduct
FROM Sales.Orders;


--TASK:Calculate moving average of sales for each product over time including only the next order
SELECT
OrderID,
ProductID,
OrderDate,
Sales,
AVG(Sales) OVER(PARTITION BY ProductID) AvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) MovAvgByProduct,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) RollingAvg
FROM Sales.Orders;

/*  RANKING WINDOW FUNCTION*/
--TASK:Rank the orders based on their sales from highest to lowest
SELECT 
	OrderID,
	ProductID,
	Sales,
	ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
	RANK() OVER(ORDER BY Sales DESC)SalesRank_Rank,
	DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_Dense
FROM Sales.Orders;
 
--USE CASE: TOP -N Analysis
--TASK: Find the top highest sales for each product

SELECT *
FROM(
SELECT
	OrderID,
	ProductId,
	Sales,
	ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByproduct
FROM Sales.Orders)t
WHERE RankByproduct=1;

--USE CASE: Bottom N Analysis
--TASK:Find the lowest two customers based on their total sales

SELECT * FROM(
SELECT 
CustomerID,
SUM(Sales) AS Total_Sale,
ROW_NUMBER() OVER(ORDER BY SUM(Sales) ) AS RankingRow
FROM Sales.Orders
GROUP BY CustomerID)t
WHERE RankingRow <=2;

--TASK:Assign unique IDs to the rows of the 'OrderArchive' Table
SELECT 
ROW_NUMBER() OVER(ORDER BY OrderID,OrderDate) UniqueID,
*
FROM Sales.OrdersArchive;

--TASK:Divide the rows into equal buckets
SELECT 
OrderId,
Sales,
NTILE(1) OVER(ORDER BY Sales DESC)OneBucket,
NTILE(2) OVER(ORDER BY Sales DESC)TwoBucket,
NTILE(3) OVER(ORDER BY Sales DESC)ThreeBucket,
NTILE(4) OVER(ORDER BY Sales DESC)FourBucket
FROM Sales.Orders;

--TASK:Segment all orders into 3 categories
--USE CASE:Segmentation
SELECT
*,
CASE WHEN Buckets=1 THEN 'High'
	 WHEN Buckets=2 THEN 'Medium'
	 WHEN Buckets=3 THEN 'Low'
END SalesSegmentations
FROM(
	SELECT 
	OrderId,
	Sales,
	NTILE(3) OVER(ORDER BY Sales DESC)Buckets
FROM Sales.Orders)t;

--TASK:Find the products that fall within the highest 40% of prices
SELECT*,
CONCAT(DisRank *100,'%') DistRankPerc
FROM(
	SELECT
	Product,
	Price,
	CUME_DIST() OVER (ORDER BY Price DESC) DisRank
FROM Sales.Products)t
WHERE DisRank<=0.4

--TASK:Analyze the month -over-month performance by finding the percentage change
--in sales between the current & previous months
SELECT *,
CurrentMonthSales-PreviousMonthSales AS MoM_change,
ROUND(CAST((CurrentMonthSales-PreviousMonthSales)AS FLOAT)/PreviousMonthSales*100,1) AS MoM_Prec
FROM (
SELECT	
	MONTH(OrderDate) OrderMonth,
	SUM(Sales) CurrentMonthSales,
	LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY
	MONTH (OrderDate)
)t;


--TASK:Find the lowest and highest sales for each product
SELECT
	OrderID,
	ProductID,
	Sales,
	FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) LowestSales,
	LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales
	ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING )HighestSales
FROM Sales.Orders;


