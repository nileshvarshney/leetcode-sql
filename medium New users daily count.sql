-- Question 92
-- Table: Traffic

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | user_id       | int     |
-- | activity      | enum    |
-- | activity_date | date    |
-- +---------------+---------+
-- There is no primary key for this table, it may have duplicate rows.
-- The activity column is an ENUM type of ('login', 'logout', 'jobs', 'groups', 'homepage').
 

-- Write an SQL query that reports for every date within at most 90 days from today, 
-- the number of users that logged in for the first time on that date. Assume today is 2019-06-30.

-- The query result format is in the following example:

-- Traffic table:
-- +---------+----------+---------------+
-- | user_id | activity | activity_date |
-- +---------+----------+---------------+
-- | 1       | login    | 2019-05-01    |
-- | 1       | homepage | 2019-05-01    |
-- | 1       | logout   | 2019-05-01    |
-- | 2       | login    | 2019-06-21    |
-- | 2       | logout   | 2019-06-21    |
-- | 3       | login    | 2019-01-01    |
-- | 3       | jobs     | 2019-01-01    |
-- | 3       | logout   | 2019-01-01    |
-- | 4       | login    | 2019-06-21    |
-- | 4       | groups   | 2019-06-21    |
-- | 4       | logout   | 2019-06-21    |
-- | 5       | login    | 2019-03-01    |
-- | 5       | logout   | 2019-03-01    |
-- | 5       | login    | 2019-06-21    |
-- | 5       | logout   | 2019-06-21    |
-- +---------+----------+---------------+

-- Result table:
-- +------------+-------------+
-- | login_date | user_count  |
-- +------------+-------------+
-- | 2019-05-01 | 1           |
-- | 2019-06-21 | 2           |
-- +------------+-------------+
-- Note that we only care about dates with non zero user count.
-- The user with id 5 first logged in on 2019-03-01 so he's not counted on 2019-06-21.

-- Solution
CREATE TABLE Traffic (
    user_id INT,
    activity VARCHAR(20),
    activity_date DATE
);

insert into  traffic values
(1       , 'login'    , '2019-05-01'),
(1       , 'homepage' , '2019-05-01'),
(1       , 'logout'   , '2019-05-01'),
(2       , 'login'    , '2019-06-21'),
(2       , 'logout'   , '2019-06-21'),
(3       , 'login'    , '2019-01-01'),
(3       , 'jobs'     , '2019-01-01'),
(3       , 'logout'   , '2019-01-01'),
(4       , 'login'    , '2019-06-21'),
(4       , 'groups'   , '2019-06-21'),
(4       , 'logout'   , '2019-06-21'),
(5       , 'login'    , '2019-03-01'),
(5       , 'logout'   , '2019-03-01'),
(5       , 'login'    , '2019-06-21'),
(5       , 'logout'   , '2019-06-21');

SELECT 
    activity_date, COUNT(DISTINCT user_id) user_count
FROM
    traffic t1
WHERE
    activity_date >= DATE_SUB('2019-06-30', INTERVAL 90 DAY)
        AND NOT EXISTS( SELECT 
            1
        FROM
            traffic t2
        WHERE
            activity_date < DATE_SUB('2019-06-30', INTERVAL 90 DAY)
                AND t2.user_id = t1.user_id
                AND activity = 'login')
        AND activity = 'login'
GROUP BY 1;

drop table traffic;