-- Question 15
-- The Employee table holds all employees including their managers. 
-- Every employee has an Id, and there is also a column for the manager Id.

-- +----+-------+--------+-----------+
-- | Id | Name  | Salary | ManagerId |
-- +----+-------+--------+-----------+
-- | 1  | Joe   | 70000  | 3         |
-- | 2  | Henry | 80000  | 4         |
-- | 3  | Sam   | 60000  | NULL      |
-- | 4  | Max   | 90000  | NULL      |
-- +----+-------+--------+-----------+
-- Given the Employee table, write a SQL query that finds out employees who earn more than their managers. 
-- For the above table, Joe is the only employee who earns more than his manager.

-- +----------+
-- | Employee |
-- +----------+
-- | Joe      |
-- +----------+

-- Solution
create table employee5(
    id  int,
    name    varchar(20),
    salary  int,
    managerid int
);

insert into employee5 values
(1,'Joe',70000,3 ),
(2,'Henry',80000,3 ),
(3,'Sam',60000,NULL ),
(4,'Max',90000,NULL );

select e.name Employee
from employee5 e join employee5 m 
on (e.managerid = m.id)
where e.salary > m.salary;

drop table employee5;
