--2
SELECT last_name, first_name, title, salary, 
	DENSE_RANK() OVER(ORDER BY salary)
FROM employees;

--1
SELECT DISTINCT employee_id, total_by_emp, AVG(total_by_emp) OVER() AS avg_price
FROM (
	SELECT employee_id, SUM(unit_price * quAntity) 
		OVER (PARTITION BY employee_id) AS total_by_emp
	FROM orders
	LEFT JOIN order_details USING(order_id)
)
ORDER BY total_by_emp DESC;


/*
1. Вывести отчёт показывающий по сотрудникам суммы продаж SUM(unit_price*quantity), 
	и сопоставляющий их со средним значением суммы продаж по сотрудникам 
	(AVG по SUM(unit_price*quantity)) сортированный по сумме продаж по убыванию.
2. Вывести ранг сотрудников по их зарплате, без пропусков. 
	Также вывести имя, фамилию и должность.
*/