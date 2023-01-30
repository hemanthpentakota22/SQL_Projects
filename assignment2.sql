SELECT e.emp AS EName,e.dept_no AS deptNo,e.salary FROM 
(
	SELECT e.emp,e.dept_no,e.salary,
    ROW_NUMBER() OVER w AS row_num
    FROM employee e
    WINDOW w AS(PARTITION BY dept_no ORDER BY salary DESC)
)
e
WHERE row_num=2;
