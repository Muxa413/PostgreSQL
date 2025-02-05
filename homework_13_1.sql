--1
CREATE OR REPLACE FUNCTION get_avg_freight_by_countries(VARIADIC countries text[])
RETURNS float8 AS $$
	SELECT AVG(freight)
	FROM orders
	WHERE ship_country = ANY (countries)
$$ LANGUAGE SQL;

SELECT get_avg_freight_by_countries(VARIADIC ARRAY['USA', 'UK']);
/*
Создать функцию, которая вычисляет средний фрахт по заданным странам 
(функция принимает список стран).
*/