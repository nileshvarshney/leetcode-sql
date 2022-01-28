-- Question 37
-- Several friends at a cinema ticket office would like to reserve consecutive available seats.
-- Can you help to query all the consecutive available seats order by the seat_id using the following cinema table?
-- | seat_id | free |
-- |---------|------|
-- | 1       | 1    |
-- | 2       | 0    |
-- | 3       | 1    |
-- | 4       | 1    |
-- | 5       | 1    |
 

-- Your query should return the following result for the sample case above.
 

-- | seat_id |
-- |---------|
-- | 3       |
-- | 4       |
-- | 5       |
-- Note:
-- The seat_id is an auto increment int, and free is bool ('1' means free, and '0' means occupied.).
-- Consecutive available seats are more than 2(inclusive) seats consecutively available.

-- Solution
create table seats2(
    seat_id int,
    free    int
);
insert into seats2 values
(1,1),
(2,0),
(3,1),
(4,1),
(5,1);

-- Query 1
with seat as(
	select seat_id,free, 
    lead(free, 1) over () next,
    lag(free, 1) over() prev
from seats2
)
select seat_id from seat 
where free = 1 
and (next = 1 or prev = 1)
order by 1;

-- Query 2
with t1 as(
select 
	seat_id,
    seat_id - 
    row_number() over() rno
from seats2 where free = 1
) 
select seat_id from t1 where rno in (
select rno from t1 group by rno having count(rno) > 1);


drop table seats2;

-- continous seat
with t1 as(
select 
	seat,
    seat - 
    row_number() over(order by seat) rno
from seats where status = 'Available'
) 
select 
	min(seat)  seat_start,
    max(seat)  seat_end, 
    count(seat) no_of_seats
from t1 group by rno;

--  stocks continous date example
with t1 as (
select 
	start_date, 
    date_sub(start_date, interval row_number() over(partition by price order by start_date) day) diff,
    price
from stocks
)
select 
	min(start_date) start, max(start_date) end, price from t1 group by price, diff
order by 1