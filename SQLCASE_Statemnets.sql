--TASK: Generate a report showing the total sales for each category:
--High:If the sales higher than 50
--Medium: if the sales betwen 20 and 50
--Low: if the sales equal or lower than 20
--sort the result from lowest to highest.

USE SalesDB;
SELECT Category,
SUM(Sales) AS TotalSales
FROM(
	SELECT OrderId,Sales,
	CASE
		 WHEN Sales>50 THEN 'High'
		 WHEN Sales >20 THEN 'Medium'
		 ELSE 'Low'
	END Category
	FROM Sales.Orders
)t --t is simply a table alias — a short name given to the subquery so that SQL can refer to it like a temporary table.
GROUP BY Category
ORDER BY TotalSales DESC;


--TASK:Retrieve employee details with gender displayed as full text
SELECT 
EmployeeID,
FirstName,
Lastname,
Gender,
CASE	
	WHEN Gender ='M' THEN 'Male'
	WHEN Gender ='F' THEN 'Female'
	ELSE 'Not Available'
END FULLGender

FROM Sales.Employees;


--TASK: Retrieve customer details with abbreviated country code
SELECT 
CustomerID,
FirstName,
LastName,
Country,
CASE	
	WHEN Country ='Germany' THEN 'G'
	WHEN Country ='USA' THEN 'U'
	ELSE 'Not Available'
END Abbcountry,
--OR QUICK FORM
CASE Country 
	WHEN 'Germany' THEN 'G'
	WHEN 'USA' THEN 'U'
	ELSE 'Not Available'
END Abbcountry2
	
FROM Sales.Customers;

--To check list of countries beforing forming cases of case statements
SELECT DISTINCT (Country)
FROM Sales.Customers

--TASK:Find the average scores of customers and treat Nulls as O
--And addiuonal provide details such as CustomerId & LastNAMe
SELECT CustomerID,
LastName,
Score,
CASE
	WHEN Score IS NULL THEN 0
	ELSE Score
END ScoreClean,

AVG(CASE
		WHEN Score IS NULL THEN 0
		ELSE Score
	END) OVER ()AvgCustomerClean,

AVG(Score) OVER ()AvgCustomer
FROM Sales.Customers

--TASK :Count how many times each customer has made an order with sales greater than 30
SELECT 
CustomerID,
SUM(CASE WHEN Sales >30 THEN 1
ELSE 0
END) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID