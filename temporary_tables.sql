/* Using the example from the lesson, create a temporary table called 
employees_with_departments that contains first_name, last_name, 
and dept_name for employees currently with that department. 
Be absolutely sure to create this table on your own database. 
If you see "Access denied for user ...", it means that the query was 
attempting to write a new table to a database that you can only read.
*/
USE leavitt_1858;
CREATE TEMPORARY TABLE employees_copy(SELECT * 
					FROM employees.employees
                    JOIN employees.dept_emp
						USING (emp_no)
					JOIN employees.departments
						USING (dept_no)
                    );
-- Add a column named full_name to this table. 
-- It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_copy ADD Full_Name VARCHAR(50);
-- ALTER TABLE employees_copy DROP COLUMN Full_Name;
-- Update the table so that full name column contains the correct data
UPDATE employees_copy SET Full_Name = CONCAT(first_name, " ", last_name);

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_copy DROP COLUMN first_name , DROP COLUMN last_name;
SELECT * FROM employees_copy;
-- What is another way you could have ended up with this same table?
-- joins and concat

-- Create a temporary table based on the payment table from the sakila database.
-- Write the SQL necessary to transform the amount column such that it is stored 
-- as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
USE sakila;
SHOW TABLES;
USE leavitt_1858;
CREATE TEMPORARY TABLE payment_copy(SELECT * 
					FROM sakila.payment);
SELECT round(amount * 100)
	from payment_copy;

-- Find out how the current average pay in each department compares to the overall 
-- current pay for everyone at the company. In order to make the comparison easier, 
-- you should use the Z-score for salaries. 
-- In terms of salary, what is the best department right now to work for? The worst?
USE leavitt_1858;
DROP TEMPORARY TABLE employees_copy;
CREATE TEMPORARY TABLE employees_copy(SELECT dept_name, avg(salary) as dept_avg
					FROM employees.employees
                    JOIN employees.salaries
						USING (emp_no)
                    JOIN employees.dept_emp
						USING (emp_no)
					JOIN employees.departments
						USING (dept_no)
					WHERE employees.salaries.to_date > now()
                    GROUP BY dept_name
                    );
SELECT * FROM employees_copy;

ALTER table employees_copy
	ADD all_avg float (8,0);
ALTER table employees_copy
	ADD all_std float (8,0);
SELECT * FROM employees_copy;

UPDATE employees_copy
	SET all_avg = (SELECT avg(salary) as allCurrAvgSal
FROM employees.salaries
WHERE salaries.to_date > now()
);

UPDATE employees_copy
	SET all_std = (SELECT stddev(salary) as stdcurrentSal
FROM employees.salaries
WHERE salaries.to_date > now()
)
    ;
SELECT * FROM employees_copy;
SELECT dept_name, 
	dept_avg,
     all_avg,all_std,
     ((dept_avg-all_avg)/all_std) as zscore
 FROM employees_copy
 ORDER BY zscore desc;

/*
-- getting average of all current    
DROP TABLE IF EXISTS all_avg;
CREATE TEMPORARY TABLE all_avg (                
SELECT to_date,avg(salary) as allCurrAvgSal
FROM employees.salaries
WHERE salaries.to_date > now()
);
-- getting average of dept
DROP TABLE IF EXISTS dept_avg;
CREATE TEMPORARY TABLE dept_avg (
SELECT  dept_name, dept_no, avg(salaries.salary) AS avgDeptSal
FROM employees_copy
JOIN employees.salaries
	USING (emp_no) 
WHERE salaries.to_date > now()
GROUP BY dept_name, dept_no
);
-- Consider that the following code will produce the z score for current salaries.
SELECT employees.salaries.salary AS sal1,
    (employees.salaries.salary - (SELECT AVG(employees.salaries.salary) FROM employees.salaries))
    /
    (SELECT stddev(employees.salaries.salary) FROM employees.salaries) AS zscore
FROM employees.salaries;

/*
CREATE TEMPORARY TABLE zSal(
	SELECT employees.salaries.salary AS sal1,
    (employees.salaries.salary - (SELECT AVG(employees.salaries.salary) FROM employees.salaries))
    /
    (SELECT stddev(employees.salaries.salary) FROM employees.salaries) AS zscore
FROM employees.salaries)
; */



