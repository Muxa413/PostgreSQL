--3
CREATE OR REPLACE VIEW active_products AS
SELECT *
FROM products
WHERE discontinued != 1
WITH LOCAL CHECK OPTION;

--2
--ALTER VIEW orders_customers_employees_2 RENAME TO oce_old;
CREATE OR REPLACE VIEW orders_customers_employees_2 AS
SELECT order_date, required_date, shipped_date, ship_postal_code, 
ship_country, company_name, contact_name, phone, last_name, first_name, 
title, customers.postal_code
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);

SELECT *
FROM orders_customers_employees
WHERE order_date > '1997-01-01'
ORDER BY ship_country;

--DROP VIEW IF EXISTS oce_old;
--DROP VIEW IF EXISTS orders_customers_employees_2;

--1
CREATE OR REPLACE VIEW orders_customers_employees AS
SELECT order_date, required_date, shipped_date, ship_postal_code, company_name, 
contact_name, phone, last_name, first_name, title
FROM orders
JOIN customers USING (customer_id)
JOIN employees USING (employee_id);

SELECT *
FROM orders_customers_employees
WHERE order_date > '1997-01-01'
ORDER BY ship_county;

--DROP VIEW IF EXISTS orders_customers_employees;

/*
1. Создать представление, которое выводит следующие колонки:

order_date, required_date, shipped_date, ship_postal_code, company_name, 
contact_name, phone, last_name, first_name, title из таблиц orders, 
customers и employees.
Сделать select к созданному представлению, выведя все записи, 
где order_date больше 1го января 1997 года.

2. Создать представление, которое выводит следующие колонки:
order_date, required_date, shipped_date, ship_postal_code, ship_country, 
company_name, contact_name, phone, last_name, first_name, 
title из таблиц orders, customers, employees.
Попробовать добавить к представлению (после его создания) колонки 
ship_country, postal_code и reports_to. Убедиться, что проихсодит ошибка. 
Переименовать представление и создать новое уже с дополнительными колонками.

Сделать к нему запрос, выбрав все записи, отсортировав их по ship_county.

Удалить переименованное представление.

3.  Создать представление "активных" (discontinued = 0) продуктов, 
содержащее все колонки. Представление должно быть защищено от вставки записей, 
в которых discontinued = 1.

Попробовать сделать вставку записи с полем discontinued = 1 - убедиться, 
что не проходит.
*/