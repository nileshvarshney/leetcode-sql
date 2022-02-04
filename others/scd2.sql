create table target (
  id int,
  amount int,
  startdate timestamp,
  enddate timestamp,
  active int
);
insert into
  target
values
  (
    1,
    10,
    '2019-01-01 12:00:00',
    '2019-01-20 05:00:00',
    0
  ),
  (1, 20, '2019-01-20 05:00:00', NULL, 1),
  (2, 100, '2019-01-01 00:00:00', NULL, 1),
  (
    3,
    75,
    '2019-01-01 06:00:00',
    '2019-01-26 08:00:00',
    0
  ),
  (3, 750, '2019-01-26 08:00:00', NULL, 1),
  (10, 40, '2019-01-01 00:00:00', NULL, 1);
create table source (
    id int,
    amount int,
    startdate TIMESTAMP,
    enddate TIMESTAMP,
    active int
  );
insert into
  source
values
  (
    1,
    50,
    '2019-02-01 07:00:00',
    '2019-02-02 08:00:00',
    0
  ),
  (1, 75, '2019-02-02 08:00:00', NULL, 1),
  (
    2,
    200,
    '2019-02-01 05:00:00',
    '2019-02-01 13:00:00',
    0
  ),
  (
    2,
    60,
    '2019-02-01 13:00:00',
    '2019-02-01 19:00:00',
    0
  ),
  (2, 500, '2019-02-01 19:00:00', NULL, 1),
  (3, 175, '2019-02-01 00:00:00', NULL, 1),
  (
    4,
    50,
    '2019-02-02 12:00:00',
    '2019-02-02 14:00:00',
    0
  ),
  (4, 300, '2019-02-02 14:00:00', NULL, 1);
MERGE into target t using source s on t.id = s.id
  WHEN MATCHED then
update
set
  t.enddate = s.startdate,
  t.active = 0
  WHEN NOT MATCHED then
insert
  (id, amount, startdate, enddate, active)
values
  (s.id, s.amount, s.startdate, s.enddate, active);
-- expire existing data
update
  target t
set
  enddate = s.startdate,
  active = 0
from
  source s
where
  s.id = t.id
  and s.active = t.active
  and s.active = 1;
--  insert new data data
insert into
  target as
select
  *
from
  source;
-- drop table
  drop table target;
drop table source