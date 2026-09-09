Find products whose MRP is greater than the average MRP of all
products.
Display:
ProductID --> product
ProductName --> product
CategoryName --> category
MRP --> product
Sort from highest MRP to lowest.

select 
  p.ProductID,
  p.ProductName,
  c.CategoryName,
  p,MRP
from `e1.products` as p
inner join `e1.categories`as c
on p.CategoryID=c.CategoryID
where p.MRP >(
  select avg(MRP)
  from `e1.products`
)
order by p.MRP desc


For each warehouse, calculate total stock and classify the
warehouse as:
High Stock → total stock >= 5,000
Medium Stock → total stock >= 2,500
Low Stock → total stock < 2,500
Display:
WarehouseID --> warehouse
Warehouse name --> warehouse
Total stock --> inventory
Average stock --> inventory
Stock classification --> case when on stock column --> inventory
Sort warehouses by total stock descending.


select
  w.WarehouseID,
  w.warehouse,
  sum(i.stock) as total_stock,
  round(avg(i.stock),2) as average_stock,
  case 
    when sum(i.stock) >= 5000 then "High stock"
    when sum(i.stock) >= 2500 then "Medium stock"
    when sum(i.stock) < 2500 then "Low stock"
  end as stockclarification
from `e1.warehouses` as w
inner join `e1.inventory` as i
on w.WarehouseID=i.WarehouseID
group by 
  w.WarehouseID,
  w.Warehouse
order by total_stock desc


-- total sale made by each product
select
  ProductID,
  sum(Total) as total_sales
from `e1.order_items`
group by ProductID


-- show evey order item record but also show the total sales of that product beside every row 

select
  ProductID,
  OrderID,
  Total,
  sum(Total) over(partition by ProductID) as product_total_sales
from `e1.order_items`



-- windows function 
function() over(partition by column order by column)

For every order-item record, display:
ProductID
SellingPrice
Average selling price of that product

select
  ProductID,
  SellingPrice,
  avg(SellingPrice) over(partition by ProductID) as pro_avg_price
from `e1.order_items`

For every order-item record, show:
ProductID
OrderID
Number of order-item records for that product
select
  ProductID,
  OrderID,
  count(*) over(partition by ProductID) as no_of_records
from `e1.order_items`


For every order-item record, display:
OrderID
ProductID
Total
Total sales across the entire order_items table

select 
  OrderID,
  ProductID,
  overall_sales,
  round((total*100)/overall_sales, 4) as perc_total_sales
from (select
  OrderID,
  ProductID,
  Total,
  sum(Total) over() as overall_sales
from `e1.order_items`)

-- Display every order-item record and assign a row number based on
-- Total, from highest to lowest.

select 
  OrderID,
  ProductID,
  Total,
  row_number() over(order by total desc) as row_num
from `e1.order_items`
