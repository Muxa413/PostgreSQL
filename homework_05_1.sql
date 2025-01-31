/*
1. Создать таблицу teacher с полями 
	teacher_id serial, first_name varchar, last_name varchar, 
	birthday date, phone varchar, title varchar
2. Добавить в таблицу после создания колонку middle_name varchar
3. Удалить колонку middle_name
4. Переименовать колонку birthday в birth_date
5. Изменить тип данных колонки phone на varchar(32)
6. Создать таблицу exam с полями exam_id serial, exam_name varchar(256), exam_date date
7. Вставить три любых записи с автогенерацией идентификатора
8. Посредством полной выборки убедиться, 
	что данные были вставлены нормально и идентификаторы были сгенерированы с инкрементом
9. Удалить все данные из таблицы со сбросом идентификатор в исходное состояние
*/

--1
CREATE TABLE teacher (
	teacher_id serial, 
	first_name varchar, 
	last_name varchar, 
	birthday date, 
	phone varchar, 
	title varchar
);

ALTER TABLE teacher
ADD COLUMN middle_name varchar;

ALTER TABLE teacher
DROP COLUMN middle_name;

ALTER TABLE teacher
RENAME birthday TO birth_date;

ALTER TABLE teacher
ALTER COLUMN phone SET DATA TYPE varchar(32);

CREATE TABLE exam (
	exam_id serial, 
	exam_name varchar(256), 
	exam_date date
)

INSERT INTO exam (exam_name, exam_date)
VALUES
('One', '2000-01-01'),
('Two', '2000-01-02'),
('Three', '2000-01-03');

SELECT * FROM exam;
SELECT * FROM teacher;

TRUNCATE TABLE exam
RESTART IDENTITY;

TRUNCATE TABLE teacher
RESTART IDENTITY;

-- DROP TABLE exam;
-- DROP TABLE teacher;

