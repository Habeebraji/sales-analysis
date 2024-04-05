# Pizza  sales Analysis

## Project overview
This data analysis project aim to provide insight into sales performance of pizza over past years, by analyzing various aspects of the sales data, we seek to identify trends, make driven recomendation and gain deeper understanding of the company performance. The primary focus areas includes;


 ## Data source
Pizza sales data : The primary source of dataset used in this analyisis is the "Pizza_sales.csv" file containing detailed information about each sales made by the company. This dataset contains the following columns:
Pizza_id
0rder_id
Pizza_name_id
Quantity
Order_date
Order_time
Unit_price
Total_price
Pizza_size
Pizza_category
Pizza_ingredients
Pizza_name

## Tools
- My SQL - Data cleaning and data analysis
- PowerBI - Creating report

  ## Approach used
1. Data wranggling: This is the first step where inspection of data is done to make sure NULL values and missing values are detecteed and replacement method are use to replace them.
 -Utilized SQL queries to search for NULL values within my dataset and subsequently removed them using DELETE statement.
2. Deduplication:This refers to the process of identifying and removing duplicates or redundants entries within a dataset. This ensures that each unique record is represented only once, reducing data redunda.cy and improving accuracy of analysis result.
   -Employed SQL queries to identify and eliminate duplicate rows within the dataset using the appropriate DELETE statement in MySQL.
3. Data typing: This involves specifying the appropriate data types for each column based on the nature of data it contains. This process ensures data accuracy, efficiency, and compatability with the analysis tools and operands.
 -Crafted SQL queries to accurately assign suitable datatypes to each column in the dataset, ensuring data integrity and effective analysis.
4. Feature Engineering: This involves altering the table structure to include a new column, and optionally, populating it with values derived from existing columns.
-Add a new column named "dayname_name" that contains the extracted days of the week which the given transactions took place (Mon,Tue,Wed,Thur,Fri). Helps determine days of the week with highest sales and lowest sales
- Add a new column named "Month_name" that contains the extracted months of the year which the given transactions took place (Jan,Feb,Mar). Helps determine months of the year with highest sales and lowest sales.
- Add a new column named "Hours_of_the_day" to give insight of sales of various hours of the day. This will help answer the question on which hours of the day most sales are made.
- 
  ## Exploratory Data Analysis:
  This involves exploring the sales data to find the aim of the project answer key questions such as:
- Total Revenue
- Average order value
- Total pizza sold
- Total orders
- Average pizza per order
- Daily trend for total orders
- Hourly trend for total orders
- Monthly trend for total orders
- Percentage sale by pizza category
- Percentage sale by pizza size
- Total pizza sold by pizza category
- Top 5 best seller by revenue,total quantity and total orders
-  Least bottom 5 sellers by revenue,total quantity and total orders

## Code

For the rest of the code, check the Sql_queries [Sql_queries](docs/Sql_queries.sql)
```
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
  delete  from my_CTE where duplicate >1; ```
  
 
 ## Results/Findings
 The Analysis results are summarized as follows:
- Majority of the sales occured on Thursdays and Fridays
- July is the month with highest numbers of orders
- Peak orders were observed between 12 and 13 hours of the day.
- Classic pizza is the best performing pizza in terms of revenue and quantity of pizza sold.
- Large pizza sizes is the best performing pizza in terms of revenue.

  ## Recommendation
  Based on the insight obtained from the analysis here are some recommendations:

-Promotional Strategies: Consider implementing targeted promotions or discounts during Thursdays and Fridays to capitalize on the high sales volume observed on these days.
-Inventory Management: Since July has the highest number of orders, ensure adequate inventory levels during this month to meet customer demand and avoid stockouts.
-Optimized Staffing: Schedule additional staff or resources during peak order times between 12 and 13 hours to handle the increased workload efficiently and provide better customer service.
-Marketing Campaigns: Focus marketing efforts on classic pizza offerings, as they contribute the most to revenue and total number of pizzas sold. Highlight the popularity and appeal of classic pizza options in promotional materials and advertising campaigns.
