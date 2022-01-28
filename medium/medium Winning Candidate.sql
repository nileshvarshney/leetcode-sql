-- Question 88
-- Table: Candidate

-- +-----+---------+
-- | id  | Name    |
-- +-----+---------+
-- | 1   | A       |
-- | 2   | B       |
-- | 3   | C       |
-- | 4   | D       |
-- | 5   | E       |
-- +-----+---------+  
-- Table: Vote

-- +-----+--------------+
-- | id  | CandidateId  |
-- +-----+--------------+
-- | 1   |     2        |
-- | 2   |     4        |
-- | 3   |     3        |
-- | 4   |     2        |
-- | 5   |     5        |
-- +-----+--------------+
-- id is the auto-increment primary key,
-- CandidateId is the id appeared in Candidate table.
-- Write a sql to find the name of the winning candidate, the above example will return the winner B.

-- +------+
-- | Name |
-- +------+
-- | B    |
-- +------+
-- Notes:

-- You may assume there is no tie, in other words there will be only one winning candidate

-- Solution
create table Candidate
(id         int,
name        varchar(5));
insert into candidate values
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');

create table vote(
    id  int,
    CandidateId int
);

insert into vote values
(1,2),
(2,4),
(3,3),
(4,2),
(5,5);

with t1 as(
    select
        Name, count(CandidateId) cnt
    from Candidate join Vote
    on (vote.CandidateId = Candidate.id)
    group by 1
)
select name from(
    select
        name, rank() over (order by cnt desc) rnk
    from t1
) a where rnk = 1;

drop table vote;
drop table Candidate;

