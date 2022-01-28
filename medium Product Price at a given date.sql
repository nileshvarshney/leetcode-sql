-- Question 67
-- Table: Products

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.
 

-- Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

-- The query result format is in the following example:

-- Products table:
-- +------------+-----------+-------------+
-- | product_id | new_price | change_date |
-- +------------+-----------+-------------+
-- | 1          | 20        | 2019-08-14  |
-- | 2          | 50        | 2019-08-14  |
-- | 1          | 30        | 2019-08-15  |
-- | 1          | 35        | 2019-08-16  |
-- | 2          | 65        | 2019-08-17  |
-- | 3          | 20        | 2019-08-18  |
-- +------------+-----------+-------------+

-- Result table:
-- +------------+-------+
-- | product_id | price |
-- +------------+-------+
-- | 2          | 50    |
-- | 1          | 35    |
-- | 3          | 10    |
-- +------------+-------+

-- Solution

CREATE TABLE products2 (
    product_id INT,
    new_price INT,
    change_date DATE
);

insert into products2 values
(1,20,'2019-08-14'),
(2,50,'2019-08-14'),
(1,30,'2019-08-15'),
(1,35,'2019-08-16'),
(2,65,'2019-08-17'),
(3,20,'2019-08-18');

-- ==> Solution 1
with price as(
    select product_id, max(change_date) change_date from products2 where change_date <= '2019-08-16' group by 1
), t2 as(
select 
    price.product_id,
    products2.new_price price
from products2 join price  using(product_id, change_date)
)
select * from (
select product_id, price from t2
union all
select product_id, 10 proce from Products2 where  product_id not in (select product_id from t2)
) x order by 1;

-- ==> Solotion 2
with t1 as (
select 
	product_id,
    new_price,
    change_date,
    max(change_date) over (partition by product_id order by change_date desc) max_date
from products2 
where change_date <= '2019-08-16'
)
select product_id , new_price price from t1 where change_date = max_date
union all
select product_id, 10 from products2 where product_id not in (select product_id from t1)

drop table products2;

