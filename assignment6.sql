/*'''Table: Users +----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| join_date      | date    |
| favorite_brand | varchar |
+----------------+---------+
user_id is the primary key of this table.
This table has the info of the users of an online shopping website where users can sell and buy items.'''
Users table:
+---------+------------+----------------+
| user_id | join_date  | favorite_brand |
+---------+------------+----------------+
| 1       | 2018-01-01 | Lenovo         |
| 2       | 2018-02-09 | Samsung        |
| 3       | 2018-01-19 | LG             |
| 4       | 2018-05-21 | HP             |
+---------+------------+----------------+*/
CREATE TABLE Users
(
	user_id  int,
    join_date date,
    favorite_brand VARCHAR(40),
    PRIMARY KEY (user_id)
);

INSERT into Users values (1,'2018-01-01','lenovo');
INSERT into Users values (2,'2018-02-09','Samsung');
INSERT into Users values (3,'2018-01-19','LG');
INSERT into Users values (4,'2018-05-21','HP');

select * from Users;

/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| item_id       | int     |
| buyer_id      | int     |
| seller_id     | int     |
+---------------+---------+
order_id is the primary key of this table.
item_id is a foreign key to the Items table.
buyer_id and seller_id are foreign keys to the Users table.
Orders table:
+----------+------------+---------+----------+-----------+
| order_id | order_date | item_id | buyer_id | seller_id |
+----------+------------+---------+----------+-----------+
| 1        | 2019-08-01 | 4       | 1        | 2         |
| 2        | 2018-08-02 | 2       | 1        | 3         |
| 3        | 2019-08-03 | 3       | 2        | 3         |
| 4        | 2018-08-04 | 1       | 4        | 2         |
| 5        | 2018-08-04 | 1       | 3        | 4         |
| 6        | 2019-08-05 | 2       | 2        | 4         |
+----------+------------+---------+----------+-----------+*/
CREATE TABLE Orders
(
	order_id int,
    order_date date,
    item_id int,
    buyer_id int,
    seller_id int,
    PRIMARY KEY (order_id),
    foreign key (item_id) references Items (item_id),
    foreign key (buyer_id) references Users (user_id)
);

INSERT into Orders values (1,'2019-08-01',4,1,2);
INSERT into Orders values (2,'2018-08-02',2,1,3);
INSERT into Orders values (3,'2019-08-03',3,2,3);
INSERT into Orders values (4,'2018-08-04',1,4,2);
INSERT into Orders values (5,'2018-08-04',1,3,4);
INSERT into Orders values (6,'2019-08-05',2,2,4);

SELECT * FROM Orders;




/*
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| item_id       | int     |
| item_brand    | varchar |
+---------------+---------+
item_id is the primary key of this table.
Items table:
+---------+------------+
| item_id | item_brand |
+---------+------------+
| 1       | Samsung    |
| 2       | Lenovo     |
| 3       | LG         |
| 4       | HP         |
+---------+------------+*/
CREATE TABLE Items
(
	item_id int primary key,
    item_brand varchar(40)
);
INSERT into Items values (1,'Samsung');
INSERT into Items values (2,'Lenovo');
INSERT into Items values (3,'LG');
INSERT into Items values (4,'HP');

SELECT * FROM Items;



CREATE TABLE ord2019(SELECT buyer_id,COUNT(
CASE 
	WHEN order_date > '2019-01-01' THEN 1
END) as orders_in_2019
FROM Orders
group by buyer_id
having orders_in_2019>=1);

SELECT u.user_id,u.join_date,
(
CASE
	WHEN o.orders_in_2019 IS NULL THEN 0
    ELSE o.orders_in_2019
END
)AS orders_in_2019
FROM ord2019 o
RIGHT JOIN Users u
ON o.buyer_id=u.user_id;

/*Output: 
+-----------+------------+----------------+
| buyer_id  | join_date  | orders_in_2019 |
+-----------+------------+----------------+
| 1         | 2018-01-01 | 1              |
| 2         | 2018-02-09 | 2              |
| 3         | 2018-01-19 | 0              |
| 4         | 2018-05-21 | 0              |
+-----------+------------+----------------+*/


