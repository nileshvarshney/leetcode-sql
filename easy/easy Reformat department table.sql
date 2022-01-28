-- Question 44
-- Table: Department

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | revenue       | int     |
-- | month         | varchar |
-- +---------------+---------+
-- (id, month) is the primary key of this table.
-- The table has information about the revenue of each department per month.
-- The month has values in ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"].
 

-- Write an SQL query to reformat the table such that there is a department id column and a revenue column for each month.

-- The query result format is in the following example:

-- Department table:
-- +------+---------+-------+
-- | id   | revenue | month |
-- +------+---------+-------+
-- | 1    | 8000    | Jan   |
-- | 2    | 9000    | Jan   |
-- | 3    | 10000   | Feb   |
-- | 1    | 7000    | Feb   |
-- | 1    | 6000    | Mar   |
-- +------+---------+-------+

-- Result table:
-- +------+-------------+-------------+-------------+-----+-------------+
-- | id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
-- +------+-------------+-------------+-------------+-----+-------------+
-- | 1    | 8000        | 7000        | 6000        | ... | null        |
-- | 2    | 9000        | null        | null        | ... | null        |
-- | 3    | null        | 10000       | null        | ... | null        |
-- +------+-------------+-------------+-------------+-----+-------------+

-- Note that the result table has 13 columns (1 for the department id + 12 for the months).

-- Solution
create table Department5(
    id  int,
    revenue int,
    month   varchar(3)
);

insert into department5 values
(1, 8000, 'Jan'),
(2, 9000, 'Jan'),
(3, 10000, 'Feb'),
(1, 7000, 'Feb'),
(1, 6000, 'Mar');

select
    id,
    sum(if(month = 'Jan',  revenue, null)) Jan_Revenue,
    sum(if(month = 'Feb' , revenue, null)) Feb_Revenue,
    sum(if(month = 'Mar' , revenue, null)) Mar_Revenue,
    sum(if(month = 'Apr' , revenue, null)) Apr_Revenue,
    sum(if(month = 'May' , revenue, null)) May_Revenue,
    sum(if(month = 'Jun' , revenue, null)) Jun_Revenue,
    sum(if(month = 'Jul' , revenue, null)) Jul_Revenue,
    sum(if(month = 'Aug' , revenue, null)) Aug_Revenue,
    sum(if(month = 'Sep' , revenue, null)) Sep_Revenue,
    sum(if(month = 'Oct' , revenue, null)) Oct_Revenue,
    sum(if(month = 'Nov' , revenue, null)) Nov_Revenue,
    sum(if(month = 'Dec' , revenue, null)) Dec_Revenue
from Department5
group by id;

drop table department5;