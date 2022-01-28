-- Question 12
-- Description

-- Given three tables: salesperson, company, orders.
-- Output all the names in the table salesperson, who didn’t have sales to company 'RED'.

-- Example
-- Input

-- Table: salesperson

-- +----------+------+--------+-----------------+-----------+
-- | sales_id | name | salary | commission_rate | hire_date |
-- +----------+------+--------+-----------------+-----------+
-- |   1      | John | 100000 |     6           | 4/1/2006  |
-- |   2      | Amy  | 120000 |     5           | 5/1/2010  |
-- |   3      | Mark | 65000  |     12          | 12/25/2008|
-- |   4      | Pam  | 25000  |     25          | 1/1/2005  |
-- |   5      | Alex | 50000  |     10          | 2/3/2007  |
-- +----------+------+--------+-----------------+-----------+
-- The table salesperson holds the salesperson information. Every salesperson has a sales_id and a name.
-- Table: company

-- +---------+--------+------------+
-- | com_id  |  name  |    city    |
-- +---------+--------+------------+
-- |   1     |  RED   |   Boston   |
-- |   2     | ORANGE |   New York |
-- |   3     | YELLOW |   Boston   |
-- |   4     | GREEN  |   Austin   |
-- +---------+--------+------------+
-- The table company holds the company information. Every company has a com_id and a name.
-- Table: orders

-- +----------+------------+---------+----------+--------+
-- | order_id | order_date | com_id  | sales_id | amount |
-- +----------+------------+---------+----------+--------+
-- | 1        |   1/1/2014 |    3    |    4     | 100000 |
-- | 2        |   2/1/2014 |    4    |    5     | 5000   |
-- | 3        |   3/1/2014 |    1    |    1     | 50000  |
-- | 4        |   4/1/2014 |    1    |    4     | 25000  |
-- +----------+----------+---------+----------+----------+
-- The table orders holds the sales record information, salesperson and customer company are represented by sales_id and com_id.
-- output

-- +------+
-- | name | 
-- +------+
-- | Amy  | 
-- | Mark | 
-- | Alex |
-- +------+
-- Explanation

-- According to order '3' and '4' in table orders, it is easy to tell only salesperson 'John' and 'Pam' have sales to company 'RED',
-- so we need to output all the other names in the table salesperson.

-- Solution
create table salesperson5(
    sales_id    int, 
    name        varchar(20)
);

insert into salesperson5 values
(1,'John'),
(2,'Amy'),
(3,'Mark'),
(4,'Pam'),
(5,'Alex');

create table company5(
    com_id     int,
    name        varchar(20) 
);

insert into company5 values
(1,'RED'),
(2,'ORANGE'),
(3,'YELLOW'),
(4,'GREEN');

create table  order5 (
    order_id    int,
    com_id      int,
    sales_id    int
);
insert into order5 values
(1,3,4),
(2,4,5),
(3,1,1),
(4,1,4);

select name from salesperson5 where sales_id not in (select distinct sales_id from order5 join company5 using (com_id) where name = 'RED'); 



drop table order5;
drop table company5;
drop table salesperson5;