SELECT employees.emp_no, employees.first_name, salaries.from_date, salaries.to_date, titles.title, salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE titles.to_date = '9999-01-01' and salaries.to_date='9999-01-01'
