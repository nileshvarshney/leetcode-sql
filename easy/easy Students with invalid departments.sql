-- Question 36
-- Table: Departments

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about the id of each department of a university.
 

-- Table: Students

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | name          | varchar |
-- | department_id | int     |
-- +---------------+---------+
-- id is the primary key of this table.
-- The table has information about the id of each student at a university and the id of the department he/she studies at.
 

-- Write an SQL query to find the id and the name of all students who are enrolled in departments that no longer exists.

-- Return the result table in any order.

-- The query result format is in the following example:

-- Departments table:
-- +------+--------------------------+
-- | id   | name                     |
-- +------+--------------------------+
-- | 1    | Electrical Engineering   |
-- | 7    | Computer Engineering     |
-- | 13   | Bussiness Administration |
-- +------+--------------------------+

-- Students table:
-- +------+----------+---------------+
-- | id   | name     | department_id |
-- +------+----------+---------------+
-- | 23   | Alice    | 1             |
-- | 1    | Bob      | 7             |
-- | 5    | Jennifer | 13            |
-- | 2    | John     | 14            |
-- | 4    | Jasmine  | 77            |
-- | 3    | Steve    | 74            |
-- | 6    | Luis     | 1             |
-- | 8    | Jonathan | 7             |
-- | 7    | Daiana   | 33            |
-- | 11   | Madelynn | 1             |
-- +------+----------+---------------+

-- Result table:
-- +------+----------+
-- | id   | name     |
-- +------+----------+
-- | 2    | John     |
-- | 7    | Daiana   |
-- | 4    | Jasmine  |
-- | 3    | Steve    |
-- +------+----------+

-- John, Daiana, Steve and Jasmine are enrolled in departments 14, 33, 74 and 77 respectively. 
-- department 14, 33, 74 and 77 doesn't exist in the Departments table.

-- Solution
create table Departments5(
    id      int,
    name    varchar(30)
);
insert into departments5 values (1,'Electrical Engineering'),(7,'Computer Engineering'),(13,'Bussiness Administration');

create table students5 (
    id   int,
    name varchar(20),
    department_id   int
);

insert into students5 values
(23,'Alice',1),
(1,'Bob',7),
(5,'Jennifer',13),
(2,'John',14),
(4,'Jasmine',77),
(3,'Steve',74),
(6,'Luis',1),
(8,'Jonathan',7),
(7,'Daiana',33),
(11,'Madelynn',1);

select students5.id, students5.name from students5 left join Departments5 on (departments5.id = students5.department_id) where Departments5.name is null;

select students5.id, students5.name from students5 where  department_id not in  (select id from Departments5);

select distinct id, name from students5
where not exists(select 1 from Departments5 where Departments5.id = students5.department_id);

drop table students5;
drop table Departments5;