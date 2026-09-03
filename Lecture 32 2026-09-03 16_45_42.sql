-- 1. Take products
-- ↓
-- 2. Keep MRP > 1000
-- ↓
-- 3. Create supplier groups
-- ↓
-- 4. Count products
-- ↓
-- 5. Keep suppliers with > 2
-- ↓
-- 6. Sort highest count first
-- ↓
-- 7. Show top 5\
select * 
from `e1.products`

select
  supplierID,
  count(*) as prd_cnt
from `e1.products`
where MRP>1000
group by SupplierID
having prd_cnt>2
order by prd_cnt desc
limit 5

-- Which customers have placed more than 5 orders?

select *
from `e1.orders`
limit 5

select 
  customerID,
  count(*)as no_of_order
from `e1.orders`
group by CustomerID
having no_of_order>5

-- Suppliers with 2 or Fewer Products

select *
from `e1.products`
limit 5

select 
  supplierID,
  count(*) as no_of_prod
from `e1.products`
group by SupplierID
having no_of_prod<=5

-- Products with Sales Above ₹50,000
select *
from `e1.order_items`
limit 6


select 
  ProductID,
  sum(Total) as sale_s
from `e1.order_items`
group by ProductID
having sale_s>50000



