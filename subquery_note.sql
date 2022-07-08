
USE employees;
-- Find all the current employees with the same hire date as employee 101010 using a sub-query
-- inner
SELECT employees.hire_date
	FROM employees
	WHERE employees.emp_no = "101010";
-- outer
SELECT employees.first_name,employees.last_name,employees.emp_no
	FROM employees
    JOIN salaries
		USING (emp_no)
	WHERE employees.hire_date = '1990-10-22'
    AND salaries.to_date > now()
;
-- joined
SELECT employees.first_name,employees.last_name,employees.emp_no
	FROM employees
    JOIN salaries
		USING (emp_no)
	WHERE employees.hire_date = (
								SELECT employees.hire_date
									FROM employees
									WHERE employees.emp_no = "101010"
								)
    AND salaries.to_date > now()
;

-- Find all the titles ever held by all current employees with the first name Aamod
-- inner
SELECT employees.emp_no
	FROM employees
	WHERE employees.first_name = "Aamod"
;
-- outer
SELECT  titles.title
	FROM employees
    JOIN titles
		USING (emp_no)
	JOIN salaries
		USING (emp_no)
	WHERE employees.emp_no IN ('10346','11973')
		AND salaries.to_date > now()
;
-- joined
SELECT DISTINCT titles.title, employees.first_name, salaries.to_date as Currently_Paid
	FROM employees
    JOIN titles
		USING (emp_no)
	JOIN salaries
		USING (emp_no)
	WHERE employees.emp_no IN (SELECT employees.emp_no
								FROM employees
								WHERE employees.first_name = "Aamod"
                                ) 
		AND salaries.to_date > now()
;

-- How many people in the employees table are no longer working for the company? 
-- Give the answer in a comment in your code
-- inner
SELECT emp_no -- , max(to_date)
	FROM salaries
         -- WHERE salaries.to_date < now()
	GROUP BY emp_no
		HAVING MAX(to_date) < now()
	LIMIT 500000
;
-- outer
SELECT COUNT(emp_no)
	FROM salaries
    WHERE emp_no = "10008"
;
-- joined
SELECT COUNT(emp_no)
	FROM (
					SELECT emp_no
						FROM salaries
						GROUP BY emp_no
							HAVING MAX(to_date) < now()
					) as query3
;
-- 59900

-- Find all the current department managers that are female. 
-- List their names in a comment in your code
SELECT concat (first_name, " ", last_name) as names
	FROM (SELECT emp_no
			FROM employees
			WHERE gender = "F"
			) as q5
    JOIN dept_manager
		using (emp_no)
	JOIN employees
		USING (emp_no)
	JOIN departments
		USING (dept_no)
	WHERE dept_manager.to_date > NOW()
;
-- ISAMU LEGLEITNER, KARSTEN SIGSTAM, LEON DASSARMA, HILARY KAMBIL

-- Find all the employees who currently have a higher salary than 
-- the companies overall, historical average salary.
-- inner
SELECT AVG(salary)
	FROM salaries
;
-- outer
SELECT *
	FROM employees
	JOIN salaries
		USING (emp_no)
	WHERE salaries.to_date > now()
		HAVING salary > 63810
;
-- joined
SELECT *
	FROM employees
	JOIN salaries
		USING (emp_no)
	WHERE salaries.to_date > now()
		HAVING salary > (SELECT AVG(salary)
							FROM salaries
						)
;

/* How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) 
What percentage of all salaries is this? */
-- inner 1
SELECT stddev(salary)
	FROM salaries
    WHERE to_date > now()
; -- 17310
-- inner 2
SELECT MAX(salary)
	FROM salaries
    WHERE to_date > now()
; -- 158220
SELECT (
	SELECT MAX(salary)
	FROM salaries
    WHERE to_date > now()
    )
    - 
    (
    SELECT stddev(salary)
	FROM salaries
    WHERE to_date > now()
    )
; -- 140910
-- outer
SELECT COUNT(salary)
	FROM salaries
    WHERE salary > (140000)
; -- 266
-- join 1
SELECT COUNT(salary)
	FROM salaries
    WHERE salary > (SELECT 
					(
					SELECT MAX(salary)
					FROM salaries
					WHERE to_date > now()
					)
					- 
					(
					SELECT stddev(salary)
					FROM salaries
					WHERE to_date > now()
					)
				   )
	and to_date > now()
; -- 83 
SELECT count(salary)
	FROM salaries
	WHERE to_date > now()
; -- 240124
-- final join
SELECT CONCAT(
(
SELECT COUNT(salary)
	FROM salaries
    WHERE salary > (SELECT 
					(
					SELECT MAX(salary)
					FROM salaries
					WHERE to_date > now()
					)
					- 
					(
					SELECT stddev(salary)
					FROM salaries
					WHERE to_date > now()
					)
				   )
	AND to_date > now()
) / (
	SELECT count(salary)
	FROM salaries
	WHERE to_date > now()
	) * 100, "%") AS Percent_above_1sig_From_Max
;
-- 0.0346%


-- Find all the department names that currently have female managers
SELECT dept_name
	FROM (SELECT emp_no
			FROM employees
			WHERE gender = "F"
			) as q5
    JOIN dept_manager
		using (emp_no)
	JOIN employees
		USING (emp_no)
	JOIN departments
		USING (dept_no)
	WHERE dept_manager.to_date > NOW()
;
-- development, finance, human resources, research

-- Find the first and last name of the employee with the highest salary
-- first query
SELECT MAX(salary)
		FROM salaries
		WHERE to_date > now();
-- last query
SELECT employees.first_name, employees.last_name
	FROM employees
    JOIN salaries
		USING (emp_no) 
    WHERE salary = (
					SELECT MAX(salary)
						FROM salaries
						WHERE to_date > now()
					)
;
-- Tokuyasu Pesch

-- Find the department name that the employee with the highest salary works in
SELECT departments.dept_name
	FROM dept_emp
	JOIN departments
		USING (dept_no)
    JOIN salaries
		USING (emp_no)
    WHERE salary = (
					SELECT MAX(salary)
						FROM salaries
						WHERE to_date > now()
					)
;
-- sales




/*
DESCRIBE departments; -- (dept_no (pri), dept_name (uni)) | indexes-primary,dept_name
DESCRIBE dept_emp; -- emp_no (pri), dept_no (pri), from_date, to_date | index-primary,dept_no
DESCRIBE dept_manager; -- emp_no (pri), dept_no (pri), from_date, to_date | index-primary,dept_no
DESCRIBE employees; -- emp_no (pri), birth_date, first_name, last_name, gender, hire_date | index-primary
DESCRIBE salaries; -- emp_no(pri), salary, from_date (pri), to_date | index-primary
DESCRIBE titles; -- emp_no(pri), title(pri), from_date(pri), to_date | index-primary
*/







/*    FROM customer_payements
    WHERE customer_id IN
						(select customer_id
						from customer_subscriptions
						where internet_service_type_id = 3)

-- inner query
	-- SELECT customer_id FROM customer_subscriptions WHERE internet_service_type_id = 3
-- outer query, TESTING
	-- SELECT customer_id, total_charges FROM customer_payments WHERE customer_id IN ('0023-UYUPN', '0030-FNXPX')

-- inner query
	-- SELECT AVG(total_charges) FROM customer_payments;
-- outer query - testing
	-- SELECT customer_id, monthly_charges, total_charges 
	-- FROM customer_payments 
    -- WHERE total_charges > (2279.73);
-- insert inner into outer
	-- SELECT customer_id, monthly_charges, total_charges 
	-- FROM customer_payments 
    -- WHERE total_charges > (SELECT AVG(total_charges) FROM customer_payments);
    
-- inner query
	-- SELECT customer_id, avg(monthly_charges) AS average_charges
		-- FROM customer_payments AS pay
        -- group by customer_id
-- outer query - testing
	-- SELECT sub.customer_id, sub.internet_sservice_type_id, ist.internet_service_type
		-- FROM customer_subscriptions AS sub
        -- join internet_service_types AS ist on sub.internet_service_type_id = ist.insternet_sercie_type_id;
        
        /*
		-- SELECT internet_service_type_id, internet_service_type
		-- FROM internet_service_type;
        */
-- inner into outer
	-- -- SELECT pay.customer_id, ist.internet_service_type, pay.average_charges
		-- FROM (SELECT customer_id, avg(monthly_charges) as average_charges
			-- from customer_payments
            -- group by customer_id
				-- ) AS pay
			-- join custoemr_subscriptions AS sub 
				-- ON pay.customer_id = ist.internet_sercvice_type_id
			-- join internet_service_type) ist 
            -- 	ON sub.internet_service_type_id=ist.internet_sercie_type_id;
		*/
        