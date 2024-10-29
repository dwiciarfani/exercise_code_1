-- Find the second highest 
select CustomerId, sum(Total) total_amount 
from Invoice 
group by 1
order by 2 DESC 
limit 1 offset 1;

-- Difference rank() , dense_rank(), row_number()
with total_spending as (
select CustomerId,
sum(Total) total_amount 
from Invoice
group by 1)
select ts.* ,
row_number() over (order by total_amount desc) as r_rownum, --memberi peringkat dengan unique
rank() over(order by total_amount desc) as r_rank, --memberi peringkat, jika ada yang sama akan dibuat sama dan selanjutnya akan berlanjut 
dense_rank () over(order by total_amount desc) as r_dense_rank --memberi peringkat, jika ada yang sama akan dibuat sama dan selanjutnya akan berlanjut tanpa gap
from total_spending ts
order by 2 desc;

--Using case when
with total_spending as (
select CustomerId,
sum(Total) total_amount 
from Invoice
group by 1),
data_category as (
select ts.*,
case when total_amount < 37 then '3.low'
when total_amount between 37 and 42 then '2.medium'
else '1.high' end as category_amount
from total_spending ts
)
select category_amount, count(distinct CustomerId) as cnt_customer
from data_category
group by 1
order by 1;

-- detect duplicate value 
-- if only 1 column
select CustomerId, count(*)
from Invoice
group by 1
having count(*) > 1;

--if multiple column
select CustomerId, BillingCountry, count(*)
from Invoice
group by 1
having count(*) > 1;

--return all column
select * 
from Customer c
join (
select CustomerId
from Invoice
group by 1
having count(*) > 1 ) d on c.CustomerID = d.CustomerID;






