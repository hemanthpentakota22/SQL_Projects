/*
SQL Assignment 14th Feb:A pizza company is taking orders from customers, and each pizza ordered is added to their 
database as a separate order. Each order has an associated status, "CREATED or SUBMITTED or DELIVERED". An order's 
Final_Status is calculated based on status as follows: When all orders for a customer have a status of DELIVERED, 
that customer's order has a Final_Status of COMPLETED.If a customer has some orders that are not DELIVERED and 
some orders that are DELIVERED, the Final_Status is IN PROGRESS.If at least one of a customer's orders is SUBMITTED 
and none is DELIVERED, the Final_Status is AWAITING PROGRESS.Otherwise, the Final_Status is AWAITING SUBMISSION.
 Write a query to report the customer_name and Final_Status of each customer's order. 
Order the results by customer name. Table definitions and a data sample are given below. 
Table: Customer_Order
column namecolumn typecustomer_name varchar2(50)order_idvarchar2(10)statusvarchar2(50)
Sample Data Tables
Table: Customer_Order 
Customer_name.   order_id.   	status
John				J1			DELIVERED
John				J2			DELIVERED
David				D1			DELIVERED
David				D3			CREATED
Smith				S1			SUBMITTED
KRISH				K1			CREATED
When all orders are in DELIVERED status then the Final_Status is "COMPLETED".
 When one or more orders for a customer are DELIVERED and one or more orders are CREATED or SUBMITTED,
 then the Final_Status is "IN PROGRESS". When one or more orders for a customer are SUBMITTED and 
 none are DELIVERED, then the Final_Status is "AWAITING PROGRESS". Otherwise, the Final_Status is "AWAITING SUBMISSION".
  Order priority is DELIVERED , SUBMITTED, CREATED. 
 The results are: 
  customer_name				Final_Status
	David					IN PROGRESS
	John					COMPLETED
    KRISH					AWAITING SUBMISSION
    Smith					AWAITING PROGRESS 
*/





CREATE TABLE Customer_Order(customer_name VARCHAR(50), order_id VARCHAR(10), status varchar(50));

INSERT INTO Customer_Order VALUES ('John','J1','DELIVERED'),
('John','J2','DELIVERED'),
('David','D1','DELIVERED'),
('David','D3','CREATED'),
('Smith','S1','SUBMITTED'),
('KRISH','K1','CREATED');



SELECT a.customer_name,a.cou,b.status
FROM (SELECT customer_name,COUNT(status)as cou FROM (SELECT DISTINCT customer_name,status FROM Customer_Order)e
GROUP BY customer_name)
a
LEFT JOIN 
(SELECT DISTINCT customer_name,status FROM Customer_Order)b on a.customer_name=b.customer_name;



SELECT DISTINCT a.customer_name,
CASE 
	WHEN cou>1 AND (status='DELIVERED'OR status='CREATED' OR status='SUBMITED') THEN 'IN PROGRESS'
    WHEN cou=1 AND status='DELIVERED' THEN 'COMPLETED'
    WHEN cou=1 AND status='SUBMITTED' THEN 'AWAITING PROGRESS'
    ELSE 'AWAITING SUBMISSION'
END AS Final_Status
FROM (SELECT customer_name,COUNT(status)as cou FROM (SELECT DISTINCT customer_name,status FROM Customer_Order)e
GROUP BY customer_name)
a
LEFT JOIN 
(SELECT DISTINCT customer_name,status FROM Customer_Order)b on a.customer_name=b.customer_name
ORDER BY a.customer_name;


