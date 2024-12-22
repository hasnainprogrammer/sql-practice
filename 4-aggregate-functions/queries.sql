-- AGGREGATE FUNCTIONS
-- aggregate functions ommit/ignore null values, they do not consider null values, if you want them to consider null values then give * as an input to the aggregate functions. also the consider a duplicated record as a separate record if you want them to only consider unique values then use DISTINCT keyword in front of the column name.
use sql_invoicing;
SELECT 
	MAX(invoice_total) AS highest,
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total) AS total,
    COUNT(invoice_total) AS number_of_invoices,
    COUNT(payment_date) AS count_of_payments,
    COUNT(*) AS total_records,
    COUNT(DISTINCT client_id) AS number_of_clients
FROM invoices;
-- Exercise
SELECT 
	'First half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 
	'Second half of 2019' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION 
SELECT 
	'total' AS date_range,
	SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices;

-- GROUP BY CLAUSE
SELECT state, city, sum(amount) AS total_amount FROM payments
JOIN clients USING (client_id)
GROUP BY state, city;
-- Exercise
SELECT p.date, pm.name AS payment_method, SUM(p.amount) AS total_payments  FROM payments p
JOIN payment_methods pm
		ON p.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY date;

-- HAVING CLAUSE
SELECT state, SUM(p.amount) AS total_amount FROM clients c
JOIN payments p USING (client_id)
GROUP BY state
HAVING total_amount > 100;
-- Exercise
USE sql_store;
SELECT c.customer_id, c.first_name, c.last_name, SUM(oi.quantity * oi.unit_price) AS spend_amount  FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE state = 'VA'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING spend_amount > 100;
-- DIFFERENCE B/W WHERE CLAUSE AND HAVING CLAUSE
-- WHERE CLAUSE --> used to filter data before grouping it, you can refer to any column while specifying the condition.
-- HAVING CLAUSE --> used to filter data after grouping it, you can only refer to the column(s) that you have specified in the SELECT clause.

-- ROLLUP Operator 
SELECT c.state, SUM(p.amount) AS total FROM payments p
JOIN clients c USING (client_id)
GROUP BY c.state WITH ROLLUP;
SELECT pm.name AS payment_method, SUM(p.amount) AS total FROM payments p
JOIN payment_methods pm
		ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP;
