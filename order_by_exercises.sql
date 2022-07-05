-- use ORDER BY clauses to create more complex queries for our database
use employees; -- database
-- show tables;
-- select * from employees;


-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY first_name;
-- Irena Reutenauer, Vidya Simmen

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
-- and order your results returned by first name and then last name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY first_name, last_name;
-- Irena Acton, Vidya Zweizig

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and 
-- order your results returned by last name and then first name. 
-- In your comments, answer: What was the first and last name in the first row of the results? 
-- What was the first and last name of the last person in the table?
SELECT first_name, last_name
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
ORDER BY last_name, first_name;
-- Irena Acton, Maya Zyda

/* Write a query to to find all employees whose last name starts and ends with 'E'. 
Sort the results by their employee number. Enter a comment with the number of employees returned, 
the first employee number and their first and last name,  
and the last employee number with their first and last name */
SELECT *
FROM employees
WHERE last_name LIKE "%E"
AND last_name LIKE "E%"
ORDER BY emp_no
LIMIT 1000000;
-- 899 - [[10021,'Ramzi Erde'],[499648,'Tadahiro Erde']]

/* Write a query to to find all employees whose last name starts and ends with 'E'. 
Sort the results by their hire date, so that the newest employees are listed first. 
Enter a comment with the number of employees returned, the name of the newest employee, 
and the name of the oldest employee. */
SELECT *
FROM employees
WHERE last_name LIKE "%E"
AND last_name LIKE "E%"
ORDER BY hire_date DESC
LIMIT 1000000;
-- 899 - TEIJI ELDRIDGE, SERGI ERDE

-- Find all employees hired in the 90s and born on Christmas. 
-- Sort the results so that the oldest employee who was hired last is the first result. 
-- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, 
-- and the name of the youngest employee who was hired first
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY birth_date ASC, hire_date DESC
LIMIT 1000000;
-- 362 - Khun Bernini, Douadi Pettis



