-- calculate the number of transactions and total payment amount
-- for each Method.
-- Display methods with the highest total payment amount first.

select *
from `e1.payments`
limit 5

select
  count(*) as no_of_transaction,
  sum(Amount) as total_payment
from `e1.payments`
where status ="success"
group by Method
order by total_payment desc

-- Display only products whose total sales value is greater than
-- ₹50,000, sorted by total sales value from highest to lowest.

select *
from `e1.order_items`
limit 5

select 
  ProductID,
  count(*) as no_of_records,
  sum(Total) as total_sales
from `e1.order_items`
where SellingPrice>10000
group by ProductID
having total_sales>50000
order by total_sales desc

-- Using order_items, calculate the total quantity sold and
-- total sales value for every product.
-- Display only products where:
-- Total quantity sold is at least 10
-- Total sales value is greater than ₹1,00,000
-- Sort by total sales value descending
select
  ProductID,
  sum(Quantity) as total_qnt,
  sum(Total) as total_sales
from `e1.order_items`
group by ProductID
having total_qnt >=10 and total_sales > 100000
order by total_sales desc

-- Find products where the selling price is lower than the MRP.
-- Display:
-- ProductID
-- ProductName
-- MRP
-- SellingPrice
-- Discount amount
-- Sort products by the highest discount amount first.

select
  ProductID,
  ProductName,
  MRP,
  SellingPrice,
  (MRP - SellingPrice) AS discount_amount
from `e1.products`
where SellingPrice < MRP
order by discount_amount desc

-- Find customers who have placed between 4 and 8 orders,
-- inclusive.
-- Display:
-- CustomerID
-- Number of orders
-- Sort customers by order count descending and display only the
-- top 10.

select * 
from `e1.orders`

select
  CustomerID,
  count(*) as num_of_orders 
from `e1.orders`
group by CustomerID
having num_of_orders between 4 add 8
order by num_of_orders desc
-- limit 10

select
  CustomerID,
  count(*) as num_of_orders
from `e1.orders`
group by CustomerID
having num_of_orders between 4 and 8
order by num_of_orders desc
limit 10

-- Calculate the number of orders and percentage of total orders
-- represented by each order status.
-- A - 10 - 10/70
-- B - 20 - 20/70
-- C - 40 - 40/70
select *
from `e1.orders`
select 
  Status,
  count(*)as no_of_orders,
  round(count(*)*100/(select count(*) from `e1.orders`),2) as percentage_of_orders
from `e1.orders`
group by Status
order by no_of_orders desc

-- Find products whose MRP is greater than the average MRP of all
-- products.
select avg(MRP)
from `e1.products`

select *
from `e1.products`
where MRP>2312.74

select *
from `e1.products`
where MRP >=(
    select avg(MRP)
    from `e1.products`
);

SELECT *
FROM `e1.products`
WHERE MRP >= (
    SELECT AVG(MRP)
    FROM `e1.products`
);
Find products whose MRP is below the average MRP.
select *
from `e1.products`
where MRP <(select avg(MRP) from `e1.products`)

-- find all the products whose mrp is greater than the average mrp
select *
from `e1.products`
where MRP >(select avg(MRP) from `e1.products`)

-- filter out those products whose mrp is among the top 5 distinct
-- highest mrps
select MRP
from `e1.products`
order by MRP desc
limit 5

select *
from `e1.products`
where MRP in (4937,4927,4880,4698,4662)

-- super crazy mentos zindagi
select *
from `e1.products`
where MRP in (select distinct MRP
              from `e1.products`
              order by MRP desc
              limit 5)


-- Find the product or products having the highest MRP.
select *
from `e1.products`
where MRP in (select max(mrp) from `e1.products`)

-- Find suppliers whose number of products is
-- greater than the average number of products supplied per
-- supplier.
-- s1 --> c1
-- s2 --> c2
-- s3 --> c3
-- avg -> c1+c2+c3/3

select
  SupplierID,
count(*) as no_of_products
from `e1.products`
group by SupplierID

select
  SupplierID,
  count(*) as no_of_prds
from `e1.products`
group by SupplierID
having no_of_prds >=(
                    select avg(no_of_products)
                    from (select
                            SupplierID,
                            count(*) as no_of_products
                          from `e1.products`
                          group by SupplierID
                          )
                    )

alter table `e1.categories`
rename column string_field_0 to CategoryID

alter table `e1.categories`
rename column string_field_1 to CategoryName

-- "Show me the product name and the category name."
products -- Product Name
linkage: categoryID
Category -- category Name
tableName.columnName


-- syntax:
select
from table1
join table2
on table1.key = table2.key


select
  p.ProductID,
  p.ProductName,
  c.CategoryID,
  c.CategoryName
from `e1.categories` as c
inner join `e1.products` as p
on c.CategoryID = p.CategoryID


-- Display products belonging to the Electronics category.
select
  p.ProductID,
  p.ProductName,
  c.CategoryID,
  c.CategoryName
from `e1.categories` as c
inner join `e1.products` as p
on c.CategoryID = p.CategoryID
where c.CategoryName= 'Electronics'

-- Display products with their category names, sorted by MRP from
-- highest to lowest.
select 
  p.ProductID,
  p.ProductName,
  c.CategoryID,
  c.CategoryName
from `e1.categories`as c
inner join `e1.products`as p
on c.CategoryID=p.CategoryID 
order by p.MRP desc

-- Display ProductName, CategoryName and discount amount

select 
  p.ProductID,
  p.ProductName,
  c.CategoryID,
  c.CategoryName,
  p.MRP - p.SellingPrice as discount_mrp
from `e1.categories`as c
inner join `e1.products`as p
on c.CategoryID=p.CategoryID 


-- 1.customer name -> customer
-- 2. linkage -> table: orders
-- customerid -> orders + customer
-- orderid -> orders + order_items
-- 3.total sales -> order_items

select
  c.CustomerID,
  sum(oi.Total) as total_sales
from `e1.customers` as c
inner join `e1.orders` as o
on c.CustomerID = o.CustomerID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
group by c.CustomerID
order by total_sales desc

-- Calculate total sales generated by products from each supplier
select
  s.SupplierID,
  s.SupplierName,
  sum(o.Total) as total_sales
from `e1.products` as p
inner join `e1.order_items` as o
on p.ProductID = o.ProductID
inner join `e1.suppliers` as s
on s.SupplierID = p.SupplierID
group by s.SupplierID, s.SupplierName
order by total_sales desc;


-- Find Products With No Sales

select
  p.ProductID,
  p.ProductName,
  sum(oi.Total) as sales
from `e1.products` as p
left join `e1.order_items` as oi
on p.ProductID = oi.ProductID
group by p.ProductID, p.ProductName

select
  p.ProductID,
  p.ProductName,
  sum(oi.Total) as sales
from `e1.products` as p
left join `e1.order_items` as oi
on p.ProductID = oi.ProductID
where oi.ProductID is null
group by p.ProductID, p.ProductName

-- Customers who registered but have never placed an order.
select
  c.Name,
  c.CustomerID,
  o.CustmerID,
  o.OrderID
from `e1.customers` as c
left join `e1.orders` as o
on c.CustomerID = o.CustomerID
where o.Order is null

-- COALESCE() is used to replace NULL with another value that come after that
select
  s.SupplierID,
  s.SupplierName,
  count(distinct p.ProductID) as prd_cnt,
  avg(p.MRP) as avg_mrp,
  coalesce(sum(oi.Total),0) as total_sales,
  coalesce(sum(oi.Quantity),0) as total_qty
from `e1.suppliers` as s
left join `e1.products` as p
on s.SupplierID = p.SupplierID
left join `e1.order_items` as oi
on p.ProductID = oi.ProductID
group by
s.SupplierID,
s.SupplierName
order by total_sales desc








