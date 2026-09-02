-- What is the total quantity sold for each product when quantity is greater than 1?
select*
from `e1.order_items`


select
  ProductID,
  sum(Quantity) as total_quantity

from `e1.order_items`
where Quantity>1
group by ProductID


-- What is the average payment for each payment method among successful payments?
select *
from `e1.payments`


select
  Method,
  round(avg(Amount),3) as avg_payment
from `e1.payments`
where Status = "Success"
group by Method

