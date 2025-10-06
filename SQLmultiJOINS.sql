/*   JOINING MULTIPLE TABLE (3+ TABLES)   */

/*TASK: Using SalesDB retrieve the list of all orders, along with the related customers,
products and employee details .For each ,display:
Order ID, Customer's name,Product name,Price ,Sales person's name */

USE SalesDB;

SELECT 
	o.orderID,
	o.Sales,
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	p.product AS ProductName,
	p.Price,
	e.FirstName AS SalesPersonFirstName,
	e.LastName AS SalesPersonLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers AS c
ON o.CustomerID=c.CustomerID
LEFT JOIN Sales.Products AS p
ON o.ProductID= p.ProductID
LEFT JOIN Sales.Employees AS e
ON o.SalesPersonID = E.EmployeeID;