create table d_customer (
  id int,
  customer_name varchar(30),
  customer_street_address varchar(50),
  customer_zip_code int,
  customer_city varchar(30),
  customer_state varchar(4)
);
insert into
  d_customer
values
  (
    1,
    'Big Customers',
    '7500 Louise Dr.',
    17050,
    'Mechanicsburg',
    'PA'
  ),
  (
    2,
    'Small Stores',
    '2500 Woodland St.',
    17055,
    'Pittsburgh',
    'PA'
  ),
  (
    3,
    'Medium Retailers',
    '1111 Ritter Rd.',
    17055,
    'Pittsburgh',
    'PA'
  ),
  (
    4,
    'Good Companies',
    '9500 Scott St.',
    17050,
    'Mechanicsburg',
    'PA'
  ),
  (
    5,
    'Wonderful Shops',
    '3333 Rossmoyne Rd.',
    17050,
    'Mechanicsburg',
    'PA'
  ),
  (
    6,
    'Loyal Clients',
    '7070 Ritter Rd.',
    17055,
    'Pittsburgh',
    'PA'
  );
create table customer_stage (
    id int,
    customer_name varchar(30),
    customer_street_address varchar(50),
    customer_zip_code int,
    customer_city varchar(30),
    customer_state varchar(4)
  );
insert into
  customer_stage
values
  (
    1,
    'Target',
    '7500 Louise Ave.',
    17550,
    'Mechanicsburg',
    'PA'
  ),
  (
    2,
    'Trader Joy',
    '2500 Woodland St.',
    17055,
    'Las Vegas',
    'NV'
  ),
  (
    3,
    'Safeway',
    '1111 Ritter Rd.',
    17055,
    'Pittsburgh',
    'PA'
  ),
  (
    4,
    'Costco',
    '9500 Scott St.',
    17050,
    'Mechanicsburg',
    'PA'
  ),
  (
    5,
    'Smart and Final',
    '3333 Rossmoyne Rd.',
    17050,
    'Mechanicsburg',
    'PA'
  ),
  (
    6,
    'Walmart',
    '7010 Ritter Rd.',
    17055,
    'San Francisco',
    'CA'
  ),
  (
    7,
    'Lucky',
    '7070 Ritter Rd.',
    17055,
    'Pittsburgh',
    'PA'
  );
update
  d_customer c
set
  customer_name = cs.customer_name,
  customer_street_address = cs.customer_street_address,
  customer_zip_code = cs.customer_zip_code,
  customer_city = cs.customer_city,
  customer_state = cs.customer_state
from
  customer_stage cs
where
  c.id = cs.id
  and (
    c.customer_name != cs.customer_name
    or c.customer_street_address != cs.customer_street_address
    or c.customer_zip_code != cs.customer_zip_code
    or c.customer_city != cs.customer_city
    or c.customer_state != cs.customer_state
  );
insert into
  d_customer
select
  *
from
  customer_stage cs
where
  not exists(
    select
      1
    from
      d_customer c
    where
      c.id = cs.id
  );
drop table d_customer;
drop table customer_stage;