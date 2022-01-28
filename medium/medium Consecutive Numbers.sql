-- Question 52
-- Write a SQL query to find all numbers that appear at least three times consecutively.

-- +----+-----+
-- | Id | Num |
-- +----+-----+
-- | 1  |  1  |
-- | 2  |  1  |
-- | 3  |  1  |
-- | 4  |  2  |
-- | 5  |  1  |
-- | 6  |  2  |
-- | 7  |  2  |
-- +----+-----+
-- For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.

-- +-----------------+
-- | ConsecutiveNums |
-- +-----------------+
-- | 1               |
-- +-----------------+

-- Solution
create table logs
( id int, num  int);

insert into logs(id, num) values
(1,1),
(2,1),
(3,1),
(4,2),
(5,1),
(6,2),
(7,2);

with t1 as(
	select
		id,
		num,
		lag(num,1) over () lag_num,
		lead(num,1) over () lead_num
	from logs	
)
select distinct num from t1 where num = lag_num and num = lead_num;

drop table logs;