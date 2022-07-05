-- query our sample database using the WHERE clauses
use employees; -- database
-- show tables;
-- select * from employees;

-- Find all current or previous employees with first names 'Irena', 'Vidya', 
-- or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya');
-- 709

/* Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, 
but use OR instead of IN. Enter a comment with the number of records returned. 
Does it match number of rows from Q2? */
SELECT *
From employees
WHERE  first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya';
-- 709, matches

/* Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, 
and who is male. Enter a comment with the number of records returned */
SELECT *
FROM employees
WHERE  gender = "M"
AND (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya');
-- 441

-- Find all current or previous employees whose last name starts with 'E'. 
-- Enter a comment with the number of employees whose last name starts with E
SELECT *
FROM employees
WHERE last_name like "E%"
LIMIT 10000;
-- 7330

/* Find all current or previous employees whose last name starts or ends with 'E'. 
Enter a comment with the number of employees whose last name starts or ends with E. 
How many employees have a last name that ends with E, but does not start with E */
SELECT *
FROM employees
WHERE last_name LIKE "%E"
OR last_name LIKE "E%"
LIMIT 1000000;
-- 30,723
SELECT *
FROM employees
WHERE last_name LIKE "%E"
LIMIT 1000000;
-- 24,292

-- Find all current or previous employees employees whose last name starts and ends with 'E'. 
-- Enter a comment with the number of employees whose last name starts and ends with E. 
-- How many employees' last names end with E, regardless of whether they start with E?
SELECT *
FROM employees
WHERE last_name LIKE "%E"
AND last_name LIKE "E%"
LIMIT 1000000;
-- 899
-- 24,292 (see above)

-- Find all current or previous employees hired in the 90s. 
-- Enter a comment with the number of employees returned.
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
LIMIT 1000000;
-- 135,214

-- Find all current or previous employees born on Christmas. 
-- Enter a comment with the number of employees returned
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
LIMIT 1000000;
-- 842

-- Find all current or previous employees hired in the 90s and born on Christmas. 
-- Enter a comment with the number of employees returned
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
LIMIT 1000000;
-- 362

-- Find all current or previous employees with a 'q' in their last name. 
-- Enter a comment with the number of records returned
SELECT *
FROM employees
WHERE last_name like "%Q%"
LIMIT 100000;
-- 1873

-- Find all current or previous employees with a 'q' in their last name but not 'qu'. 
-- How many employees are found?
SELECT *
FROM employees
WHERE last_name LIKE "%Q%"
AND NOT last_name LIKE "%QU%"
LIMIT 100000;
-- 547

SELECT *
FROM employees
LIMIT 500000;
-- 300,024