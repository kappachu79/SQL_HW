

CREATE TABLE departments (
  dept_no VARCHAR(10),
  dept_name VARCHAR(30) NOT NULL,
  PRIMARY KEY (dept_no)
);

select * from departments

DROP TABLE employees

CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id varchar NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	sex VARCHAR(2) NOT NULL,
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

select * from employees

DROP TABLE dept_emp
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(10) NOT NULL,
	FOREIGN KEY (emp_no)  REFERENCES employees   (emp_no) ,
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no,dept_no)
	);

select * from dept_emp

DROP TABLE dept_managers

CREATE TABLE dept_managers (
 dept_no VARCHAR (10),
 emp_no INT,
 FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
 FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

select * from dept_managers

--Creating salaries table
DROP TABLE salaries
CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
	
);

select * from salaries

--Creating titles table
DROP TABLE titles

CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR(20) NOT NULL
	
);

select * from titles

-1. List the following details of each employee: employee number, last name, first name, gender, and salary.

SELECT employees.emp_no, 
employees.last_name,
employees.first_name,
employees.sex,
salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no
ORDER BY emp_no

-2. List employees who were hired in 1986.

SELECT * FROM employees
WHERE DATE_PART('year',hire_date) = 1986
ORDER BY emp_no;

-3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, 
--last name, first name, and start and end employment dates.

SELECT dept_managers.dept_no, 
departments.dept_name,
dept_managers.emp_no,
employees.last_name, 
employees.first_name
FROM dept_managers
LEFT JOIN departments
ON dept_managers.dept_no = departments.dept_no
LEFT JOIN employees 
ON dept_managers.emp_no = employees.emp_no
ORDER BY emp_no

--4. List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT
employees.emp_no,
employees.last_name,
employees.first_name,
dept_emp.dept_no,
departments.dept_name
FROM employees 
INNER JOIN dept_emp ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments ON departments.dept_no=dept_emp.dept_no
order by emp_no;

-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name like 'B%';

-- 6. List all employees in the Sales department, including their
-- employee number, last name, first name, and department name.

SELECT 
employees.emp_no, 
employees.last_name, 
employees.first_name,
dept_emp.dept_no
FROM employees 
LEFT JOIN dept_emp 
ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments 
ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name='Sales';

-- 7. List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.

SELECT 
employees.emp_no, 
employees.last_name, 
employees.first_name,
dept_emp.dept_no
FROM employees 
LEFT JOIN dept_emp 
ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments 
ON departments.dept_no=dept_emp.dept_no
WHERE departments.dept_name in ('Sales', 'Development')

-- 8. In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

SELECT last_name, COUNT(*) AS freq_count
FROM employees
GROUP BY last_name
ORDER BY freq_count DESC;
