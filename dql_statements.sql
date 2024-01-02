-- SQL (Structured Query Language)

-- Data Query Language (DQL)
-- Getting data from the database

-- Syntax: SELECT columns FROM table
SELECT * 
FROM actor;
-- * means ALL COLUMNS 

-- Can be one line, the semicolon is what ends a command
SELECT * FROM film;

-- Query for specific columns - SELECT col_1, col_2, col_3, etc. FROM table_name
SELECT title, description, release_year, length, rating
FROM film;

-- Columns will come back in the specified order
SELECT last_name, first_name
FROM actor;


-- Filter Rows - use WHERE clause - always comes after the FROM
SELECT *
FROM actor
WHERE first_name = 'Dan';

SELECT film_id, title, release_year
FROM film
WHERE film_id = 5;

-- use wildcards with the LIKE clause - % acts as a multi-character wildcard
-- can be any number of characters (0->infinity) - zero or many - r'[\w\s]*'
SELECT *
FROM actor
WHERE first_name LIKE 'M%'; -- will look FOR 'M' followed BY ANY number OF characters

SELECT *
FROM actor
WHERE first_name = 'M%'; -- will literally look FOR 'M%'

SELECT *
FROM actor
WHERE last_name LIKE '%r%';

-- Underscore (_) with LIKE clause - represents 1 and only 1 character
SELECT *
FROM actor
WHERE first_name LIKE '_i_';

SELECT *
FROM actor 
WHERE first_name LIKE '_i%';

-- using AND and OR in the WHERE clause
-- OR - only one needs to be true
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' OR last_name LIKE 'W%';

-- AND - all conditions need to be true
SELECT *
FROM actor 
WHERE first_name LIKE 'N%' AND last_name LIKE 'W%';

-- Comparison Operators in SQL:
-- Greater Than >
-- Less Than <
-- Greater Than or Equal To >=
-- Less Than or Equal To <=
-- Equals =
-- Not Equals <> or !=

SELECT *
FROM payment;


-- Query all of the payments of more than $7.00
SELECT customer_id, amount
FROM payment 
WHERE amount > 7.00;

-- Query for all less than 7
SELECT *
FROM payment
WHERE amount <= '6.99';

-- Not Equals
SELECT *
FROM staff
WHERE staff_id <> 1; -- WHERE staff id IS NOT equal TO 1

SELECT *
FROM staff
WHERE staff_id != 2; -- WHERE staff id IS NOT equal TO 2

SELECT *
FROM staff s
WHERE first_name NOT LIKE 'M%';

-- Get all of the payments between $3.00 and $8.00 (inclusive)
SELECT *
FROM payment
WHERE amount >= 3 AND amount <= 8;

-- BETWEEN/AND clause
SELECT *
FROM payment
WHERE amount BETWEEN 2 AND 5;

SELECT *
FROM film 
WHERE film_id BETWEEN 10 AND 20;


-- Order the rows of data - ORDER BY
-- default is Ascending order (add DESC for Descending)
-- Syntax: ORDER BY column_name
SELECT *
FROM film
ORDER BY rental_duration;

SELECT *
FROM film
ORDER BY title DESC;

-- ORDER BY comes after the WHERE (if present)
SELECT *
FROM payment
WHERE customer_id = 345
ORDER BY amount;

-- Exercise 1 - Write a query that will return all of the film that have an 'h' in the title
-- and order it by rental duration (in ascending order)
SELECT *
FROM film
WHERE title ILIKE '%h%' -- ILIKE IS the CASE INSENSITIVE LIKE 
ORDER BY rental_duration;


-- SQL Aggregations -> SUM(), AVG(), COUNT(), MIN(), MAX()
-- take in a column_name as an argument and return a single value

-- SUM - finds the sum of a column
SELECT SUM(amount)
FROM payment;

SELECT sum(amount)
FROM payment
WHERE amount > 5;


-- AVG - find the average of a column
SELECT AVG(amount)
FROM payment;

-- MIN/MAX - finds smallest/largest value in a column
-- also alias the column name - col_name AS alias_name
SELECT min(amount) AS lowest_amount_paid, max(amount) AS highest_amount_paid
FROM payment;

-- Can work with strings too!
SELECT min(first_name), max(last_name)
FROM actor;

-- COUNT() - Takes in either the column name OR * for all columns
-- If column_name, will count how many Non-Null rows in that column
-- if *, will count all rows
SELECT *
FROM staff;

SELECT COUNT(*)
FROM staff; -- RETURNS 2 because there ARE 2 ROWS

SELECT COUNT(picture)
FROM staff; -- RETURNS 1 because ONLY 1 ROW has a picture, the other IS NULL 

-- TO count unique values in a column, use the DISTINCT keyword
-- Syntx: COUNT(DISTINCT column_name)

SELECT *
FROM actor
WHERE first_name LIKE 'A%'
ORDER BY first_name;


SELECT COUNT(first_name)
FROM actor
WHERE first_name LIKE 'A%'; -- 13

SELECT COUNT(DISTINCT first_name)
FROM actor
WHERE first_name LIKE 'A%'; -- 9


-- GROUP BY Clause
-- Used with aggregations

SELECT *
FROM payment p 
ORDER BY amount;

SELECT COUNT(*)
FROM payment
WHERE amount = 0; -- 24

SELECT COUNT(*)
FROM payment p 
WHERE amount = 1.99; -- 580

SELECT COUNT(*)
FROM payment 
WHERE amount = 2.99; -- 3233

SELECT amount, COUNT(*), SUM(amount), AVG(amount)
FROM payment 
GROUP BY amount
ORDER BY amount;

-- columns selected from the table MUST also be in the GROUP BY

SELECT amount, customer_id, COUNT(*)
FROM payment 
GROUP BY amount; -- column "payment.customer_id" must appear in the GROUP BY clause or be used in an aggregate function

SELECT amount, customer_id, COUNT(*)
FROM payment 
GROUP BY amount, customer_id
ORDER BY customer_id;


-- Use aggregation results in the ORDER BY clause
-- QUERY the payment table to display the customers (by id) who have spent the most (in order)
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- We can use aliased column names in the ORDER BY
SELECT customer_id, SUM(amount) AS total_spend
FROM payment
GROUP BY customer_id
ORDER BY total_spend DESC;

SELECT *
FROM film
ORDER BY rental_duration, rental_rate;


-- HAVING Clause - HAVING is to GROUP BY/Aggregations as WHERE is to SELECT
SELECT *
FROM payment p
WHERE amount > 10;


SELECT customer_id, SUM(amount) AS total_spend
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 150
ORDER BY total_spend DESC;

SELECT customer_id, COUNT(*)
FROM payment 
GROUP BY customer_id
HAVING COUNT(*) BETWEEN 20 AND 30;


-- LIMIT and OFFSET clauses

-- LIMIT - limit the number of rows that are returned
SELECT *
FROM city
LIMIT 5;

-- OFFSET - start your rows after a certain number of rows
SELECT *
FROM city
OFFSET 10;

-- Can be used together
SELECT *
FROM city c 
OFFSET 20
LIMIT 5


-- Syntax Order - (SELECT and FROM are the only mandatory)

-- SELECT (column names)
-- FROM (table_name)
-- WHERE (row filter)
-- GROUP BY (aggregations)
-- HAVING (filter aggregations)
-- ORDER BY (column value ASC or DESC)
-- OFFSET (number of rows to skip)
-- LIMIT (max number of rows to display)

SELECT first_name, COUNT(*)
FROM actor
WHERE actor_id > 10
GROUP BY first_name
HAVING first_name LIKE '%t%'
ORDER BY first_name 
OFFSET 5
LIMIT 10;


SELECT first_name, COUNT(*) FROM actor WHERE actor_id > 20 GROUP BY first_name HAVING first_name LIKE '%t%' ORDER BY first_name  OFFSET 5 LIMIT 10;


