-- viewing data
SELECT * FROM employee; 

SELECT employee_id, first_name, last_name
FROM employee;

SELECT department_id, department_name
FROM department;

SELECT employee_id, first_name, last_name
FROM employee
WHERE first_name = 'Jessica';

SELECT employee_id, first_name, last_name
FROM employee
WHERE last_name = 'Jones';

SELECT employee_id, first_name, last_name
FROM employee
WHERE last_name <> 'Jones';

SELECT employee_id, first_name, last_name
FROM employee
WHERE employee_id > 5;


SELECT employee_id, first_name, last_name
FROM employee
WHERE employee_id <= 8;

SELECT employee_id, first_name, last_name
FROM employee
WHERE last_name LIKE 'Bu%';

SELECT employee_id, first_name, last_name
FROM employee
WHERE last_name LIKE '%e%';

SELECT employee_id, first_name, last_name
FROM employee
WHERE last_name LIKE 'Ann_';

SELECT *
FROM employee
WHERE hire_date = '03-OCT=2010'; 

SELECT *
FROM employee
WHERE hire_date > '03-OCT-2010'; 

SELECT *
FROM employee
WHERE hire_date < '03-OCT-2010'; 

SELECT employee_id, first_name, last_name
FROM employee
WHERE first_name = 'John' AND last_name = 'Hayes';


SELECT employee_id, first_name, last_name
FROM employee
WHERE first_name = 'Justin' OR last_name = 'Little';


SELECT employee_id, first_name, last_name
FROM employee
WHERE first_name = 'Barbara'
AND hire_date < '01-DEC-2014'
AND salary < 70000;

SELECT employee_id, first_name, last_name
FROM employee
WHERE salary IS NULL;

SELECT employee_id, first_name, last_name
FROM employee
WHERE salary IS NOT NULL;

SELECT DISTINCT first_name, last_name
FROM employee;

-- more operators
SELECT first_name, last_name, hire_date, salary
FROM employee
WHERE last_name IN ('Foster', 'Elliot', 'Perry');

SELECT first_name, last_name, hire_date, salary
FROM employee
WHERE last_name NOT IN ('Foster', 'Elliot', 'Perry');

SELECT employee_id, first_name, last_name
FROM employee
WHERE employee_id BETWEEN 10 AND 20;

SELECT employee_id, first_name, last_name
FROM employee
WHERE salary > ALL(30000, 40000, 50000);

SELECT employee_id, first_name, last_name
FROM employee
WHERE salary = ANY(30000, 40000, 50000);

-- sorting data
SELECT first_name, last_name, hire_date, salary
FROM employee
ORDER BY last_name DESC;

SELECT first_name, last_name, hire_date, salary
FROM employee
ORDER BY hire_date ASC;

SELECT first_name, last_name, hire_date, salary
FROM employee
ORDER BY last_name DESC, first_name ASC;

-- set operators
SELECT first_name, last_name
FROM employee
UNION
SELECT first_name, last_name
FROM customer;


SELECT 'Employee' first_name, last_name
FROM employee
UNION -- union remove duplicat
SELECT 'Customer' first_name, last_name
FROM customer;

SELECT 'Employee' first_name, last_name
FROM employee
UNION
SELECT 'Customer' first_name, last_name
FROM customer
ORDER BY 1,2;

SELECT 'Employee' first_name, last_name
FROM employee
UNION ALL -- union all does not remove duplicat
SELECT 'Customer' first_name, last_name
FROM customer;

SELECT first_name, last_name
FROM employee
INTERSECT
SELECT first_name, last_name
FROM customer;


SELECT first_name, last_name
FROM employee
MINUS
SELECT first_name, last_name
FROM customer;

-- aggregate funtions and grouping
SELECT COUNT(*)
FROM employee;

SELECT COUNT(*)
FROM employee
WHERE first_name = 'Barbara';


SELECT COUNT(salary)
FROM employee;

SELECT COUNT(DISTINCT last_name)
FROM employee;

SELECT last_name, COUNT(*)
FROM employee
GROUP BY last_name;

SELECT department_id, COUNT(*)
FROM product
GROUP BY department_id;

SELECT last_name, COUNT(*)
FROM employee
WHERE last_name LIKE 'B%'
GROUP BY last_name;


SELECT salary, COUNT(*)
FROM employee
WHERE salary > 10000
GROUP BY salary
ORDER BY COUNT(*) DESC;

SELECT last_name, department_id, COUNT(*)
FROM employee
GROUP BY last_name, department_id
ORDER BY last_name DESC;

SELECT last_name, COUNT(*)
FROM employee
GROUP BY last_name
HAVING COUNT(*) > 1;

SELECT SUM(salary)
FROM employee;

SELECT department_id SUM(salary)
FROM employee
GROUP BY department_id
ORDER BY SUM(salary) DESC;

SELECT MAX(salary), MIN(salary)
FROM employee;

SELECT department_id MAX(salary)
FROM employee
GROUP BY department_id;

SELECT MAX(hire_date)
FROM employee;

SELECT AVG(salary)
FROM employee;

SELECT department_id AVG(salary)
FROM employee
GROUP BY department_id;

-- joins
SELECT employee_id,
 first_name, last_name,
 E.SALARY AS annual_salary
 e.salary/12 AS monthly_salary
FROM employee e
WHERE E.SALARY < 30000;



-- functions
SELECT customer_id, 
first_name, 
last_name, 
email_address,
address_state,
INSTR(email_address, '@'),
LENGTH(address_state)
FROM customer
WHERE INSTR(email_address, '@') > 0
AND LENGTH(address_state) = 2;

SELECT customer_id, 
first_name, 
last_name, 
email_address,
address_state,
INSTR(email_address, '@'),
SUBSTR(email_address, INSTR(email_address, '@') + 1, LENGTH(email_address)) AS email_domain
FROM customer;


SELECT product_id,
product_name,
price,
ROUND(price)
ROUND(price, 1)
CEIL(price)
FLOOR(price)
FROM product;

SELECT employee_id,
first_name,
last_name,
hire_date,
ADD_MONTHS(hire_date, 6) AS review_date
MONTHS_BETWEEN(SYSDATE, hire_date) AS time_with_date
FROM employee;

SELECT first_name,
last_name,
hire_date,
TO_CHAR(hire_date, 'YYYY_MM_DD')
FROM employee;

SELECT TO_NUMBER('200') FROM dual;

SELECT product_id,
product_name,
price,
CASE
WHEN price > 100 THEN 'Over 100'
WHEN price > 100 THEN 'over 200'
ELSE 'other'
END price_group
FROM product;


-- subqueries
SELECT employee_id, first_name, last_name, salary
FROM employee
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
);

SELECT employee_id, first_name, last_name, department_id
FROM employee
WHERE department_id IN (
    SELECT department_id
    FROM department
    WHERE department_name IN ('Sales', 'Finance')
);


-- inserting, updating and deleting data
INSERT INTO employee(employee_id, first_name, last_name, department_id)
VALUES (300, 'John', 'Smith', 3);


INSERT ALL
INTO employee(employee_id, first_name, last_name, department_id)
VALUES (301, 'Simon', 'Fletcher', 4)
INTO employee(employee_id, first_name, last_name, department_id)
VALUES (302, 'Alison', 'Smith', 3)
SELECT * FROM dual;

INSERT INTO employee(employee_id, first_name, last_name, department_id)
SELECT 250, first_name, last_name
FROM customer
WHERE customer_id = 1;

UPDATE employee
SET salary = salary + 10000
WHERE employee_id = 85;

UPDATE employee
SET manager_id = 30, 
salary = salary + 50000
WHERE employee_id in (102, 59, 16);

DELETE FROM employee
WHERE employee_id = 250;

COMMIT;

ROLLBACK;

TRUNCATE TABLE customer_order;


-- creating, altering, and dropping data
CREATE TABLE job_role (
    job_role_id NUMBER(10),
    role_name VARCHAR(50),
    role_create_date DATE
);

ALTER TABLE job_role
ADD job_description VARCHAR2(100);

ALTER TABLE job_role
DROP COLUMN job_description;

ALTER TABLE job_role
RENAME COLUMN role_name TO job_title;

DROP TABLE job_title;



