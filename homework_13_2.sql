--1
CREATE OR REPLACE FUNCTION filter_by_operator(oper int, VARIADIC numbers text[])
RETURNS SETOF text AS $$
DECLARE
	cur_val text;
BEGIN
	FOREACH cur_val IN ARRAY numbers
	LOOP
		RAISE NOTICE 'cur val is %', cur_val;
		CONTINUE WHEN cur_val NOT LIKE CONCAT('__(', oper, ')%');
		RETURN NEXT cur_val;
		END LOOP;
END
$$ LANGUAGE plpgsql;

SELECT * FROM filter_by_operator(903, VARIADIC ARRAY['+7(903)1901235', '+7(926)8567589', '+7(903)1532476']);

/*
Написать функцию, которая фильтрует телефонные номера по коду оператора.
Принимает 3-х значный код мобильного оператора и список телефонных номеров
	в формате +1(234)5678901 (variadic)
Функция возвращает только те номера, код оператора которых соответствует значению
	соответствующего аргумента.
Проверить функцию передав следующие аргументы:
903, +7(903)1901235, +7(926)8567589, +7(903)1532476
Попробовать передать аргументы с созданием массива и без.
Подсказка: чтобы передать массив в VARIADIC-аргумент, надо перед массивом прописать,
	собственно, ключевое слово variadic.
*/