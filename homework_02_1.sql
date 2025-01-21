/*
1. Выбрать все данные из таблицы customers
2. Выбрать все записи из таблицы customers, но только колонки "имя контакта" и "город"
3. Выбрать все записи из таблицы orders, но взять две колонки: идентификатор заказа и колонку, значение в которой мы рассчитываем как разницу между датой отгрузки и датой формирования заказа.
4. Выбрать все уникальные города в которых "зарегестрированы" заказчики
5. Выбрать все уникальные сочетания городов и стран в которых "зарегестрированы" заказчики
6. Посчитать кол-во заказчиков
7. Посчитать кол-во уникальных стран в которых "зарегестрированы" заказчики
*/

-- SELECT * FROM customers
-- SELECT contact_name, city FROM customers
-- SELECT order_id, shipped_date - order_date FROM orders
-- SELECT DISTINCT city FROM customers
-- SELECT DISTINCT city, country FROM customers
-- SELECT COUNT(*) FROM customers
-- SELECT COUNT(DISTINCT country) FROM customers


