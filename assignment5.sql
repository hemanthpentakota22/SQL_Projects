CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(20),
    job_name VARCHAR(20),
    manager_id INT,
    hire_date DATE,
    salary INT,
    commission INT,
    dept_id INT
);
INSERT INTO employees values (68319, 'KAYLING','PRESIDENT',NULL,'1991-11-18',6000.00,NULL,1001);
INSERT INTO employees values (66928, 'BLAZE','MANAGER',68319,'1991-05-01',2750.00,NULL,3001);
INSERT INTO employees values (67832, 'CLARE','MANAGER',68319,'1991-06-09',2550.00,NULL,1001);
INSERT INTO employees values (65646, 'JONAS','MANAGER',68319,'1991-04-02',2957.00,NULL,2001);
INSERT INTO employees values (67858, 'SCARLET','ANALYST',65646,'1997-04-19',3100.00,NULL,2001);
INSERT INTO employees values (69062, 'FRANK','ANALYST',65646,'1991-12-03',3100.00,NULL,2001);
INSERT INTO employees values (63679, 'SANDRINE','CLERK',69062,'1990-12-18',900.00,NULL,2001);
INSERT INTO employees values (64989, 'ADELYN','SALESMAN',66928,'1991-02-20',1700.00,400.00,3001);
INSERT INTO employees values (65271,'WADE','SALESMAN', 66928,'1991-02-22',1350.00,600.00,3001);
INSERT INTO employees values (66564,'MADDEN','SALESMAN',66928,'1991-09-28',1350.00,1500.00,3001);
INSERT INTO employees values ( 68454,'TUCKER','SALESMAN',66928,'1991-09-08',1600.00, 0.00,3001);
INSERT INTO employees values (68736,'ADNRES','CLERK',67858,'1997-05-23',1200.00,NULL,2001);
INSERT INTO employees values (69000,'JULIUS','CLERK',66928,'1991-12-03',1050.00,NULL,3001);
INSERT INTO employees values ( 69324,'MARKER','CLERK',67832,'1992-01-23',1400.00,NULL,1001);


SELECT 
    emp_id,
    emp_name,
    job_name,
    manager_id,
    hire_date,
    salary + salary * 0.25 AS salary,
    commission,
    dept_id
FROM
    employees
WHERE
    salary > 3000;
INSERT INTO employees values ( 69324,'MARKER','CLERK',67832,'1992-01-23',1400.00,NULL,1001);
SELECT DISTINCT(emp_id),emp_name,job_name,manager_id,hire_date,salary,commission,dept_id FROM employees
WHERE emp_id IN
(
SELECT emp_id
FROM employees 
GROUP BY emp_id
HAVING COUNT(emp_id) > 1
);
