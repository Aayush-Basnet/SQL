
------------------------------------------------------------------------------
--------------- Database SQL-------------------------

Create Table Sale(
customer_id varchar(1),
order_date date,
product_id int
)

Insert Into Sale values
('A','2021-01-01',1),
('A','2021-01-01',2),
('A','2021-01-07',2),
('A','2021-01-10',3),
('A','2021-01-11',3),
('A','2021-01-11',3),
('B','2021-01-01',2),
('B','2021-01-02',2),
('B','2021-01-04',1),
('B','2021-01-11',1),
('B','2021-01-16',3),
('B','2021-02-01',3),
('C','2021-01-01',3),
('C','2021-01-01',3),
('C','2021-01-07',3)

Select * From Sale

CREATE TABLE Menu (
product_id int,
product_name varchar(10),
price int
)

Insert Into Menu Values
(1,'Momo',140),
(2,'Noodle',120),
(3,'Samoma',30),
(4,'Laphing',70)

Select * From Menu


CREATE TABLE Members (
customer_id varchar(1),
join_date Date
)

Insert Into Members Values
('A','2021-01-07'),
('B','2021-01-09'),
('C','2021-01-11')

Select * From Members

--------------------------------------------------------------------------------------------
--------------------SQL -Case- Studies------------------------------------

-- What is the total amount each customer spent at the restaurant?
Select s.customer_id, sum(price) as total_amount 
From Sale S
Join Menu M
On s.product_id = M.product_id
Group By s.customer_id
Order By total_amount DESC


-- How many days has each customer visited the restuarant?
 Select customer_id, COUNT(Distinct(order_date)) as days_visited
 from Sale
 Group By customer_id


 -- What was the first item from the menu purchased by each customer?
 With CTE As(
 Select s.customer_id, m.product_name, s.order_date,
 DENSE_RANK() over(Partition BY s.customer_id order By s.order_date) as ranks
 From Sale s
 Join Menu m
 on s.product_id = m.product_id
 )
 Select customer_id, product_name
 From CTE
 Where ranks = 1

----------------------------------------------------------------------------------------------
 -- What is the most purchased item on the meny and how many times was it purchased by all customers?
 
 select m.product_name, count(*) as most_item_purchased
 From Sale s
 Join Menu m
 On s.product_id = m.product_id
 Group By m.product_name
 Order BY most_item_purchased DESC
 
 -------------------------------------------------------------------------------------------
 -- Which item was the most populat for each customer?

With CTE As(
Select customer_id, product_name, item_count,
DENSE_RANK() over(Partition BY customer_id order by item_count DESC) as ranks
From(
Select s.customer_id, s.product_id, m.product_name, count(*) as item_count
From Sale s
Join Menu m
On s.product_id = m.product_id
Group By s.product_id,s.customer_id,m.product_name
Order By s.customer_id,item_count DESC
) as popular_items)
Select customer_id, product_name as popular_product
from CTE
Where ranks = 1


------------------------------------------------------------------------------------
-- Which item was purchased first by customer after they became a member?

With CTE As(
Select m.customer_id, m.join_date,s.product_id,s.order_date,
DENSE_RANK() OVER(PARTITION BY m.customer_id order by s.order_date) as ranks
From Members m
Join Sale s
on m.customer_id = s.customer_id
Where s.order_date >= m.join_date
)
Select customer_id, product_name
From CTE C
Join Menu A
ON C.product_id = A.product_id
Where ranks =1

------------------------------------------------------------------------------------------
-- Which item was purchased just before the customer became a member?
Select m.customer_id, A.product_name
From Members M
Join Sale S ON M.customer_id = S.customer_id
Join Menu A On S.product_id = A.product_id
Where s.order_date < m.join_date
Group BY m.customer_id, A.product_name
Order BY m.customer_id


-----------------------------------------------------------------------------------------------
-- What is the total items and amount spent for each member before they became a member?
Select m.customer_id ,A.product_name, count(*) as total_item,sum(price) as total_purchase
From Members M
Join Sale S
On M.customer_id = S.customer_id
Join Menu A on  S.product_id = A.product_id
Where s.order_date < m.join_date
Group BY m.customer_id,A.product_name


---------------------------------------------------------------------------------------------------
-- IF each $1 spent equates to 10 points and Samosa has a 2X points multiplier, how many points would each customer have?
With CTE As(
SELECT s.customer_id,m.product_name,m.price,
	CASE WHEN m.product_name IN (
		SELECT DISTINCT(product_name) 
		FROM menu 
		where product_name = 'Samoma') 
		 THEN price*20 ELSE price*10 
		 END  AS points
	FROM sale s
	JOIN menu m ON s.product_id = m.product_id
)
Select customer_id,sum(points) as total_point
From CTE
Group BY customer_id

------------------------------------------------------------------------------------------------
-- In the first week after a customer joins the program (including their join date) 
----they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

With CTE As(
Select s.customer_id, A.price,
Case When A.product_name IN (
	Select Distinct(product_name)
	From Menu)
	Then price*20
	End as points
From Sale S
Join Members M on S.customer_id = M.customer_id
Join Menu A on S.product_id = A.product_id
Where s.order_date > M.join_date  AND S.order_date <= '2021-01-31'
)
Select customer_id, sum(points) As total_points
From CTE
Group by customer_id