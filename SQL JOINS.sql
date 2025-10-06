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

--TASK: Get all customers who haven't placed any order
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id =o.customer_id
WHERE o.customer_id  IS NULL;

--TASK: Get all orders without  matching customers
SELECT * 
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;

--TASK: Get all orders without  matching customers (Using LEFT JOIN)
SELECT * 
FROM orders  AS o
LEFT JOIN customers AS c
ON c.id=o.customer_id
WHERE c.id IS NULL;

--TASK:Find customers without orders and orders without customers
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id=o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL;

--TASK: Get all customers along with their orders,but only for customers who have placed an order(with out using INNER JOIN)
SELECT * 
FROM customers AS c
FULL JOIN orders AS o
ON c.id =o.customer_id
WHERE c.id IS NOT NULL AND o.customer_id IS NOT NULL;


--TASK:Generate all possible combinations of customers and orders
SELECT *
FROM customers
CROSS JOIN orders;