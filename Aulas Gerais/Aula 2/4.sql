SELECT a.emp_no, a.first_name, b.salary
FROM employees a
INNER JOIN salaries b
ON a.emp_no = b.emp_no
