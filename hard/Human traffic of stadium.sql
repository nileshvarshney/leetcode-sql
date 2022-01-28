-- Question 99
-- X city built a new stadium, each day many people visit it and the stats are saved as these columns: id, visit_date, people

-- Please write a query to display the records which have 3 or more consecutive rows and the amount of people more than 100(inclusive).

-- For example, the table stadium:
-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 1    | 2017-01-01 | 10        |
-- | 2    | 2017-01-02 | 109       |
-- | 3    | 2017-01-03 | 150       |
-- | 4    | 2017-01-04 | 99        |
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+
-- For the sample data above, the output is:

-- +------+------------+-----------+
-- | id   | visit_date | people    |
-- +------+------------+-----------+
-- | 5    | 2017-01-05 | 145       |
-- | 6    | 2017-01-06 | 1455      |
-- | 7    | 2017-01-07 | 199       |
-- | 8    | 2017-01-08 | 188       |
-- +------+------------+-----------+
-- Note:
-- Each day only have one row record, and the dates are increasing with id increasing.

-- Solution
create table stadium5(id int, visit_date date, people int);
insert into stadium5 values
(1,'2017-01-01',10  ),
(2,'2017-01-02',109 ),
(3,'2017-01-03',150 ),
(4,'2017-01-04',99  ),
(5,'2017-01-05',145 ),
(6,'2017-01-06',1455),
(7,'2017-01-07',199 ),
(8,'2017-01-08',188 );


with t1 as(
       select *, date_sub(visit_date,  interval row_number() over (order by visit_date) day) g_date
       from (select * from stadium5 where people > 100) x
)
select id, visit_date, people from t1 
where g_date in (select g_date from t1 group by g_date having count(g_date) > 2);

drop table stadium5;