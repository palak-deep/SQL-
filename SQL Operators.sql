USE MyDatabase;
SELECT * FROM customers;

/*        SQL Comparison Operators         */

--Task: Retrieve all customers from germany
SELECT * FROM customers 
WHERE country ='Germany';

--Task: Retrieve all customers who are not from Germany
SELECT * FROM customers
WHERE country != 'Germany';

--Task: Retrieve all customers with a score greater han 500
SELECT * FROM customers
WHERE score > 500;

--Task: Retrieve all customers with a score of 500 or more
SELECT * FROM customers
WHERE score >= 500;

--Task:Retrieve all customers with a score less than 500
SELECT * FROM customers
WHERE score < 500;

--Task: Retrieve all customers with a score of 500 or less
SELECT * FROM customers
WHERE score <= 500;

/*          LOGICAL OPERATORS        */

--Task: Retrieve all customers who are from USA  AND have a score greater than 50
SELECT *  FROM customers
WHERE country ='USA' AND score > 500;

--Task: Retrieve all customers who are either from USA  OR have a score greate than 500
SELECT * FROM customers
WHERE country ='USA' OR score  > 500;


--Task: Retrieve  all customers with a score not less than 500
SELECT * FROM  customers 
WHERE NOT score <500;

/*       RANGE OPERATORS     */

--Task: Retrieve all customers whose score falls in the range between 100 & 500
SELECT * FROM  customers 
WHERE score BETWEEN 100 AND  500;
-- other way by combining comparison and logical operators
SELECT * FROM  customers 
WHERE score  >= 100 AND  score <= 500;


/*  MEMBERSHIP OPERATORS    */

--Task: Retrieve 