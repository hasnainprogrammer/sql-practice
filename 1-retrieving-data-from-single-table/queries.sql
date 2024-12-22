-- USE sql_store;

-- SELECT CLAUSE
SELECT * FROM customers;
SELECT 
	first_name, 
	last_name, 
    points,
    (points + 10) * 100 AS 'discount factor'
FROM customers;
SELECT DISTINCT state FROM customers;
-- Exercise
SELECT 
	name, 
	unit_price,
    unit_price * 1.1 AS new_price
FROM products;

-- WHERE CLAUSE
SELECT * FROM customers WHERE state = 'VA';
SELECT * FROM customers WHERE state <> 'VA'; -- <> not equal operator
-- Exercise
SELECT * FROM orders WHERE order_date >= '2019-01-01';

-- AND, OR, NOT Operators
-- Precedence --> 1.AND, 2.OR, 3.NOT
SELECT * FROM customers
WHERE birth_date >= '1990-01-01' AND points > 1000;
SELECT * FROM customers
WHERE birth_date >= '1990-01-01' OR points > 1000;
SELECT * FROM customers
WHERE NOT (points > 1000);
-- Exercise
SELECT * FROM order_items
WHERE order_id = 6 AND quantity * unit_price  > 30;

-- IN Operator
SELECT * FROM customers
WHERE state IN ('VA', 'CO', 'FL');
-- Exercise
SELECT * FROM products 
WHERE quantity_in_stock IN (49, 38, 72);

-- BETWEEN Operator
SELECT * FROM customers
WHERE points BETWEEN 1000 AND 3000;
-- Exercise
SELECT * FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2020-01-01';

-- LIKE Operator
-- % any number of characters,  _ single character
SELECT * FROM customers
WHERE first_name LIKE 'b%';
SELECT * FROM customers
WHERE first_name LIKE '%y';
SELECT * FROM customers
WHERE first_name LIKE '___a';
-- Exercise
 SELECT * FROM customers
 WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
 SELECT * FROM customers
 WHERE phone LIKE '%9';
 
 -- REGEXP
 -- ^ (beginning), $ (end), | (OR), [abcd..] (to match a single character from multiple characters ), [-] (range) 
 SELECT * FROM customers
 WHERE last_name REGEXP 'se';
 SELECT * FROM customers
 WHERE last_name REGEXP '^brush';
   SELECT * FROM customers
 WHERE last_name REGEXP 'field$';
  SELECT * FROM customers
 WHERE last_name REGEXP 'be|se|mac';
  SELECT * FROM customers
 WHERE last_name REGEXP '[abc]e';
  SELECT * FROM customers
 WHERE last_name REGEXP '[a-z]h';
 
 -- Exercise
 SELECT * FROM customers
 WHERE first_name REGEXP 'elka|ambur';
 SELECT * FROM customers
 WHERE last_name REGEXP 'ey$|on$';
  SELECT * FROM customers
 WHERE last_name REGEXP '^my|se';
  SELECT * FROM customers
 WHERE last_name REGEXP 'b[ru]';
 
 -- IS NULL Operator
 SELECT * FROM customers
 WHERE phone IS NULL;
 -- Exercise
 SELECT * FROM orders
 WHERE shipper_id IS NULL;
 
 -- ORDER BY Clause
 SELECT * FROM customers
 ORDER BY first_name;
  SELECT * FROM customers
 ORDER BY first_name DESC;
  SELECT * FROM customers
 ORDER BY state, first_name;
 SELECT *, quantity * unit_price AS total_price FROM order_items 
 WHERE order_id = 2 ORDER BY total_price DESC;
 
 -- LIMIT Clause
 SELECT * FROM customers
 LIMIT 4;
 SELECT * FROM customers
 LIMIT 6, 3; -- first argument represent offset which tells mysql to skip the first 6 records and get the next 3 records after that.
 -- Exercise
 SELECT * FROM customers
 ORDER BY points DESC
 LIMIT 3;