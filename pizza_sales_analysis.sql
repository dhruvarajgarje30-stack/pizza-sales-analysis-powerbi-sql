USE Pizza_DB
select * from pizza_sales;

-- ============================================
-- KPI CALCULATIONS
-- ============================================

-- Total Revenue
select sum(total_price) as total_revenue
from pizza_sales;

-- Average order value
select sum(total_price) / count(distinct order_id) as avg_order_value
from pizza_sales;

-- Total pizzas sold
select sum(quantity) as total_pizzas_sold
from pizza_sales;

-- Total orders
select count(distinct order_id) as total_orders
from pizza_sales;

-- Average pizzas per order
select cast(cast(sum(quantity) as decimal(10,2)) / 
       cast(count(distinct order_id) as decimal (10,2)) as decimal (10,2)) 
       as avg_pizza_per_order
from pizza_sales;

-- ============================================
-- SALES ANALYSIS
-- ============================================

-- Daily trend of total orders
select DATENAME(DW,order_date) as day_of_order,count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(DW,order_date)
order by total_orders desc;

-- Monthly trend of total orders
select DATENAME(month,order_date) as month_name, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(month,order_date)
order by total_orders desc;

-- percentage of sales by pizza category
select pizza_category, cast(sum(total_price) as decimal (10,2)) as total_sales,
       cast(sum(total_price) * 100/ (select sum(total_price) from pizza_sales) as decimal (10,2)) 
       as pct_of_sales
from pizza_sales
group by pizza_category
order by pct_of_sales desc;

-- percentage of sales by pizza size
select pizza_size, cast(sum(total_price) as decimal (10,2)) as total_sales,
       cast(sum(total_price) * 100/ (select sum(total_price) from pizza_sales where DATEPART(quarter,order_date) = 1)
       as decimal (10,2)) 
       as pct_of_sales
from pizza_sales
where DATEPART(quarter,order_date) = 1
group by pizza_size
order by pct_of_sales desc;

-- ============================================
-- TOP 5 / BOTTOM 5
-- ============================================

-- Top 5 best sellers by Total revenue
select top 5 pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc

-- Top 5 best sellers by Total quantity
select top 5 pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity desc

-- Top 5 best sellers by Total Orders
select top 5 pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders desc;

-- Bottom 5 best sellers by Total revenue
select top 5 pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue;

-- Bottom 5 best sellers by Total quantity
select top 5 pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity; 

-- Bottom 5 best sellers by Total Orders
select top 5 pizza_name, count(distinct order_id) as total_orders
from pizza_sales
group by pizza_name
order by total_orders;

