-- Question 86
-- Get the highest answer rate question from a table  with these columns: id, action, question_id, answer_id, q_num, timestamp.

-- id means user id; action has these kind of values: "show", "answer", "skip"; answer_id is not null when action column is "answer", 
-- while is null for "show" and "skip"; q_num is the numeral order of the question in current session.

-- Write a sql query to identify the question which has the highest answer rate.

-- Example:

-- Input:
-- +------+-----------+--------------+------------+-----------+------------+
-- | id   | action    | question_id  | answer_id  | q_num     | timestamp  |
-- +------+-----------+--------------+------------+-----------+------------+
-- | 5    | show      | 285          | null       | 1         | 123        |
-- | 5    | answer    | 285          | 124124     | 1         | 124        |
-- | 5    | show      | 369          | null       | 2         | 125        |
-- | 5    | skip      | 369          | null       | 2         | 126        |
-- +------+-----------+--------------+------------+-----------+------------+
-- Output:
-- +-------------+
-- | survey_log  |
-- +-------------+
-- |    285      |
-- +-------------+
-- Explanation:
-- question 285 has answer rate 1/1, while question 369 has 0/1 answer rate, so output 285.


-- Note: The highest answer rate meaning is: answer number's ratio in show number in the same question.

-- Solution
create table survey_log(
    id int,
    action varchar(20),
    question_id int,
    answer_id  int,
    q_num  int,
    timestamp int
);

insert into survey_log values
(5, 'show', 285, NULL,1,123),
(5, 'answer', 285, 1234,1,124),
(5, 'show', 369,NULL ,2,125),
(5, 'skip', 369,NULL ,2,126);

with t1 as(
    select
        question_id,
        sum(case when action = 'show' then 1 else 0 end) /
        sum(case when action = 'answer' then 1 else 0 end) ratio
    from survey_log
    group by 1
), t2 as (
select
    question_id,
    dense_rank() over (order by ratio desc ) rnk
from t1
)
select
    question_id survey_log
from t2 where rnk = 1;

drop table survey_log;