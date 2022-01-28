-- Question 11
-- Write a SQL query to find all duplicate emails in a table named Person.

-- +----+---------+
-- | Id | Email   |
-- +----+---------+
-- | 1  | a@b.com |
-- | 2  | c@d.com |
-- | 3  | a@b.com |
-- +----+---------+
-- For example, your query should return the following for the above table:

-- +---------+
-- | Email   |
-- +---------+
-- | a@b.com |
-- +---------+


-- Solution
create table emails (
    id int, 
    email varchar(10)
);
insert into emails values 
(1, 'a@b.com'),
(2, 'c@b.com'),
(3, 'a@b.com');

with t1 as(
    select 
        email,
        row_number() over (partition by email) rno
    from emails
)
select distinct email from t1 where  rno > 1;

select email from emails  group by email having count(email) > 1;

drop table emails;