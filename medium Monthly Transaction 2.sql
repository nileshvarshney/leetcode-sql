-- Question 95
-- Table: Transactions

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | id             | int     |
-- | country        | varchar |
-- | state          | enum    |
-- | amount         | int     |
-- | trans_date     | date    |
-- +----------------+---------+
-- id is the primary key of this table.
-- The table has information about incoming transactions.
-- The state column is an enum of type ["approved", "declined"].
-- Table: Chargebacks

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | trans_id       | int     |
-- | charge_date    | date    |
-- +----------------+---------+
-- Chargebacks contains basic information regarding incoming chargebacks from some transactions placed in Transactions table.
-- trans_id is a foreign key to the id column of Transactions table.
-- Each chargeback corresponds to a transaction made previously even if they were not approved.
 

-- Write an SQL query to find for each month and country, the number of approved transactions and their total amount, the number of chargebacks and their total amount.

-- Note: In your query, given the month and country, ignore rows with all zeros.

-- The query result format is in the following example:

-- Transactions table:
-- +------+---------+----------+--------+------------+
-- | id   | country | state    | amount | trans_date |
-- +------+---------+----------+--------+------------+
-- | 101  | US      | approved | 1000   | 2019-05-18 |
-- | 102  | US      | declined | 2000   | 2019-05-19 |
-- | 103  | US      | approved | 3000   | 2019-06-10 |
-- | 104  | US      | approved | 4000   | 2019-06-13 |
-- | 105  | US      | approved | 5000   | 2019-06-15 |
-- +------+---------+----------+--------+------------+

-- Chargebacks table:
-- +------------+------------+
-- | trans_id   | trans_date |
-- +------------+------------+
-- | 102        | 2019-05-29 |
-- | 101        | 2019-06-30 |
-- | 105        | 2019-09-18 |
-- +------------+------------+

-- Result table:
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | month    | country | approved_count | approved_amount | chargeback_count  | chargeback_amount  |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+
-- | 2019-05  | US      | 1              | 1000            | 1                 | 2000               |
-- | 2019-06  | US      | 3              | 12000           | 1                 | 1000               |
-- | 2019-09  | US      | 0              | 0               | 1                 | 5000               |
-- +----------+---------+----------------+-----------------+-------------------+--------------------+

-- Solution
create table Transactions(
    id          int,
    country     varchar(20),
    state       varchar(20),
    amount      int,
    trans_date  date
);
insert into Transactions values
( 101,'US','approved',1000,'2019-05-18'),
( 102,'US','declined',2000,'2019-05-19'),
( 103,'US','approved',3000,'2019-06-10'),
( 104,'US','approved',4000,'2019-06-13'),
( 105,'US','approved',5000,'2019-06-15');

create table Chargebacks(
    trans_id        int,
    trans_date      date 
);
insert into Chargebacks values
(102,'2019-05-29'),
(101,'2019-06-30'),
(105,'2019-09-18');



with t1 as(
    select
        substr(trans_date,1,7) month,
        country,
        COUNT(case when state = 'approved' then 1 else null end) approved_count,
        SUM(case when state = 'approved' then amount else null end) approved_amount
    FROM Transactions
    GROUP by 1,2
), t2 as(
    SELECT
        substr(Chargebacks.trans_date,1,7) month,
        country,
        COUNT(amount) chargeback_count,
        SUM(amount) chargeback_amount
    FROM Chargebacks  join Transactions on (Chargebacks.trans_id = Transactions.id )
    GROUP by 1,2
)
SELECT
    t2.month,
    t2.country,
    coalesce(approved_count,0) approved_count,
    coalesce(approved_amount,0) approved_amount,
    chargeback_count,
    chargeback_amount
from t2 left join t1 on(t1.month = t2.month);

drop table Chargebacks;
drop table Transactions;