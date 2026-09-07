select 
  e.EmployeeID,
  e.Name,
  e.Department,
  count(distinct o.OrderID)as orders_handled,
  count(
  distinct case
  when OrderTotals.order_values > 50000
  then o.OrderID
  end
 ) as highvaluesorders,
 sum(OrderTotals.order_values) as total_sales
from `e1.employees` as e
inner join `e1.orders`as o
on e.EmployeeID=o.EmployeeID
inner join (select 
  OrderID,
  sum(total) as order_values
from `e1.order_items` as oi
group by OrderID) as OrderTotals
on o.OrderID=OrderTotals.OrderID
group by
 e.EmployeeID,
 e.Name,
 e.Department 
having orders_handled >= 5
order by total_sales desc






select
c.City,
count(distinct c.CustomerID) as no_of_customers,
count(distinct o.OrderID) as no_of_orders,
sum(oi.Total) as total_sales,
round(avg(oi.Total),2) as avg_item_value
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
group by c.City
having total_sales> 300000
order by total_sales desc



select
c.CategoryName,
count(distinct p.ProductID) as no_of_products,
min(p.MRP) as min_mrp,
max(p.MRP) as max_mrp,
max(p.MRP) - min(p.MRP) as mrp_diff
from `e1.categories` as c
inner join `e1.products` as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
having mrp_diff > 1




select
Method,
count(*) as succ_trans,
sum(Amount) as succ_amt,
round(avg(Amount),2) as avg_amt,
max(Amount) as max_amt
from `e1.payments`
where Status = "Success"
group by Method
having succ_trans > 10
order by avg_amt desc
