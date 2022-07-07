-- use join, left join, and right join statements
-- Integrate aggregate functions and clauses into our queries with JOIN statements

-- Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;
SHOW tables;
SELECT *
	FROM users -- 6
;
SELECT *
	FROM roles -- 4
;

-- Use join, left join, and right join to combine results from the 
-- users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.
-- 4 (only 4 unique in right roles, and it's basically an intersect using the min index?)
Select *
	FROM roles r
	JOIN users u -- basic right join
		ON u.role_id = r.id -- only a statement of equivalancy, order doesn't really matter
;
-- 5 (left table will show all results, duplicating where applicable (2 users had same role))
Select *
	FROM roles r
    LEFT JOIN users u -- basic right join
		ON u.role_id = r.id -- only a statement of equivalancy, order doesn't really matter
;
-- 6 (going to show all of right table, dup where applicable (n/a))
Select *
	FROM roles r
    RIGHT JOIN users u -- basic right join
		ON u.role_id = r.id -- only a statement of equivalancy, order doesn't really matter
;

-- Although not explicitly covered in the lesson, 
-- aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles 
-- along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.
SELECT roles.name, COUNT(ISNULL(users.role_id)) as NumberInRole
	FROM roles
    RIGHT JOIN users -- basic right join
		ON users.role_id = roles.id -- only a statement of equivalancy, order doesn't really matter
	GROUP BY roles.name
;

-- Use the employees database.
USE employees;


-- Using the example in the Associative Table Joins section as a guide, 
-- write a query that shows each department along with the name of the current manager for that department
SELECT departments.dept_name, CONCAT(employees.first_name," ",employees.last_name) AS DeptManager
	FROM departments
	JOIN dept_manager
		ON departments.dept_no = dept_manager.dept_no
        AND dept_manager.to_date like "9999%"
	JOIN employees
		USING (emp_no)
	ORDER BY dept_name
;
-- Find the name of all departments currently managed by women
SELECT 
departments.dept_name, CONCAT(employees.first_name," ",employees.last_name) AS DeptManager -- , employees.gender
	FROM departments
	JOIN dept_manager
		ON departments.dept_no = dept_manager.dept_no
	JOIN employees
		USING (emp_no)
	WHERE employees.gender = "f" 
		AND dept_manager.to_date like "9999%"
	ORDER BY dept_name
;

-- Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title, count(titles.title)
	FROM employees
    JOIN dept_emp
		USING (emp_no)
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN titles
		USING (emp_no)
	WHERE titles.to_date like "9999%"
		AND departments.dept_name = "Customer Service"
	GROUP BY titles.title
    ORDER BY titles.title
;

-- Find the current salary of all current managers
SELECT departments.dept_name, CONCAT(employees.first_name," ",employees.last_name) AS DeptManager, salaries.salary
	FROM employees
    JOIN dept_manager
		USING (emp_no)
	JOIN salaries
		USING (emp_no)
	JOIN departments
		ON departments.dept_no = dept_manager.dept_no
	WHERE dept_manager.to_date like "9999%"
		AND salaries.to_date like "9999%"
    ORDER BY departments.dept_name
;

-- Find the number of current employees in each department.
SELECT dept_emp.dept_no, departments.dept_name, count(employees.emp_no)
	FROM employees
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	WHERE dept_emp.to_date like "9999%"
    GROUP BY dept_emp.dept_no
    ORDER BY dept_emp.dept_no
;

-- Which department has the highest average salary? Hint: Use current not historic information.
SELECT  departments.dept_name as dept_name, avg(salaries.salary) AS average_salary
	FROM employees
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		USING (emp_no)
	WHERE dept_emp.to_date like "9999%"
		AND salaries.to_date like "9999%"
    GROUP BY departments.dept_name
    ORDER BY average_salary DESC
    LIMIT 1
;

-- Who is the highest paid employee in the Marketing department?
SELECT employees.first_name, employees.last_name
	FROM employees
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		USING (emp_no)
	WHERE departments.dept_name = "Marketing"
		AND salaries.to_date LIKE "9999%"
	ORDER BY salaries.salary DESC
    LIMIT 1
;

-- Which current department manager has the highest salary?
SELECT  employees.first_name, employees.last_name, salaries.salary, departments.dept_name
	FROM employees
    JOIN dept_manager
		USING (emp_no)
	JOIN salaries
		USING (emp_no)
	JOIN departments
		ON departments.dept_no = dept_manager.dept_no
	WHERE dept_manager.to_date like "9999%"
		AND salaries.to_date like "9999%"
    ORDER BY salaries.salary DESC
    LIMIT 1
;

-- Determine the average salary for each department. Use all salary information and round your results
SELECT  departments.dept_name as dept_name, ROUND(AVG(salaries.salary),0)  AS average_salary
	FROM employees
	JOIN dept_emp
		USING (emp_no)
	JOIN departments
		ON departments.dept_no = dept_emp.dept_no
	JOIN salaries
		USING (emp_no)
	-- WHERE dept_emp.to_date like "9999%"
		-- AND salaries.to_date like "9999%"
    GROUP BY departments.dept_name
    ORDER BY average_salary DESC
;

-- Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(employees.first_name," ",employees.last_name) as "Employee_Name", 
		departments.dept_name AS "Department_Name", 
		DeptManager
	FROM
		(
		SELECT departments.dept_no, CONCAT(employees.first_name," ",employees.last_name) AS DeptManager
		FROM departments
		JOIN dept_manager
			ON departments.dept_no = dept_manager.dept_no
			AND dept_manager.to_date like "9999%"
		JOIN employees
			USING (emp_no)
		) AS query1
	
	JOIN departments
		USING (dept_no)
	JOIN dept_emp
		USING (dept_no) 
	JOIN employees
		USING (emp_no)
	WHERE dept_emp.to_date 
		LIKE "9999%"
	ORDER BY DeptManager DESC 
    LIMIT 5000000 
;

/* Different approach (did not finish)
SELECT  CONCAT(employees.first_name," ",employees.last_name) as "Manager_Name",
		departments.dept_name AS "Department_Name", 
		CONCAT(emp2.first_name, " ", emp2.last_name) as "Employee_Name"
	FROM dept_manager
	JOIN employees
		USING (emp_no)
	JOIN departments
		USING (dept_no)
	JOIN salaries
		USING (emp_no)
	JOIN dept_emp
		USING (dept_no) 
	JOIN employees as emp2
		on emp2.emp_no = dept_emp.emp_no
	
	WHERE dept_manager.to_date LIKE "9999%"
        AND salaries.to_date LIKE "9999%"
	-- GROUP BY Manager_Name, Department_Name, Employee_Name
	ORDER BY departments.dept_name DESC 
    LIMIT 5000000 
;
*/

-- Who is the highest paid employee within each department.
SELECT dept_name, MaxSal, Names
	FROM
		( 
		SELECT departments.dept_name, departments.dept_no, MAX(salaries.salary) AS MaxSal
		FROM employees
		JOIN dept_emp
			USING (emp_no)
		JOIN departments
			ON departments.dept_no = dept_emp.dept_no
		JOIN salaries
			USING (emp_no)
		WHERE salaries.to_date LIKE "9999%"
		GROUP BY departments.dept_name 
		) AS query2
	
    JOIN
		(
		SELECT CONCAT(employees.first_name," ", employees.last_name) AS Names, dept_emp.dept_no AS currentDepartment, salaries.salary AS CurrentSalary
		FROM employees
		JOIN salaries
			USING (emp_no)
		JOIN dept_emp
			USING (emp_no)
		WHERE 
				dept_emp.to_date like "9999%"
			AND 
				salaries.to_date like "9999%"
		) AS query3
    ON query3.currentDepartment = query2.dept_no
	
    WHERE MaxSal = CurrentSalary
    ORDER BY dept_name
;

/*
SHOW tables;  -- (departments, dept_emp,dept_manager,employees,salaries,titles)
DESCRIBE departments; -- (dept_no (pri), dept_name (uni)) | indexes-primary,dept_name
DESCRIBE dept_emp; -- emp_no (pri), dept_no (pri), from_date, to_date | index-primary,dept_no
DESCRIBE dept_manager; -- emp_no (pri), dept_no (pri), from_date, to_date | index-primary,dept_no
DESCRIBE employees; -- emp_no (pri), birth_date, first_name, last_name, gender, hire_date | index-primary
DESCRIBE salaries; -- emp_no(pri), salary, from_date (pri), to_date | index-primary
DESCRIBE titles; -- emp_no(pri), title(pri), from_date(pri), to_date | index-primary
*/