/*
There is a blood bank which maintains two tables: DONOR that contains information on the people who are willing to 
donate blood and ACCEPTOR, the people who are in need of blood. The bank wants to conduct a survey and find out the 
city that has the best and the worst donor sum amount/acceptor sum amount ratio. Both ratios are unique. 
That is, exactly one city has the best ratio and exactly one city has the worst ratio. 
The donor sum amount is the total amount of blood, regardless of blood group, that people are ready to donate. 
The acceptor sum amount is the total amount of blood needed by that city. There must be exactly two rows that denote 
the best and the worst ratios. The order of the rows does not matter. 
Each row must contain the following attributes:
1. The city's name (CITY).
2. The ratio ( donor sum amount / acceptor sum amount ), correct to 4 decimal places. 
The schema of the two tables is given below: 
Schema DONOR
Name	Type		Description
ID		Integer		It is the ID of the donor.
NAME	String		It is the name of the donor.
GENDER	Character	It is the gender of the donor.
CITY	String		It is the city where the donor lives.
BLOOD_GROUP	String	It is the blood group of the donor.
AMOUNT	Integer		It is the amount of blood in pints, which the donator can donate.

ACCEPTOR 
Name		Type		Description
ID			Integer		It is the id of the acceptor.
NAME		String		It is the name of the acceptor.
GENDER		Character	It is the gender of the acceptor.
CITY		String		It is the city where the acceptor lives.
BLOOD_GROUP	String		It is the blood group of the acceptor.
AMOUNT		Integer		It is the amount of blood in pints, which the acceptor needs.
  
DONOR
ID				NAME						GENDER				CITY			BLOOG_GROUP		AMOUNT
1				MARIA						F				Warne, NH				AB+			7
2				DOROTHY						F			East Natchitoches, PA		AB+			3
3				CHARLES						M			East Natchitoches, PA		A-			6
4				DOROTHY						F			East Natchitoches, PA		AB+			9
5				MICHAEL						M			Warne, NH					A+			1  

ACCEPTOR
ID	NAME		GENDER	CITY					BLOOG_GROUP		AMOUNT
1	LINDA			F	Warne, NH					A+				9
2	CHARLES			M	Warne, NH					AB+				8
3	RICHARD			M	East Natchitoches, PA		AB+				3
4	LINDA			F	East Natchitoches, PA		A+				1
5	PATRICIA		F	Warne, NH					A+				5


Sample Output
East Natchitoches, PA 4.5000
Warner, NH 0.3636
 ExplanationThe amount of blood available for donation in East Natchitoches, PA is 3 + 6 + 9 = 18.
The amount of blood needed in East Natchitoches, PA is 3 +1 = 4.Hence, the ratio is = ( 18 : 4 ) = 4.5000.
The amount of blood available for donation in Warne, NH is 1 + 7 = 8.
The amount of blood needed in Warne, NH is 9 + 8 + 5 = 22.Hence, the ratio is = ( 8 : 22 ) = 0.3636.
*/
CREATE TABLE DONOR 
(ID INT,NAME VARCHAR(30),GENDER CHAR(10),CITY VARCHAR(30),BLOOD_GROUP VARCHAR(10),AMOUNT INT);

INSERT INTO DONOR VALUES 
(1,'MARIA','F','Warne, NH','AB+',7),
(2,'DOROTHY','F','East Natchitoches, PA','AB+',3),
(3,'CHARLES','M','East Natchitoches, PA','A-',6),
(4,'DOROTHY','F','East Natchitoches, PA','AB+',9),
(5,'MICHAEL','M','Warne, NH','A+',1);

SELECT * FROM DONOR;

CREATE TABLE ACCEPTOR 
(ID INT,NAME VARCHAR(30),GENDER CHAR(10),CITY VARCHAR(30),BLOOD_GROUP VARCHAR(10),AMOUNT INT);

INSERT INTO ACCEPTOR VALUES
(1,'LINDA','F','Warne, NH','A+',9),
(2,'CHARLES','M','Warne, NH','AB+',8),
(3,'RICHARD','M','East Natchitoches, PA','AB+',3),
(4,'LINDA','F','East Natchitoches, PA','A+',1),
(5,'PATRICIA','F','Warne, NH','A+',5);

SELECT * FROM ACCEPTOR;


SELECT A.CITY,ROUND(D._SUM/A._SUM,4) AS RATIO
FROM(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM ACCEPTOR
GROUP BY CITY)A
LEFT JOIN 
(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM DONOR
GROUP BY CITY)D ON A.CITY=D.CITY
ORDER BY RATIO DESC;





SELECT E.CITY,F.RATIO
FROM
(SELECT A.CITY,ROUND(D._SUM/A._SUM,4) AS RATIO
FROM(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM ACCEPTOR
GROUP BY CITY)A
LEFT JOIN 
(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM DONOR
GROUP BY CITY)D ON A.CITY=D.CITY
ORDER BY RATIO DESC)E
LEFT JOIN 
(SELECT MAX(ROUND(D._SUM/A._SUM,4)) AS RATIO
FROM(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM ACCEPTOR
GROUP BY CITY)A
JOIN 
(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM DONOR
GROUP BY CITY)D ON A.CITY=D.CITY
ORDER BY RATIO DESC)F ON E.RATIO=F.RATIO
WHERE E.RATIO=F.RATIO
UNION 
SELECT E.CITY,F.RATIO
FROM
(SELECT A.CITY,ROUND(D._SUM/A._SUM,4) AS RATIO
FROM(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM ACCEPTOR
GROUP BY CITY)A
LEFT JOIN 
(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM DONOR
GROUP BY CITY)D ON A.CITY=D.CITY
ORDER BY RATIO DESC)E
LEFT JOIN 
(SELECT MIN(ROUND(D._SUM/A._SUM,4)) AS RATIO
FROM(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM ACCEPTOR
GROUP BY CITY)A
JOIN 
(SELECT CITY, SUM(AMOUNT) AS _SUM
FROM DONOR
GROUP BY CITY)D ON A.CITY=D.CITY
ORDER BY RATIO DESC)F ON E.RATIO=F.RATIO
WHERE E.RATIO=F.RATIO;


