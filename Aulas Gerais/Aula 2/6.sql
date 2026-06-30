SELECT employees.emp_no, employees.first_name, salaries.from_date, salaries.to_date, salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salaries.to_date = '9999-01-01'
