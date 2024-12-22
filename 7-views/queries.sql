-- VIEWS
-- a view is a virtual table
CREATE VIEW sales_by_client AS 
SELECT c.client_id, c.name, SUM(invoice_total) AS total_sales FROM invoices i
JOIN clients c USING (client_id)
GROUP BY client_id, name;

SELECT * FROM sales_by_client ORDER BY total_sales DESC;
-- Exercise
USE sql_invoicing;
CREATE VIEW clients_balance AS 
SELECT c.client_id, c.name, SUM((invoice_total - payment_total)) AS balance  
FROM invoices i
JOIN clients c USING(client_id)
GROUP BY client_id, name;
-- Dropping a View
DROP VIEW clients_balance;
-- Altering a View
CREATE OR REPLACE VIEW clients_balance AS 
SELECT c.client_id, c.name, SUM((invoice_total - payment_total)) AS balance  
FROM invoices i
JOIN clients c USING(client_id)
GROUP BY client_id, name
ORDER BY client_id;

-- UPDATEABLE VIEWS
-- you can delete/update records into a view if the view satisfies the following constraints: the view doesn't have any aggregate function, nor a group by/having clause, nor have a distinct keyword, and nor have a union operator. while creating a view if you haven't have use any of the constraints mentioned before then the view is refer to an updateable view, and you can do deletion/updation operation in that view.
-- inserting a record into a view is a little bit trickier, you can only insert a record into a view if the view have all of the required fields/columns of the underlying table.  
USE sql_invoicing;
CREATE OR REPLACE VIEW invoice_with_balance AS
SELECT invoice_id,
		number,
        client_id, 
        invoice_total,
        payment_total,
        (invoice_total - payment_total) AS balance,
        invoice_date,
        due_date,
        payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION; -- here
-- the above view satisfies all of the constraints discussed earlier thus we can perform deletion/updation.
DELETE FROM invoice_with_balance 
WHERE invoice_id = 1;
UPDATE invoice_with_balance
SET due_date = DATE_ADD( due_date, INTERVAL 2 DAY);

-- VIEW With 'WITH CHECK OPTION'
-- by default when you update or delete a record in a view that record disappear from the view automatically, to prevent this you can use the WITH CHECK OPTION when creating a view which will prevent updation or deletion from a view and will give you an error.
-- problem
UPDATE invoice_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 4;
-- solution ==> WITH CHECK OPTION (see above)


