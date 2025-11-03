USE MyDatabase;

--TASK: Retrive all customers data
SELECT * 
FROM customers;

--TASK: Retrive each customer's name, country and score
SELECT first_name, country ,score
FROM customers;

--TASK: Retrieve customers with a score not equal to 0
SELECT * 
FROM customers
WHERE score !=0

--TASK: Retrieve customers from germany
SELECT * 
FROM customers
WHERE country ='Germany';

--TASK: Retrieve all customers and sort the result by te highest score first
SELECT * 
FROM customers
ORDER BY score DESC; 

--TASK:Retrieve all customers and sort the results by the country and then by the highes score
SELECT *  
FROM customers
ORDER BY country ASC , score DESC;

--TASK: Find the total score for each country
SELECT country ,
SUM(score) AS total_score
FROM customers
GROUP BY country;

--TASK: Find the total score and total no.of customers for each country
SELECT country,
SUM (score) AS total_score,
COUNT(id) AS total_customers
FROM customers
GROUP BY country;

/*TASK:Find the average score for each country considering onl
customers with a score not equal to 0 and return only those countries
with an average score greater than 430*/
SELECT country,
AVG(score) AS average_score
FROM customers
WHERE score!=0
GROUP BY country
HAVING AVG(score) >430;

--TASK: Return unique list of all countries
SELECT DISTINCT country
FROM customers;

--TASK:Retrieve the top 3 customers with the highest score
SELECT TOP 3*
FROM customers
ORDER BY score DESC;

--TASK:Retrieve the lowest 2 customers based on the score
SELECT TOP 2 * 
FROM customers
ORDER BY score ASC;


SELECT * 
FROM orders;

--TASK:Get the two most recent orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;



                                                   /*  DML Commands     */
--Insert values into customer table for two rows
INSERT INTO customers(id,first_name,country,score)
VALUES
(6,'Anna' , 'USA' , null),
(7,'Sam' , NULL , 100);
SELECT * FROM customers

--Insert values to all the columns of table customers
INSERT INTO customers
VALUES (9,'Andreas' , 'Germany' ,Null)

--Insert values to id and first_name columns of the table customers
INSERT INTO customers(id , first_name)
VALUES (8 , 'Sahra')

--Insert data from customers table into person  table
INSERT INTO persons (id,person_name,birth_date,email)
SELECT id,first_name ,  NULL , 'Unknown'
FROM customers;

SELECT* FROM persons;

--Change the score of customer with ID 6 to 0

SELECT * FROM customers;

UPDATE customers
SET score = 0
WHERE id =6;


/*change the score of customers 8 to 0
and update the country to UK*/
UPDATE customers
SET score =0,
country ='UK'
WHERE id = 8;

--update  all customers with a NULL score by settting their score to 0
UPDATE customers
SET score =0
WHERE score IS NULL

--Delete all customers with ID greater than 5
DELETE FROM customers
WHERE id>5;

SELECT * FROM customers;


--Delete all data from table persons
DELETE FROM persons
--OR
TRUNCATE TABLE persons;