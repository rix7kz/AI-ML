select distinct
  city
from `e1.customers`

-- display all customers from nagpur

select *
from e1.customers
where city = "Nagpur"

-- display all the female customers

select *
from `e1.customers`
where gender="F"

-- display cutomers older than 30
select *
from `e1.customers`
where age>30

-- display all the delivered product
select *
from `e1.orders`
where status="Delivered"

select distinct Name
from `e1.customers`

-- count conts the total no of rows
select count(*)
from `e1.customers`

select count(*)
from `e1.customers`
where city="Mumbai"

select count(*)
from `e1.employees`
where department ="Operation"

select count(distinct CategoryID)
from `e1.products`

-- how many different cities do the customers belong to 
select count(distinct city)
from `e1.customers`

-- count(column) conts the number of non null values in column 


-- how many different suuplier state exist
select count(distinct state)
from `e1.suppliers`


select sum(Total)
from `e1.order_items`

-- how many individual product units has been sold across all over order-item records?
select sum(Quantity)
from `e1.order_items`

