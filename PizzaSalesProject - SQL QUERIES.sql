

SELECT * FROM pizza_sales_portfolio
--SANYASI NAIDU LALAM--
--Total Revenue: The sum of the total price of all pizza orders.
SELECT SUM(total_price) AS Total_Revenue from pizza_sales_portfolio

--Average Order Value: The average amount spent per order, 
--calculated by dividing the total revenue by the total number of orders.
SELECT SUM(total_price) / COUNT(DISTINCT order_id) As Avg_order_value
from pizza_sales_portfolio


--Total Pizzas Sold: The sum of the quantities of all pizzas sold.
SELECT SUM(quantity) as Total_Pizzas_Sold from pizza_sales_portfolio


-- Total Orders: The total number of orders placed.
SELECT COUNT(DISTINCT order_id) AS Total_order 
FROM pizza_sales_portfolio

-- Average Pizzas Per Order: The average number of pizzas sold per order, 
--calculated by dividing the total number of pizzas sold by the total number of orders.
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2))/
CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2))
AS Avg_pizzas_per_order FROM pizza_sales_portfolio
--CAST FOR CONVERTING DECIMAL



--Total Revenue by Pizza Category:
--How much revenue is generated from each pizza category 
--(e.g., Veg, Non-Veg, Vegan)?
SELECT pizza_category, SUM(total_price) AS total_revenue 
FROM pizza_sales_portfolio GROUP BY pizza_category;


--Most Popular Pizza Size:
--Which pizza size (e.g: S, M, L) is ordered the most frequently?
SELECT pizza_size, COUNT(*) AS size_count FROM pizza_sales_portfolio 
GROUP BY pizza_size ORDER BY size_count DESC;


--Most Popular Pizza: Top 10
--Which specific pizza (pizza name) has the highest number of orders?
SELECT TOP 10 pizza_name, COUNT(*) AS order_count 
FROM pizza_sales_portfolio 
GROUP BY pizza_name 
ORDER BY order_count DESC;


--Peak Order Time:
--What is the most common time of day for orders to be placed?
SELECT TOP 10 order_time, COUNT(*) AS order_count 
FROM pizza_sales_portfolio 
GROUP BY order_time
ORDER BY order_count DESC;



--Average Order Value by Pizza Category:
--What is the average order value for each pizza category?
SELECT pizza_category, SUM(total_price) / COUNT(DISTINCT order_id) 
AS average_order_value 
FROM pizza_sales_portfolio GROUP BY pizza_category;



--Total Quantity of Each Pizza Sold:
--How many of each specific pizza (pizza name) have been sold?
SELECT TOP 10
    pizza_name,
    SUM(quantity) AS total_quantity_sold
FROM
    pizza_sales_portfolio
GROUP BY
    pizza_name
ORDER BY
    total_quantity_sold DESC;



-- FOR CHATRS REQUIREMENTS
-- Daily Trend for Total Orders:
SELECT DATENAME(DW, order_date) AS day_day,
COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales_portfolio
GROUP BY DATENAME(DW, order_date)



--Monthly Trend for Total Orders 
SELECT DATENAME(MONTH, order_date) AS Month_name,
       COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales_portfolio
GROUP BY DATEname(MONTH, order_date)
ORDER BY Total_orders DESC


--Percentage of Sales by Pizza Category:
--Whenever we using filter in the subquery , 
--that should be added in subquery as well
SELECT pizza_category,
SUM(total_price)*100 / (SELECT SUM(total_price) 
FROM pizza_sales_portfolio WHERE MONTH(order_date) = 1
) AS PCT_Total_sales
FROM pizza_sales_portfolio 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category
-- Here MONTH(order_date)=1 indicates o/p for the month of Jan
-- If MONTH(order_date)=6 indicates o/p for June


--SANYASI NAIDU LALAM--
--Percentage of Sales by Pizza Size:
SELECT pizza_size,
CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales, 
CAST(SUM(total_price)*100/ 
(SELECT SUM(total_price) 
FROM pizza_sales_portfolio WHERE DATEPART(QUARTER, order_date) = 1) 
AS DECIMAL (10,2) 
) AS PCT_Total_sales
FROM pizza_sales_portfolio 
WHERE DATEPART(QUARTER, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_Total_sales DESC
-- Here DATEPART(QUARTER, order_date) = 1 indicates o/p for the QUARTER 1
-- If DATEPART(QUARTER, order_date) = 3 indicates o/p for the QUARTER 3



--SANYASI NAIDU LALAM--
--Top 5 Best Sellers by Revenue, 
--Total Quantity, and Total Orders 
SELECT TOP 5
       pizza_name,
       SUM(total_price) AS total_revenue,
       SUM(quantity) AS total_quantity_sold,
       COUNT(*) AS total_orders
FROM pizza_sales_portfolio
GROUP BY pizza_name
ORDER BY total_revenue DESC, total_quantity_sold DESC, 
total_orders DESC;



--Bottom 5 Best Sellers by Revenue, 
--Total Quantity, and Total Orders 
SELECT TOP 5
       pizza_name,
       SUM(total_price) AS total_revenue,
       SUM(quantity) AS total_quantity_sold,
       COUNT(*) AS total_orders   
FROM pizza_sales_portfolio
GROUP BY pizza_name
ORDER BY total_revenue ASC, total_quantity_sold ASC, 
total_orders ASC;



SELECT * FROM pizza_sales_portfolio