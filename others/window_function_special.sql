-- moving avg
select a.month_id, a.product_id,
    case
        when count(a.month_id) != 3 then null
        else avg(b.sales)
        end moving_avg from
    simple_fact a join simple_fact b
    on (a.product_id = b.product_id
    and b.month_id between date_sub(a.month_id, interval 2 month) and a.month_id)
group by 1,2
order by 2,1;

-- total sale (partition by month)
select a.month_id,a.product_id,a.sales,
       (select sum(sales) from simple_fact b where b.month_id = a.month_id) total_month_sales
from simple_fact a

-- desnse rank ( month wise)
select a.month_id, a.product_id, a.sales,
       (select count(distinct sales) +1   from simple_fact b where b.sales > a.sales and a.product_id = b.product_id ) rnk
from simple_fact a
order by 4;

-- rank
select a.month_id, a.product_id, a.sales,
       (select count(sales) +1   from simple_fact b where b.sales > a.sales and a.product_id = b.product_id ) rnk
from simple_fact a
order by 4;

-- Running sum
select a.month_id, a.product_id,a.sales,
    (select sum(sales) from simple_fact b where a.product_id = b.product_id and b.month_id <= a.month_id) running_total
from simple_fact a
order by a.product_id, a.month_id
