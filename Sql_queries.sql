show databases;
use pizza_sales;

--------- Searching for null values----------

select * FROM pizza where pizza_id is NULL or order_id is NULL or pizza_name_id is NULL or
 quantity is NULL or order_date is NULL or order_time is NULL or unit_price is NULL or total_price is NULL or 
 pizza_size is NULL or pizza_category is NULL or 
pizza_ingredients is NULL or pizza_name ;

------- Deleting nulll values-------------

DELETE from pizza where  pizza_id is NULL or order_id is NULL or pizza_name_id is NULL or
 quantity is NULL or order_date is NULL or order_time is NULL or unit_price is NULL or total_price is NULL or 
 pizza_size is NULL or pizza_category is NULL or 
pizza_ingredients is NULL or pizza_name ;

---------- Removing duplicate -----------------
with my_cte as (
select *, row_number() over(partition by pizza_id, order_id, pizza_name_id, quantity, order_date, order_time, unit_price, total_price, pizza_size,
 pizza_category, pizza_ingredients, pizza_name order by pizza_id desc) as duplicate from pizza)
  delete  from my_CTE where duplicate >1;
  
  Describe pizza;  
  -------- Assigning Appropriate data types to columms-----------------
  Alter table pizza modify column pizza_id int not null , modify column order_id int not null ,modify column pizza_name_id text not null, 
 modify column quantity int not null,modify column order_time time not null,modify column unit_price double not null, modify column total_price double not  null,
modify column  pizza_size text not null,modify column pizza_category text not null,modify column pizza_ingredients text not null, 
 modify column pizza_name text not null;
 
 ------ Appropriate date format--------------
 ALTER table pizzza add column order_dates date not null;
 update pizza set order_dates= case when order_date like '%/%' then 
 date_format(str_to_date(order_date, '%m/%d/%Y'),'%Y-%m-%d') 
 when order_date like '%-%' then 
 date_format(str_to_date(order_date, '%m-%d-%Y'),'%Y-%m-%d') end;
 Alter table pizza Drop column order_date;
 
 ------- Extracting Month_name and Days_name to a new column------
 alter table pizza add column month_name text not null;
 Update pizza set month_name = monthname(order_dates);
 alter table pizza add column days_of_week text not null;
update pizzza set days_of_week = dayname(order_dates);
 
 
 --------- Total Revenue---------------
 select sum(total_price) as Total_Revenue from pizza;
 
 ------ Average order value------------------
 
 select sum(total_price)/ (select count(distinct(order_id)) from pizza) as AOV from pizza;
 
 --------- Total pizza sold-------
 select SUM(quantity) as Total_pizza_sold from pizza;
 
 -------- Average pizza per order----------------
 select round(sum(quantity)/(select count(distinct(order_id)) from pizza),1) as Average_pizza_per_order 
 from pizza;
 
 ------------ Daily Trend For Total Orders------------
 select  days_of_week as days, count(distinct(order_id)) as Total_orders  from pizza
 group by days order by Total_orders desc;
 
 --------------- Hourly Trend for Total Orders--------------------
 select hour(order_time) as hours_of_the_day,  count(distinct(order_id)) as Total_orders
 from pizza group by hours_of_the_day order by Total_orders  desc;
 
 -------------- Monthly trend for orders--------------
select month_name, count(order_id) as Total_orders from pizza group by months_name
 order by Total_orders desc;
 
 ---------- Percentage sell by pizza category---------
 select pizza_category, round(sum(total_price)/(select sum(total_price) from pizza) 
  * 100) as percentage_sales from pizza group by pizza_category;
 
 ------------ Percentage sell by pizza sizes ----------------
 select pizza_size, case when pizza_size = "s" then "small" when pizza_size = "L" then "large"
 when pizza_size ="M" then "Medium"when pizza_size = "XL" then "X.large" 
 else "XXLarge" end as sizes from pizza ;
 Alter table pizza add column pizza_sizes text;
 Update pizza set pizza_sizes = case when pizza_size = "s" then "small" when pizza_size = "L" then "large"
 when pizza_size ="M" then "Medium"when pizza_size = "XL" then "X.large" 
 else "XXLarge" end ;
 ALTER  table pizza drop column pizza_size;
 select pizza_sizes, round(sum(total_price)/(select sum(total_price) from  pizza) * 100,1) as percentages
 from pizza group by pizza_sizes;
 
 ------- Total pizza sold by Pizza_Category---------------
 select pizza_category, sum(quantity) as Total_pizza_sold from pizza group by pizza_category;
 

--------- Top 5 best selling pizza_name by sales ----------------
select pizza_name, sum(total_price) as Total_sales from pizza group by Pizza_name order by
Total_sales desc limit 5; 
 
 -------- Bottom 5 least selling Pizz_name by sales---------------
 select pizza_name, sum(total_price) as Total_sales from pizza group by Pizza_name order by
Total_sales asc limit 5; 

---------- Top 5 best selling pizza_name by quantity---------
select pizza_name, sum(quantity) as Total_quantity from pizza group by Pizza_name order by
Total_quantity desc limit 5; 

------------ Bottom 5 least selling Pizza_name by Quantity-------------
select pizza_name, sum(quantity) as Total_quantity from pizza group by Pizza_name order by
Total_quantity asc limit 5; 
