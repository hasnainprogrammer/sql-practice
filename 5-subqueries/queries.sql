-- SUBQUERIES
-- for single value
SELECT * FROM products
WHERE unit_price > (SELECT unit_price FROM products
WHERE product_id = 3);
-- for multiple values
SELECT * FROM products WHERE product_id NOT IN (
	SELECT DISTINCT product_id FROM order_items
);
-- Exercise 1
USE sql_hr;
SELECT first_name, last_name, salary FROM employees
WHERE salary > (
				SELECT AVG(salary) FROM employees
);
-- Exercise 2
 USE sql_invoicing;
 SELECT * FROM clients
 WHERE client_id NOT IN  (
		SELECT DISTINCT client_id FROM invoices 
 ); 

-- SUBQUERIES VS JOINS
-- Exercise
USE sql_store;
-- solving using subquery
--  SELECT DISTINCT customer_id, first_name, last_name FROM customers WHERE customer_id IN (
--  		SELECT customer_id FROM orders o 
--         JOIN order_items oi USING (order_id)
--         WHERE oi.product_id = 3
--  );
-- solving using joins
SELECT DISTINCT c.customer_id, c.first_name, c.last_name FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3;
-- will keep the join solution, because it's more readable

-- ALL KEYWORD
USE sql_invoicing;
SELECT * FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total FROM invoices
    WHERE client_id = 3
);

-- ANY KEYWORD
USE sql_invoicing;
SELECT * FROM invoices 
WHERE client_id = ANY (
	SELECT client_id FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
);

-- CORRELATED SUBQUERIES
USE sql_hr;
SELECT * FROM employees e WHERE salary > (
	SELECT AVG(salary) FROM employees WHERE office_id = e.office_id
);
USE sql_invoicing;
SELECT * FROM invoices  i
WHERE invoice_total > (
	SELECT AVG(invoice_total) FROM invoices 
    WHERE client_id = i.client_id
);

-- EXISTS Operator
USE sql_invoicing;
SELECT * FROM clients c
WHERE EXISTS (
	SELECT * FROM invoices
    WHERE client_id = c.client_id
);
-- Exercise
USE sql_store;
SELECT * FROM products p
WHERE NOT EXISTS (
	SELECT product_id FROM order_items
    WHERE product_id = p.product_id
);

-- SUBQUERIES IN THE SELECT CLAUSE
USE sql_invoicing;
SELECT invoice_id,
	invoice_total, 
    (SELECT AVG(invoice_total) FROM invoices) AS invoice_average,
    invoice_total - (SELECT invoice_average) AS difference
FROM invoices;
-- Exercise
SELECT client_id, 
	name,
	(SELECT SUM(invoice_total) AS total_sales FROM invoices WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - average) AS difference
FROM clients c;

-- SUBQUERIRES IN THE FROM CLAUSE
SELECT * FROM (
	SELECT client_id, 
	name,
	(SELECT SUM(invoice_total) AS total_sales FROM invoices WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - average) AS difference
	FROM clients c
) AS total_sales;
