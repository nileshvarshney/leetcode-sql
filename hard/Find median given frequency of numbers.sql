-- Question 107
-- The Numbers table keeps the value of number and its frequency.

-- +----------+-------------+
-- |  Number  |  Frequency  |
-- +----------+-------------|
-- |  0       |  7          |
-- |  1       |  1          |
-- |  2       |  3          |
-- |  3       |  1          |
-- +----------+-------------+
-- In this table, the numbers are 0, 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 3, so the median is (0 + 0) / 2 = 0.

-- +--------+
-- | median |
-- +--------|
-- | 0.0000 |
-- +--------+
-- Write a query to find the median of all numbers and name the result as median.

-- Solution
create table frequency5(
    number int,
    frequency int
);

insert into frequency5 values
(0,7),
(1,1),
(2,3),
(3,1);


with t1 as(
select *, 
	sum(frequency) over(order by number) cum_sum,
    sum(frequency) over()/2 mid
from frequency5
)
select avg(number) median 
from t1 where mid between (cum_sum - frequency) and cum_sum;

drop table frequency5;
