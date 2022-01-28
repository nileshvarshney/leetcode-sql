-- Question 73
-- Table: Actions

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | post_id       | int     |
-- | action_date   | date    |
-- | action        | enum    |
-- | extra         | varchar |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- The action column is an ENUM type of ('view', 'like', 'reaction', 'comment', 'report', 'share').
-- The extra column has optional information about the action such as a reason for report or a type of reaction. 
-- Table: Removals

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | post_id       | int     |
-- | remove_date   | date    | 
-- +---------------+---------+
-- post_id is the primary key of this table.
-- Each row in this table indicates that some post was removed as a result of being reported or as a result of an admin review.
 

-- Write an SQL query to find the average for daily percentage of posts that got removed after being reported as spam, rounded to 2 decimal places.

-- The query result format is in the following example:

-- Actions table:
-- +---------+---------+-------------+--------+--------+
-- | user_id | post_id | action_date | action | extra  |
-- +---------+---------+-------------+--------+--------+
-- | 1       | 1       | 2019-07-01  | view   | null   |
-- | 1       | 1       | 2019-07-01  | like   | null   |
-- | 1       | 1       | 2019-07-01  | share  | null   |
-- | 2       | 2       | 2019-07-04  | view   | null   |
-- | 2       | 2       | 2019-07-04  | report | spam   |
-- | 3       | 4       | 2019-07-04  | view   | null   |
-- | 3       | 4       | 2019-07-04  | report | spam   |
-- | 4       | 3       | 2019-07-02  | view   | null   |
-- | 4       | 3       | 2019-07-02  | report | spam   |
-- | 5       | 2       | 2019-07-03  | view   | null   |
-- | 5       | 2       | 2019-07-03  | report | racism |
-- | 5       | 5       | 2019-07-03  | view   | null   |
-- | 5       | 5       | 2019-07-03  | report | racism |
-- +---------+---------+-------------+--------+--------+

--  table:
-- +---------+-------------+
-- | post_id | remove_date |
-- +---------+-------------+
-- | 2       | 2019-07-20  |
-- | 3       | 2019-07-18  |
-- +---------+-------------+

-- Result table:Removals
-- +-----------------------+
-- | average_daily_percent |
-- +-----------------------+
-- | 75.00                 |
-- +-----------------------+
-- The percentage for 2019-07-04 is 50% because only one post of two spam reported posts was removed.
-- The percentage for 2019-07-02 is 100% because one post was reported as spam and it was removed.
-- The other days had no spam reports so the average is (50 + 100) / 2 = 75%
-- Note that the output is only one number and that we do not care about the remove dates.

-- Solution
CREATE TABLE Actions(
    user_id     int,
    post_id     int,
    action_date date,
    action      varchar(20),
    extra       varchar(20)
);

insert into Actions values
(1,1,'2019-07-01','view',NULL),
(1,1,'2019-07-01','like',NULL),
(1,1,'2019-07-01','share',NULL),
(2,2,'2019-07-04','view',NULL),
(2,2,'2019-07-04','report','spam'),
(3,4,'2019-07-04','view',NULL),
(3,4,'2019-07-04','report','spam'),
(4,3,'2019-07-02','view',NULL),
(4,3,'2019-07-02','report','spam'),
(5,2,'2019-07-03','view',NULL),
(5,2,'2019-07-03','report','racism'),
(5,5,'2019-07-03','view',NULL),
(5,5,'2019-07-03','report','racism');

create table Removals(
    post_id   int,
    remove_date date
);
insert itno Removals values
(2, '2019-07-20'),
(3,'2019-07-18');


WITH t1 as(
    SELECT 
        action_date,
        COUNT(Removals.post_id) /
        COUNT(actions.post_id)  rem_post_ration
    FROM actions left join Removals 
    ON (actions.post_id = Removals.post_id )
    WHERE extra = 'spam' and action = 'report'
    GROUP BY action_date
)
SELECT 
    ROUND(AVG(rem_post_ration)*100,2) average_daily_percent
FROM t1;

drop table Removals;
drop table actions;
