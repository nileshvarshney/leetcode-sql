-- Question 15
-- Write a SQL query to get the second highest salary from the Employee table.

-- +----+--------+
-- | Id | Salary |
-- +----+--------+
-- | 1  | 100    |
-- | 2  | 200    |
-- | 3  | 300    |
-- +----+--------+
-- For example, given the above Employee table, the query should return 200 as the second highest salary. 
-- If there is no second highest salary, then the query should return null.

-- +---------------------+
-- | SecondHighestSalary |
-- +---------------------+
-- | 200                 |
-- +---------------------+


-- Solution
create table employee5(
    id      int,
    salary  int
);

insert into employee5 values(1, 100),(2,200),(3,300);
-- Query 1
SELECT max(salary) SecondHighestSalary from employee5
where salary != (select max(salary) from employee5);

-- Query 2
with t1 as(
    select salary, dense_rank() over (order by salary desc) rnk
    from employee5
)
select salary SecondHighestSalary from t1 where rnk = 2;

drop table employee5;
