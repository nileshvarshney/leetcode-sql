-- Question 105
-- A U.S graduate school has students from Asia, Europe and America. The students' location information are stored in table student as below.
-- | name   | continent |
-- |--------|-----------|
-- | Jack   | America   |
-- | Pascal | Europe    |
-- | Xi     | Asia      |
-- | Jane   | America   |
-- Pivot the continent column in this table so that each name is sorted alphabetically and displayed underneath its corresponding continent. The output headers should be America, Asia and Europe respectively. It is guaranteed that the student number from America is no less than either Asia or Europe.
-- For the sample input, the output is:
-- | America | Asia | Europe |
-- |---------|------|--------|
-- | Jack    | Xi   | Pascal |
-- | Jane    |      |        |
-- Solution
create table location5(name varchar(30), continent varchar(20));
insert into
  location5
VALUES
  ('Jack', 'America'),
  ('Pascal', 'Europe'),
  ('Xi', 'Asia'),
  ('Jane', 'America');
SELECT
  MIN(if (continent = 'America', name, null)) "America",
  MIN(if (continent = 'Asia', name, null)) "Asia",
  MIN(if (continent = 'Europe', name, null)) "Europe"
FROM
  (
    select
      *,
      row_number() over(
        partition by continent
        order by
          name
      ) rno
    from
      location5
  ) x
group by
  rno
order by
  1,
  2,
  3;
drop table location5;