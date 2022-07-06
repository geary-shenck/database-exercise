-- use ORDER BY clauses to create more complex queries for our database
use employees; -- database
-- show tables;
-- select * from employees;


-- Write a query to to find all employees whose last name starts and ends with 'E'. 
-- Use concat() to combine their first and last name together as a single column named full_name.
SELECT CONCAT(first_name,last_name) AS "full_name"
FROM employees
WHERE last_name LIKE "E%E";

-- Convert the names produced in your last query to all uppercase.
SELECT UPPER(CONCAT(first_name,last_name)) AS "full_name"
FROM employees
WHERE last_name LIKE "E%E";




/* Find all employees hired in the 90s and born on Christmas. 
Use datediff() function to find how many days they have been working at the company 
(Hint: You will also need to use NOW() or CURDATE()) */
SELECT *,
DATEDIFF (NOW(),hire_date) AS DAYS_SINCE_HIRED
FROM employees
WHERE birth_date LIKE '%12-25'
	AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- Find the smallest and largest current salary from the salaries table
SELECT max(salary),min(salary)
FROM salaries
where to_date >= now();
-- 158,220 | 38,623


/* Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born. */
SELECT
LOWER(
	CONCAT(
		SUBSTR(first_name,1,1),
		SUBSTR(last_name,1,4),
		"_",
        SUBSTR((birth_date),6,2),
		-- CAST(MONTHNAME(birth_date) AS CHAR),
		SUBSTR(YEAR(birth_date),3,2)
		)
	) 
AS USERNAME, first_name, last_name, birth_date
FROM employees;

SELECT MONTHNAME(birth_date) AS MONTH
FROM employees;