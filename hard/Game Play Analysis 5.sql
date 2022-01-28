-- Question 111
-- Table: Activity

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on some day using some device.
 

-- We define the install date of a player to be the first login day of that player.

-- We also define day 1 retention of some date X to be the number of players whose install date is X and they logged back in on the day right after X, divided by the number of players whose install date is X, rounded to 2 decimal places.

-- Write an SQL query that reports for each install date, the number of players that installed the game on that day and the day 1 retention.

-- The query result format is in the following example:

-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-01 | 0            |
-- | 3         | 4         | 2016-07-03 | 5            |
-- +-----------+-----------+------------+--------------+

-- Result table:
-- +------------+----------+----------------+
-- | install_dt | installs | Day1_retention |
-- +------------+----------+----------------+
-- | 2016-03-01 | 2        | 0.50           |
-- | 2017-06-25 | 1        | 0.00           |
-- +------------+----------+----------------+
-- Player 1 and 3 installed the game on 2016-03-01 but only player 1 logged back in on 2016-03-02 so the
-- day 1 retention of 2016-03-01 is 1 / 2 = 0.50
-- Player 2 installed the game on 2017-06-25 but didn't log back in on 2017-06-26 so the day 1 retention of 2017-06-25 is 0 / 1 = 0.00

-- Solution
create table activity5(
    player_id int, device_id int, event_date date, games_played int);

drop table activity5;
insert into activity5 values
(1,2,'2016-03-02',6),
(2,3,'2016-06-25',1),
(1,2,'2016-03-01',5),
(3,1,'2016-03-01',0),
(3,4,'2016-07-03',5);

with t1 as(
select *,
	count(1) over(partition by event_date) intall_count,
	datediff(lead(event_date,1) over(partition by player_id order by event_date), event_date) lead_day
from activity5
), t2 as(
select 
	player_id, 
    min(event_date) event_date from activity5 group by 1)
select 
	event_date, 
	intall_count installs,
    round(count(if(lead_day = 1, 1 , null))/ count(event_date),2) Day1_retention 
from t2 join t1 using (event_date, player_id)
group by 1,2;

with t1 as(
	select *,
    row_number() over (partition by player_id order by event_date asc) rno,
    min(event_date) over(partition by player_id order by event_date) min_date,
    datediff(lead(event_date,1) over(partition by player_id order by event_date), event_date)lead_diff
    from activity5
)
select 
	event_date install_dt, 
    count(device_id) installs, 
    count(if(lead_diff = 1, 1, null))/count(1) Day1_retention 
from t1
where rno = 1 
group by 1;

drop table activity5;

