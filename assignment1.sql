SELECT col1,col2
FROM t1
INNER JOIN t2
ON t1.col1 = t2.col2;

SELECT col1,col2
FROM t1
LEFT OUTER JOIN t2
ON t1.col1 = t2.col2;

SELECT col1,col2
FROM t1
RIGHT OUTER JOIN t2
ON t1.col1 = t2.col2;

SELECT t1.col1,t2.col2
FROM t1
LEFT OUTER JOIN t2
ON t1.col1 = t2.col2
UNION
SELECT t1.col1,t2.col2
FROM t1
RIGHT OUTER JOIN t2
ON t1.col1 = t2.col2;

