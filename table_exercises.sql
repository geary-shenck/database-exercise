-- codeup exercise for tables
use employees;

show tables;
-- departments, dept_emp, dept_manager, employees, salaries, titles

describe employees;
-- int, date, varchar(14), var(16), enum('M','F')

describe employees;
describe departments;
DESCRIBE dept_emp;
describe dept_manager;
describe employees;
describe salaries;
describe titles;

-- Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
-- 	salaries, departments, employees, dept_emp, dept_manager, titles
-- Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- 	departments, dept_manager, employees, titles, dept_emp, titles
-- Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- 	dept_emp, employees, dept_manager, salaries, titles
-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- 	departments is a table within the employees database, employees is also a table within the employees database
-- Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
-- 	show create table dept_manager;
show create table dept_manager;