WITH total_salario AS
(
    SELECT
        emp_no,
        SUM(salary) AS soma_salario
    FROM
        salaries
    GROUP BY
        emp_no
)

SELECT * FROM total_salario