-- Выбрать данные о городе: страна, регион
SELECT 
    _cities.id,
    important,
    _cities.title,
    _countries.title,
    _regions.title
FROM
    geodata._cities
        JOIN
    geodata._countries ON _cities.country_id = _countries.id
        JOIN
    geodata._regions ON _cities.region_id = _regions.id
WHERE
    _cities.title = 'Екатеринбург';

-- Выбрать все города из Московской области
SELECT 
    _cities.id, _cities.title
FROM
    geodata._cities
        JOIN
    geodata._regions ON _cities.region_id = _regions.id
WHERE
    _regions.title = 'Московская область';

-- Выбрать среднюю зарплату по отделам
SELECT 
    d.dept_no, d.dept_name, AVG(salary) AS avg_salary
FROM
    dept_emp de
        JOIN
    salaries s ON de.emp_no = s.emp_no
        JOIN
    departments d ON de.dept_no = d.dept_no
GROUP BY de.dept_no
;

-- Выбрать максимальную зарплату у сотрудника
SELECT 
	e.emp_no,
    CONCAT(last_name, ', ', first_name) AS full_name,
    MAX(salary) AS max_salary
FROM
    employees e 
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY s.emp_no
;

-- Удалить сотрудника с максимальной зарплатой
DELETE e
FROM
    employees e,
    (SELECT 
        s.emp_no, MAX(salary) AS max_salary
    FROM
        salaries s) ms
WHERE
    e.emp_no = ms.emp_no
;

-- Посчитать количество сотрудников во всех отделах
SELECT 
    COUNT(emp_no) AS employees_quantity
FROM
    dept_emp
;

-- Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел
SELECT 
    dept_salary.dept_no, dept_name, dept_salary, emp_quantity
FROM
    (SELECT 
        de.dept_no, SUM(salary) AS dept_salary
    FROM
        salaries s
    JOIN dept_emp de ON s.emp_no = de.emp_no
    GROUP BY de.dept_no) dept_salary,
    (SELECT 
        de.dept_no, d.dept_name, COUNT(de.emp_no) AS emp_quantity
    FROM
        dept_emp de
    JOIN departments d ON d.dept_no = de.dept_no
    GROUP BY d.dept_no) emp_quantity
WHERE
    emp_quantity.dept_no = dept_salary.dept_no
;