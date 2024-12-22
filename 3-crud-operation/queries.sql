-- INSERTING A ROW
INSERT INTO shippers (name)
VALUES ('Shipper 1');
-- INSERTING MULTIPLE ROWS
INSERT INTO shippers (name)
VALUES ('Shipper 2'), ('Shipper 2'), ('Shipper 3');
-- Exercise
INSERT INTO products (name, quantity_in_stock, unit_price) 
VALUES ('Product 1', 50, 1.31), ('Product 2', 60, 2.01), ('Product 3', 70, 3.12);

-- INSERTING HIERARCHICAL ROWS
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-03-05', 1);
INSERT INTO order_items 
VALUES (LAST_INSERT_ID(), 1, 10, 2.87);

-- CREATING A COPY OF A TABLE
CREATE TABLE orders_archive AS
SELECT * FROM orders; -- will not copy the constraints such as PK, AI etc.
INSERT INTO orders_archive
SELECT * FROM orders WHERE order_date < '2019-01-01';
-- Exercise
CREATE TABLE sql_invoicing.invoice_archive AS
SELECT i.invoice_id, i.number, c.name, i.invoice_total, i.payment_total FROM sql_invoicing.invoices i
JOIN sql_invoicing.clients c
ON sql_invoicing.i.client_id = sql_invoicing.c.client_id
WHERE sql_invoicing.i.payment_date IS NOT NULL ;

-- UPDATING A SINGLE ROW
UPDATE sql_invoicing.invoices 
SET  sql_invoicing.invoices.payment_total = sql_invoicing.invoices.invoice_total * 0.5,
	 sql_invoicing.invoices.payment_date = sql_invoicing.invoices.due_date
WHERE sql_invoicing.invoices.invoice_id = 3;

-- UPDATING MULTIPLE ROWS
UPDATE sql_invoicing.invoices
SET sql_invoicing.invoices.payment_total = sql_invoicing.invoices.invoice_total * 0.5,
	 sql_invoicing.invoices.payment_date = sql_invoicing.invoices.due_date
WHERE sql_invoicing.invoices.client_id = 3;
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01';

-- USING SUBQUERIES IN UPDATES
UPDATE sql_invoicing.invoices
SET sql_invoicing.invoices.payment_total = sql_invoicing.invoices.invoice_total * 0.5,
	 sql_invoicing.invoices.payment_date = sql_invoicing.invoices.due_date
WHERE client_id =
				(SELECT client_id FROM sql_invoicing.clients 
				WHERE sql_invoicing.clients.name = 'MyWorks');
-- Exercise
UPDATE orders 
SET comments = 'Gold Customers'
WHERE customer_id IN 
					(SELECT customer_id FROM customers 
					WHERE points > 3000); 

-- DELETING ROWS
DELETE FROM products
WHERE product_id = 22;

