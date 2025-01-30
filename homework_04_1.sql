/*
1. Вывести продукты количество которых в продаже меньше самого малого среднего количества продуктов в деталях заказов 
		(группировка по product_id). Результирующая таблица должна иметь колонки product_name и units_in_stock.
2. Напишите запрос, который выводит общую сумму фрахтов заказов для компаний-заказчиков для заказов, 
		стоимость фрахта которых больше или равна средней величине стоимости фрахта всех заказов, 
		а также дата отгрузки заказа должна находится во второй половине июля 1996 года. 
		Результирующая таблица должна иметь колонки customer_id и freight_sum, 
		строки которой должны быть отсортированы по сумме фрахтов заказов.
3. Напишите запрос, который выводит 3 заказа с наибольшей стоимостью, 
		которые были созданы после 1 сентября 1997 года включительно и были доставлены в страны Южной Америки. 
		Общая стоимость рассчитывается как сумма стоимости деталей заказа с учетом дисконта. 
		Результирующая таблица должна иметь колонки customer_id, ship_country и order_price, 
		строки которой должны быть отсортированы по стоимости заказа в обратном порядке.
4. Вывести все товары (уникальные названия продуктов), которых заказано ровно 10 единиц 
		(конечно же, это можно решить и без подзапроса).
*/

--1 
SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock < ALL (
	SELECT AVG(quantity)
	FROM order_details
	GROUP BY product_id 
)
ORDER BY units_in_stock DESC;

--2
SELECT customer_id, SUM(freight) AS freight_sum
FROM orders
JOIN (
	SELECT customer_id, AVG(freight) AS freight_avg
	FROM orders 
	GROUP BY customer_id
) USING (customer_id)
WHERE freight > freight_avg 
	AND shipped_date BETWEEN '1996-07-16' AND '1996-07-31'
GROUP BY customer_id
ORDER BY freight_sum;

--3
SELECT customer_id, ship_country, order_price
FROM orders
JOIN (
	SELECT order_id, SUM(unit_price * quantity - unit_price * quantity * discount) AS order_price
	FROM order_details
	GROUP BY order_id
) USING(order_id)
WHERE ship_country IN ('Argentina', 'Bolivia', 'Brazil', 'Chile', 'Colombia', 'Ecuador', 'Guyana', 'Paraguay', 'Peru', 'Suriname', 'Uruguay', 'Venezuela') 
	AND order_date >= '1997-09-01'
ORDER BY order_price DESC
LIMIT 3;

--4
SELECT product_name
FROM products
WHERE product_id = ANY (
	SELECT product_id
	FROM order_details
	WHERE quantity = 10
);

