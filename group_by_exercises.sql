-- use the GROUP BY clause to create more complex queries 

USE employees; -- database

-- In your script, use DISTINCT to find the unique titles in the titles table. 
-- How many unique titles have there ever been? 
-- Answer that in a comment in your SQL file.
SELECT DISTINCT title
FROM titles;
-- 7

-- Write a query to to find a list of all unique last names of all employees 
-- that start and end with 'E' using GROUP BY
SELECT last_name
FROM employees
WHERE last_name LIKE "E%E"
GROUP BY last_name;
-- 5

-- Write a query to to find all unique combinations of first and last names of 
-- all employees whose last names start and end with 'E'.
SELECT first_name,last_name
FROM employees
WHERE last_name LIKE "E%E"
GROUP BY last_name, first_name
ORDER BY last_name;
-- 846

-- Write a query to find the unique last names with a 'q' but not 'qu'. 
-- Include those names in a comment in your sql code.
SELECT last_name
FROM employees
WHERE last_name LIKE "%q%"
	AND NOT last_name LIKE "%qu%"
GROUP BY last_name;
-- Chleq, Lindqvist, Qiwen

-- Add a COUNT() to your results (the query above) to find the 
-- number of employees with the same last name.
SELECT last_name, COUNT(last_name) as "Count"
FROM employees
WHERE last_name LIKE "%q%"
	AND NOT last_name LIKE "%qu%"
GROUP BY last_name;
-- chleq - 189, lindqvist - 190, qiwen - 168

-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
-- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
/* 
SELECT first_name, SUM(if (gender = "M",1,0)) AS MALE, SUM(if (gender = "F",1,0))AS FEMALE
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
GROUP BY first_name
ORDER BY first_name; 
------------------------ */
SELECT first_name, gender, COUNT(gender)
FROM employees
WHERE gender IN ('M','F')
	AND first_name IN ('Irena','Vidya','Maya')
GROUP BY first_name, gender
ORDER BY first_name;
--

SELECT gender, COUNT(*)
FROM employees
WHERE gender IN ('M','F')
	AND first_name IN ('Irena','Vidya','Maya')
GROUP BY gender;
-- M-441, F-228


-- Using your query that generates a username for all of the employees, 
-- generate a count employees for each unique username. 
-- Are there any duplicate usernames? 
-- BONUS: How many duplicate usernames are there?
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
AS USERNAME, COUNT(*)
FROM employees
GROUP BY USERNAME
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC
LIMIT 500000;
-- 13,251 duplicate user names

SELECT SUM(CNT) AS TTL_DUPED_INDIVIDUAL
FROM (
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
		AS USERNAME, COUNT(*) AS CNT
		FROM employees
		GROUP BY USERNAME
		HAVING COUNT(*) > 1
		ORDER BY COUNT(*) DESC
		LIMIT 500000
	) AS origin;
-- 27,403

-- Determine the historic average salary for each employee. 
SELECT emp_no, AVG(salary) AS AvgSal
FROM salaries
GROUP BY emp_no;

-- Using the dept_emp table, count how many current employees work in each department. 
-- The query result should show 9 rows, one for each department and the employee count.
SELECT dept_no, COUNT(dept_no) as Number_of_Emplees
FROM dept_emp
GROUP BY dept_no;

-- Determine how many different salaries each employee has had. 
-- This includes both historic and current.
SELECT emp_no, COUNT(emp_no) as UniqueSalaries
FROM salaries
GROUP BY emp_no
;

-- Find the maximum salary for each employee
SELECT emp_no, MAX(salary) as MaxSalary
FROM salaries
GROUP BY emp_no
;

-- Find the minimum salary for each employee
SELECT emp_no, MIN(salary) as MinSalary
FROM salaries
GROUP BY emp_no
;

-- Find the standard deviation of salary for each employee
SELECT emp_no, STDDEV(salary) as Stdev_Salary
FROM salaries
GROUP BY emp_no
;

-- Now find the max salary for each employee where that max salary is greater than $150,000
SELECT emp_no, MAX(salary) as MaxSalary
FROM salaries
GROUP BY emp_no
HAVING MaxSalary > 150000
;

-- Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, AVG(salary) as AvgSalary
	FROM salaries
	GROUP BY emp_no
	HAVING AvgSalary > 80000 and AvgSalary < 90000
	ORDER BY AvgSalary
/*
SELECT * FROM
(
	SELECT emp_no, avg(salary) as AvgSalary1
	FROM salaries
	GROUP BY emp_no
	HAVING AvgSalary1 > 80000 and AvgSalary1 < 90000
	ORDER BY AvgSalary1 ASC
	Limit 5
) AS Lower_5
UNION
SELECT * FROM
(
	SELECT emp_no, avg(salary) as AvgSalary2
	FROM salaries
	GROUP BY emp_no
	HAVING AvgSalary2 > 80000 and AvgSalary2 < 90000
	ORDER BY AvgSalary2 DESC
Limit 5
) AS Upper_5
;
*/


/* 
SELECT (identifies column(s))
FROM (identifies table)
where (locigaical conditions, record filtering criteria)
group by (column name, )
having (logical condition)
order by (specifies order of results)
*/