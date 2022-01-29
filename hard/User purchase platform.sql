-- Question 113
-- Table: Spending
-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | spend_date  | date    |
-- | platform    | enum    |
-- | amount      | int     |
-- +-------------+---------+
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop and a mobile application.
-- (user_id, spend_date, platform) is the primary key of this table.
-- The platform column is an ENUM type of ('desktop', 'mobile').
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only and both mobile and desktop together for each date.
-- The query result format is in the following example:
-- Spending table:
-- +---------+------------+----------+--------+
-- | user_id | spend_date | platform | amount |
-- +---------+------------+----------+--------+
-- | 1       | 2019-07-01 | mobile   | 100    |
-- | 1       | 2019-07-01 | desktop  | 100    |
-- | 2       | 2019-07-01 | mobile   | 100    |
-- | 2       | 2019-07-02 | mobile   | 100    |
-- | 3       | 2019-07-01 | desktop  | 100    |
-- | 3       | 2019-07-02 | desktop  | 100    |
-- +---------+------------+----------+--------+
-- Result table:
-- +------------+----------+--------------+-------------+
-- | spend_date | platform | total_amount | total_users |
-- +------------+----------+--------------+-------------+
-- | 2019-07-01 | desktop  | 100          | 1           |
-- | 2019-07-01 | mobile   | 100          | 1           |
-- | 2019-07-01 | both     | 200          | 1           |
-- | 2019-07-02 | desktop  | 100          | 1           |
-- | 2019-07-02 | mobile   | 100          | 1           |
-- | 2019-07-02 | both     | 0            | 0           |
-- +------------+----------+--------------+-------------+
-- On 2019-07-01, user 1 purchased using both desktop and mobile, user 2 purchased using mobile only and user 3 purchased using desktop only.
-- On 2019-07-02, user 2 purchased using mobile only, user 3 purchased using desktop only and no one purchased using both platforms.
-- Solution
create table spending5 (
  user_id int,
  spend_date date,
  platform varchar(10),
  amount int
);
insert into
  spending5
VALUES
  (1, '2019-07-01', 'mobile', 100),
  (1, '2019-07-01', 'desktop', 100),
  (2, '2019-07-01', 'mobile', 100),
  (2, '2019-07-02', 'mobile', 100),
  (3, '2019-07-01', 'desktop', 100),
  (3, '2019-07-02', 'desktop', 100);
with t1 as(
    select
      spend_date,
      user_id,
      count(DISTINCT platform) cnt_platform,
      sum(amount) total_amount
    from
      Spending5
    group by
      spend_date,
      user_id
    having
      count(DISTINCT platform) > 1
  ) -- select spend_date, 'both' platform, sum(total_amount) total_amount, count(user_id) total_users from t1 group by 1,2
select
  spend_date,
  platform,
  sum(amount) total_amount,
  count(user_id)
from
  Spending5 not exists (
    Select
      1
    from
      t1
    where
      t1.spend_Date = Spending5.spend_Date
      and t1.user_id = Spending5.user_id
  )
group by
  1,
  2;
with t1 as(
    select
      spend_date,
      user_id,
      count(DISTINCT platform) cnt_platform,
      sum(amount) total_amount
    from
      Spending5
    group by
      spend_date,
      user_id
    having
      count(DISTINCT platform) > 1
  ),
  t2 as(
    select
      distinct spend_date,
      'desktop' platform
    from
      Spending5
    union ALL
    select
      distinct spend_date,
      'mobile' platform
    from
      Spending5
    union all
    select
      distinct spend_date,
      'both' platform
    from
      Spending5
  )
select
  t2.spend_date,
  t2.platform,
  coalesce(total_amount, 0) total_amount,
  coalesce(total_users, 0) total_users
from
  t2
  left join (
    select
      spend_date,
      'both' platform,
      sum(total_amount) total_amount,
      count(user_id) total_users
    from
      t1
    group by
      1,
      2
    union all
    select
      spend_date,
      platform,
      sum(amount) total_amount,
      count(user_id)
    from
      Spending5
    where
      not exists (
        Select
          1
        from
          t1
        where
          t1.spend_Date = Spending5.spend_Date
          and t1.user_id = Spending5.user_id
      )
    group by
      1,
      2
  ) x on (
    x.spend_date = t2.spend_date
    and x.platform = cast(t2.platform as char)
  )
order by
  1,
  2;
drop table spending5;