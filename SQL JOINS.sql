 /*                         SQL JOINS                 */
 USE MyDatabase;
--TASK: Retrieve  all data from customers and orders in two different results
SELECT * FROM customers;

SELECT * FROM orders;

--TASK: Get all customers along with their orders,but only for customers who have placed an order
SELECT *
FROM customers 
JOIN orders
ON customers.id= orders.customer_id;

--OR the other way is:
SELECT
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id=o.customer_id;

--TASK: Get all customers with their orders, including those whithout orders.
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id;

--TASK: Get all customers along with their  orders, including orders without matching customers.
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
RIGHT JOIN orders as o
on c.id = o.customer_id;


--TASK:Get all customers along with their  orders, including orders without matching customers.(using left join)
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM orders AS O
LEFT JOIN customers AS c
ON c.id=o.customer_id;

--TASK: Get all customers and all orders,even if there's no match
SELECT 
	c.id,
	c.first_name,
	o.order_id,
	o.sales
FROM customers AS c
FULL JOIN  orders AS o
ON c.id=o.customer_id;

