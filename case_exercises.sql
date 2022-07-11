use employees;

/* Write a query that returns all employees, their department number, 
their start date, their end date, and a new column 'is_current_employee' 
that is a 1 if the employee is still with the company and 0 if not. */

SELECT 
	emp_no, dept_no, from_date started, to_date ending, to_date>now() is_current_employee
FROM dept_emp
        ;
 
-- Write a query that returns all employee names (previous and current), 
-- and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' 
-- depending on the first letter of their last name.
SELECT 
	CONCAT (first_name, " ", last_name)fullName,
    CASE -- doing it this way only works because it exits on match
        WHEN SUBSTR(last_name, 1,1) <= 'H' THEN 'A-H'
        WHEN SUBSTR(last_name, 1,1) <= 'Q' THEN 'I-Q'
        WHEN SUBSTR(last_name, 1,1) <= 'Z' THEN 'R-Z'
    END AS alpha_group
FROM employees;


-- How many employees (current or previous) were born in each decade?
SELECT CONCAT(SUBSTR(birth_date, 1, 3), '0s') AS 19XXs, COUNT(*) AS Amount
FROM employees
GROUP BY 19XXs;