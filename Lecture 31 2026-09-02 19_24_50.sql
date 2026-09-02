-- order by
-- select 
-- from table
-- order by column
-- default ascending order


select
  ProductID,
  SellingPrice
from `e1.products`
order by SellingPrice asc


select
  ProductID,
  SellingPrice
from `e1.products`
order by SellingPrice desc

order by
select
from table...
order by column(s)
default --> asc
select *
from `e1.products`
limit 5
select
ProductID,
SellingPrice
from `e1.products`
order by SellingPrice asc


-- sort products from most expensive selling price to least

select *
from `e1.order_items`
limit 5



select
  ProductID,
  sellingPrice

from `e1.order_items`
order by SellingPrice desc

-- Show products with MRP above 500, starting with the most
-- expensive.

select *
from `e1.products`
limit 5

select *
from `e1.products`
where MRP>500
order by MRP desc

-- Suppliers with the largest product catalog first.
select *
from `e1.products`
limit 4

select
  SupplierID,
  count(*) as Catalog_size
from `e1.products`
group by SupplierId
order by Catalog_size desc


-- Sort products by category first, and within each category sort
-- by selling price from highest to lowest.

select *
from `e1.products`
order by CategoryID asc, SellingPrice desc
  
