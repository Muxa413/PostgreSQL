--2
BEGIN;

CREATE TABLE archive_discontinued_products AS 
	SELECT * FROM products WHERE discontinued = 1;

SAVEPOINT archive_discontinued;

	DELETE FROM order_details
	WHERE product_id IN (SELECT product_id FROM archive_discontinued_products);

DELETE FROM products
WHERE discontinued = 1;

ROLLBACK TO archive_discontinued;

COMMIT;

SELECT * FROM products WHERE discontinued = 1;

--1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

DROP TABLE IF EXISTS archive_poor_customers;

CREATE TABLE archive_poor_customers AS 
	SELECT customer_id, company_name, SUM(unit_price * quantity) AS total
	FROM orders
	JOIN order_details USING(order_id)
	JOIN customers USING(customer_id)
	GROUP BY company_name, customer_id
	HAVING SUM(unit_price * quantity) < 2000
	ORDER BY SUM(unit_price * quantity) DESC;

	DELETE FROM order_details
	WHERE order_id 
		IN (SELECT order_id FROM orders WHERE customer_id 
			IN (SELECT customer_id FROM archive_poor_customers)
		);

	DELETE FROM orders
	WHERE customer_id IN (SELECT customer_id FROM archive_poor_customers);

	DELETE FROM customers
	WHERE customer_id IN (SELECT customer_id FROM archive_poor_customers);

--ROLLBACK;

COMMIT;

SELECT * FROM archive_poor_customers;
	

/*
1. В рамках транзакции с уровнем изоляции Repeatable Read выполнить следующие операции:

- заархивировать (SELECT INTO или CREATE TABLE AS) заказчиков, 
	которые сделали покупок менее чем на 2000 у.е.
- удалить из таблицы заказчиков всех заказчиков, которые были 
	предварительно заархивированы 
	(подсказка: для этого придётся удалить данные из связанных таблиц)

2. В рамках транзакции выполнить следующие операции:
- заархивировать все продукты, снятые с продажи (см. колонку discontinued)
- поставить savepoint после архивации
- удалить из таблицы продуктов все продукты, которые были заархивированы
- откатиться к savepoint
- закоммитить тразнакцию
*/