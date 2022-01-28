-- Question 28
-- Table: Project

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | project_id  | int     |
-- | employee_id | int     |
-- +-------------+---------+
-- (project_id, employee_id) is the primary key of this table.
-- employee_id is a foreign key to Employee table.
-- Table: Employee

-- +------------------+---------+
-- | Column Name      | Type    |
-- +------------------+---------+
-- | employee_id      | int     |
-- | name             | varchar |
-- | experience_years | int     |
-- +------------------+---------+
-- employee_id is the primary key of this table.
 

-- Write an SQL query that reports all the projects that have the most employees.

-- The query result format is in the following example:

-- Project table:
-- +-------------+-------------+
-- | project_id  | employee_id |
-- +-------------+-------------+
-- | 1           | 1           |
-- | 1           | 2           |
-- | 1           | 3           |
-- | 2           | 1           |
-- | 2           | 4           |
-- +-------------+-------------+

-- Employee table:
-- +-------------+--------+------------------+
-- | employee_id | name   | experience_years |
-- +-------------+--------+------------------+
-- | 1           | Khaled | 3                |
-- | 2           | Ali    | 2                |
-- | 3           | John   | 1                |
-- | 4           | Doe    | 2                |
-- +-------------+--------+------------------+

-- Result table:
-- +-------------+
-- | project_id  |
-- +-------------+
-- | 1           |
-- +-------------+
-- The first project has 3 employees while the second one has 2.

-- Solution
create table project5(
    project_id int,
    employee_id int
);
insert into Project5 values
(1,1),
(1,2),
(1,3),
(2,1),
(2,4);

create table employee5 (
    employee_id     int,
    name            varchar(20),
    experience_years    int
);

insert into employee5 values
(1,'Khaled',3),
(2,'Ali',2),
(3,'John',1),
(4,'Doe',2);


with t1 as (
    select project_id,
    dense_rank() over(order by count(employee_id) desc) rnk
    from project5
    group by 1
)
select project_id from t1 where rnk = 1;


drop table employee5;
drop table project5;