-- NUMERIC FUNTIONS
SELECT ROUND(5.6);
SELECT ROUND(5.4, 1);
SELECT CEILING(5.3);
SELECT FLOOR(4.3);
SELECT TRUNCATE(3.141592, 2);
SELECT ABS(-3);
SELECT RAND();

-- STRING FUNCTIONS
SELECT LENGTH('hasnain');
SELECT LTRIM('    username');
SELECT RTRIM('username      ');
SELECT TRIM('   username     ');
SELECT UPPER('hasnain');
SELECT LOWER('hasnain');
SELECT LEFT('kindergarden', 4);
SELECT RIGHT('kindergarden', 6);
SELECT SUBSTRING('kindergarden', 5, 4);
SELECT LOCATE('g', 'kindergarden');
SELECT REPLACE('kindergarten', 't', 'd');
SELECT CONCAT('firstName', ' ', 'lastName');
SELECT CONCAT(YEAR(NOW()), '-01-01');
SELECT EXTRACT(YEAR FROM NOW());

-- DATE FUNCTIONS
SELECT NOW();
SELECT DATE(NOW());
SELECT TIME(NOW());
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT DAYNAME(NOW());
SELECT MONTHNAME(NOW());
SELECT EXTRACT(YEAR FROM NOW());

-- FORMATING DATES AND TIME
SELECT DATE_FORMAT(NOW(), '%D %M %Y');
SELECT TIME_FORMAT(NOW(), '%H:%i:%p');

-- CALCULATING DATES AND TIMES
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR);
SELECT DATE_SUB(NOW(), INTERVAL 1 YEAR);
SELECT DATEDIFF('2024-01-05', '2024-01-01');
SELECT TIME_TO_SEC('9:02') - TIME_TO_SEC('9:00');

-- IFNULL AND COALESCE FUNTION
USE sql_store;
SELECT order_id,
		-- IFNULL(shipper_id, 'Not Assigned') AS shipper
        COALESCE(shipper_id, comments, 'Not Assigned') AS shipper
FROM orders;
-- Exercise
USE sql_store;
SELECT CONCAT(first_name, ' ', last_name) AS customer, 
		-- IFNULL(phone, 'Unknown') AS phone
        COALESCE(phone, 'UNKNOWN') AS phone
FROM customers;

-- IF Function
USE sql_store;
SELECT order_id,
		order_date, 
        IF(YEAR(order_date) = YEAR(NOW()), 'Active', 'Archived') AS category 
FROM orders;
-- Exercise
SELECT p.product_id, p.name, COUNT(*) As orders, IF(count(*) > 1, 'Many Times', 'Once') AS frequency 
FROM products p
JOIN order_items oi USING (product_id)
GROUP BY oi.product_id, name;

-- CASE Operator
USE sql_store;
SELECT order_id,
		CASE 
			WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
            WHEN YEAR(order_date) = YEAR(NOW()) - 1 THEN 'Last Year'
            WHEN YEAR(order_date) < YEAR(NOW()) - 1 THEN 'Archived'
            ELSE 'Future'
		END	AS category
FROM orders;
-- Exercise
SELECT CONCAT(first_name, ' ', last_name) AS customer,
		points,  
        CASE
			WHEN points > 3000 THEN 'Gold'
            WHEN points >= 2000 THEN 'Silver'
			ELSE 'Bronze'
        END AS category
FROM customers;