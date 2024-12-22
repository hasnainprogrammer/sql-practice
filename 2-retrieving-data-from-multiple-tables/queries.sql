-- INNER Join
SELECT order_id, o.customer_id, first_name, last_name 
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;
-- Exercise
SELECT oi.product_id, name, quantity, oi.unit_price
FROM order_items oi
INNER JOIN products p
ON oi.product_id = p.product_id;

-- JOINING Across Databases
-- to join tables across databases, prefix the column with the database name but prefix that column only that is not the part of the current selected database, not the one that is the part of the current selected database. 
SELECT * FROM order_items oi
JOIN sql_inventory.products p
ON oi.product_id = p.product_id;

-- SELF Join
SELECT e.employee_id, e.first_name, m.first_name 
FROM sql_hr.employees e
JOIN sql_hr.employees m
ON e.reports_to = m.employee_id;

-- JOINING Multiple Tables
SELECT o.order_id, c.first_name, os.name AS status FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
JOIN order_statuses os
ON o.status = os.order_status_id;
-- Exercise
SELECT c.client_id, c.name, pm.payment_method_id, pm.name FROM sql_invoicing.payments p
JOIN sql_invoicing.clients c
ON p.client_id = c.client_id
JOIN sql_invoicing.payment_methods pm
ON p.payment_method = pm.payment_method_id;

-- COMPOUND JOIN Condition
-- joining a table with a table that has a composite key
SELECT * FROM order_items oi
JOIN order_item_notes oin
ON oi.order_id = oin.order_id
AND oi.product_id = oin.product_id;

-- Implicit JOIN Syntax
-- DON'T use Implicit Join, instead use Explicit (ON) join. Why? because if you forget the WHERE clause in implicit join then it will lead to cross join, on the other hand explicit join enforces you to write the join condition.
SELECT * FROM orders o
JOIN customers c
WHERE o.customer_id = c.customer_id;

-- OUTER JOIN
-- two types of outer join, 1. left outer 2. right outer join. as a best practice use only left join not the right join
SELECT * FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
SELECT * FROM customers c
RIGHT OUTER JOIN orders o
ON c.customer_id = o.customer_id
ORDER BY c.customer_id;
-- Exercise
SELECT p.product_id, p.name, oi.quantity FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id;

-- OUTER JOIN Between Multiple Tables
SELECT c.customer_id, c.first_name, o.order_id, sh.name AS shipper FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
ON sh.shipper_id = o.shipper_id;
-- Exercise
SELECT o.order_date, o.order_id, c.first_name, sh.name AS shipper, os.name AS status 
FROM orders o 
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id;

-- SELF OUTER JOIN
SELECT e.employee_id, e.first_name, m.first_name AS manager FROM sql_hr.employees e
LEFT JOIN sql_hr.employees m
ON e.reports_to = m.employee_id;

-- USING CLAUSE
SELECT * FROM customers c
JOIN orders o
USING (customer_id); -- works only if the names of the columns in both of the tables are same, otherwise not
-- Exercise
SELECT p.date, c.name AS client, p.amount, pm.name AS payment_method  FROM sql_invoicing.payments p
JOIN sql_invoicing.clients c 
USING (client_id)
JOIN sql_invoicing.payment_methods pm
ON p.payment_method = pm.payment_method_id;

-- NATURAL JOIN
-- not recommended to use, sometimes produces unexpected results because we are letting mysql to guess the common columns in both of the tables.
SELECT * FROM customers c
NATURAL JOIN orders o;

-- CROSS JOIN
SELECT c.first_name, p.name AS product FROM customers c
CROSS JOIN products p;
-- Exercise
-- implicit syntax
SELECT sh.name AS shipper, p.name AS products FROM shippers sh, products p ORDER BY sh.name;
-- explicit syntax
SELECT sh.name AS shipper, p.name AS products FROM shippers sh, products p CROSS JOIN products ORDER BY sh.name;

-- UNION
SELECT order_id, order_date, 'Active' as status FROM orders WHERE order_date >= '2019-01-01'
UNION
SELECT order_id, order_date, 'Archived' FROM orders WHERE order_date < '2019-01-01';
-- Exercise
SELECT customer_id, first_name, 'Bronze' as type FROM customers WHERE points < 2000
UNION
SELECT customer_id, first_name, 'Silver' FROM customers WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id, first_name, 'Gold' FROM customers WHERE points > 3000
ORDER BY first_name;


;