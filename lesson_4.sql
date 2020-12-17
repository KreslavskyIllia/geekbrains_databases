-- Создать на основе запросов, которые вы сделали в ДЗ к уроку 3, VIEW.
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `max_salary` AS
    SELECT 
        `e`.`emp_no` AS `emp_no`,
        CONCAT(`e`.`last_name`, ', ', `e`.`first_name`) AS `full_name`,
        MAX(`s`.`salary`) AS `max_salary`
    FROM
        (`employees` `e`
        JOIN `salaries` `s` ON ((`e`.`emp_no` = `s`.`emp_no`)))
    GROUP BY `s`.`emp_no`


-- Создать функцию, которая найдет менеджера по имени и фамилии
USE `employees`;
DROP function IF EXISTS `find_manager_no`;

DELIMITER $$
USE `employees`$$
CREATE FUNCTION `find_manager_no`(first_name VARCHAR(25), last_name varchar(25)) 
RETURNS INT DETERMINISTIC
BEGIN
DECLARE emp_no INT;
SELECT 
    dm.emp_no
INTO emp_no FROM
    dept_manager dm
        JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    e.first_name = first_name
        AND e.last_name = last_name;
RETURN emp_no;
END$$

DELIMITER ;

-- Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись в таблицу salary
DROP TRIGGER IF EXISTS `employees`.`employees_AFTER_INSERT`;

DELIMITER $$
USE `employees`$$
CREATE DEFINER = CURRENT_USER TRIGGER `employees`.`employees_AFTER_INSERT` AFTER INSERT ON `employees` FOR EACH ROW
BEGIN
INSERT INTO salaries SET emp_no = NEW.emp_no, salary = '5000', from_date = current_date(), to_date = current_date();
END$$
DELIMITER ;

