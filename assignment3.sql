CREATE TABLE event_s (
    event_type INTEGER NOT NULL,
    _value_ INTEGER NOT NULL,
    _time_ TIMESTAMP NOT NULL,
    UNIQUE (event_type , _time_)
);
insert into event_s values
(2,5,'2015-05-09 12:42:00'),
(4,-42,'2015-05-09 13:19:57'),
(2,2,'2015-05-09 14:48:30'),
(2,7,'2015-05-09 12:54:39'),
(3,16,'2015-05-09 13:19:57'),
(3,20,'2015-05-09 15:01:09');
SELECT * FROM event_s;

SELECT event_type,MAX(_value_),COUNT(event_type) AS _count_
FROM event_s 
GROUP BY event_type
HAVING _count_ > 1
ORDER BY event_type;
DROP TABLE out_2;

SELECT es.event_type,es._value_,
DENSE_RANK() OVER (PARTITION BY event_type ORDER BY _time_ DESC) AS dr_num
FROM event_s es;

CREATE TABLE out_2(
SELECT event_type,_value_ FROM
(
	SELECT es.event_type,es._value_,
		DENSE_RANK() OVER (PARTITION BY event_type ORDER BY _time_ DESC) AS dr_num
		FROM event_s es
) 
es
WHERE dr_num=2
);
SELECT * FROM out_2;


SELECT o2.event_type,o1._value_-o2._value_ AS _value_
FROM 
out_1 o1 
JOIN out_2 o2 ON o1.event_type=o2.event_type;


