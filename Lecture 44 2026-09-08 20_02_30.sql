For every warehouse, calculate:
WarehouseID --> warehouse
Warehouse name --> warehouse
Number of inventory records --> inventory
Total stock --> sum()
Average stock --> avg()
Highest stock in a single inventory record --> max()
Display only warehouses where the average stock per inventory
record is greater than 100. --> having
Sort by total stock descending. --> order by

select 
  w.WarehouseID,
  w.Warehouse,
  count(w.WarehouseID) total_records,
  sum(i.Stock) as total_stocks,
  round(avg(i.stock),2) as average_stocks,
  max(i.stock) as max_stock
from `e1.warehouses` as w
inner join `e1.inventory` as i 
on w.WarehouseID=w.WarehouseID
group by 
  w.WarehouseID,
  w.Warehouse
having average_stocks > 100
order by total_stocks desc

Find products that:
Exist in the product catalogue
Have inventory records
Have never appeared in any order item --> order_items
Display:
ProductID --> product
ProductName --> product
SupplierID --> product
Number of inventory records --> inventory
Total stock --> inventory
Sort by total stock from highest to lowest.

select
  p.ProductID,
  p.ProductName,
  p.SupplierID,
  count(i.WarehouseID) as total_inventory,
  sum(i.Stock) as total_stock
from `e1.products`as p
inner join `e1.inventory` as i
on p.ProductID=i.ProductID
left join `e1.order_items` as oi
on p.ProductID=oi.ProductID
where oi.ProductID is null
group by 
  p.ProductID,
  p.ProductName,
  p.SupplierID
order by total_stock

Find employees who have handled at least one order whose total
value is greater than ₹75,000.
Display:
EmployeeID --> employee
EmployeeName --> employee
Number of high-value orders --> orders
Total value of high-value orders --> order_items
Average high-value order amount --> order_items
having
Sort by total high-value sales from highest to lowest.

select
  e.Name,
  e.EmployeeID,
count(distinct o.OrderID) as no_of_orders,
sum(oi.Total) as high_value_sales_amt,
avg(oi.Total) as avg_high_value_sales_amt
from `e1.employees` as e
inner join `e1.orders` as o
on e.EmployeeID = o.EmployeeID
inner join `e1.order_items` as oi
on o.OrderID = oi.OrderID
group by
  e.Name,
  e.EmployeeID
having high_value_sales_amt > 75000
order by high_value_sales_amt desc



For each supplier, calculate:
SupplierName --> supplier
Number of products --> products
Average MRP --> products
Highest MRP --> products
Lowest MRP --> products
Classify each supplier as:
Premium Supplier if average MRP >= ₹30,000
Mid-Range Supplier if average MRP >= ₹15,000
Budget Supplier otherwise
Display the suppliers with the highest average MRP first.

Budget Supplier otherwise
Display the suppliers with the highest average MRP first.
select
  s.SupplierName,
  count(p.ProductID) as no_of_products,
  avg(p.MRP) as avg_mrp,
  max(p.MRP) as max_mrp,
  min(p.MRP) as min_mrp,
    case  
      when avg(p.MRP) >= 30000 then "Premium Supplier"
      when avg(p.MRP) >= 15000 then "Mid-Range Supplier"
      else "Budget Supplier"
      end as supplierCategory
from `e1.suppliers` as s
inner join `e1.products` as p
on s.SupplierID = p.SupplierID
group by s.SupplierName
order by avg_mrp desc







