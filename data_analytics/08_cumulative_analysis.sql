/*
====================================================================================================================
Cumulative Analysis
====================================================================================================================
Purpose:
    - Analyze monthly sales performance and track cumulative business metrics within each year.
    - Calculate running totals for revenue, quantity, and orders.
    - Calculate the moving average of selling price over time.

Metrics Analyzed:
    - Monthly revenue and running total revenue
    - Monthly average selling price and moving average
    - Monthly quantity and running total quantity
    - Monthly orders and running total orders

SQL Functions Used:
    - DATETRUNC()
    - YEAR()
    - SUM()
    - AVG()
    - COUNT()
====================================================================================================================
*/

Select 
	order_date,
	Total_revenue,
	SUM(Total_revenue) OVER(PARTITION BY YEAR(order_date)
					ORDER BY order_date ) AS running_total_revenue,
	average_price,
	AVG(average_price) OVER(PARTITION BY YEAR(order_date)
					ORDER BY order_date ) AS moving_average,
	total_quantity,
	SUM(total_quantity) OVER(PARTITION BY YEAR(order_date)
					ORDER BY order_date ) AS running_total_quantity,
	total_orders,
	SUM(total_orders) OVER(PARTITION BY YEAR(order_date)
					ORDER BY order_date ) AS running_total_orders
FROM(
Select
	DATETRUNC(month, order_date) AS order_date,
	SUM(sales_amount) AS total_revenue,
	AVG(price) AS average_price,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t;
