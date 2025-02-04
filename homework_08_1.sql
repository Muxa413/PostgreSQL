--4
SELECT CONCAT(last_name, '', first_name),
	COALESCE(NULLIF(title, 'Sales Representative'), 'Sales Stuff') AS title
FROM employees

--3
SELECT DISTINCT contact_name, COALESCE(order_id::text, 'no orders')
FROM customers
LEFT JOIN orders USING (customer_id)
WHERE order_id IS NULL;

--2
SELECT product_name, unit_price, 
CASE 
	WHEN unit_price >= 100 THEN 'too expensive'
	WHEN unit_price >= 100 THEN 'average'
	ELSE 'low price'
END AS price
FROM products
ORDER BY unit_price DESC;

--1
SELECT contact_name, city, country
FROM customers
ORDER BY contact_name,
(
	CASE WHEN city IS NULL THEN country
		ELSE city
	END 
);

/*
1. Выполните следующий код 
(записи необходимы для тестирования корректности выполнения ДЗ):
insert into customers(customer_id, contact_name, city, country, company_name)
values 
('AAAAA', 'Alfred Mann', NULL, 'USA', 'fake_company'),
('BBBBB', 'Alfred Mann', NULL, 'Austria','fake_company');
После этого выполните задание:
Вывести имя контакта заказчика, его город и страну, 
отсортировав по возрастанию по имени контакта и городу,
а если город равен NULL, то по имени контакта и стране. 
Проверить результат, используя заранее вставленные строки.

2. Вывести наименование продукта, цену продукта и столбец со значениями
too expensive если цена >= 100
average если цена >=50 но < 100
low price если цена < 50

3. Найти заказчиков, не сделавших ни одного заказа. 
Вывести имя заказчика и значение 'no orders' если order_id = NULL.

4. Вывести ФИО сотрудников и их должности. 
В случае если должность = Sales Representative вывести вместо неё Sales Stuff.
*/