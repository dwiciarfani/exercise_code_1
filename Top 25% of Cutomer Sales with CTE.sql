WITH data_customer as (
SELECT CustomerId,
sum(Total) total_amount
FROM Invoice 
GROUP BY 1),
customer_rank as (
SELECT CustomerId,
total_amount,
percent_rank() over(order by total_amount desc) as ranking
from data_customer
)
select *
from customer_rank
where ranking <= 0.25
order by ranking

