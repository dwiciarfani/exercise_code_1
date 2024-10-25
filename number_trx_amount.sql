-- Number of Transaction and Amount of Customer
select CustomerId , count(distinct InvoiceId) cnt_invoice, sum(Total) as total_amount
from Invoice 
group by 1
order by 2 desc

