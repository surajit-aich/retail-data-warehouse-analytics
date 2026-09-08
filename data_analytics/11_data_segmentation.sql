/*
====================================================================================================================
Data Segmentation
====================================================================================================================
Purpose:
    - Segment products into different cost ranges and analyze the number of products in each range.
    - Segment customers based on their spending behavior and relationship lifespan.
    - Analyze the distribution of products and customers across their respective segments.

SQL Functions Used:
    - CASE
    - COUNT()
    - SUM()
    - MIN()
    - MAX()
    - DATEDIFF()
====================================================================================================================
*/



/* -----------------------------------------------------------------------------------------------------------------
1) Product Cost Segmentation
   - Segment products into different cost ranges.
   - Count the number of products within each cost segment.
-------------------------------------------------------------------------------------------------------------------*/

WITH product_segment AS (
Select 
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost < 100 THEN 'BELOW 100'
		WHEN cost BETWEEN  100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'Above 1000'
	END AS cost_range
FROM gold.dim_product
)
Select 
	cost_range,
	COUNT(product_key) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC;


/* -----------------------------------------------------------------------------------------------------------------
2) Customer Segmentation
   - Segment customers based on their spending behavior and relationship lifespan.
   - Identify VIP, Regular, and New customers.
   - Count the total number of customers in each segment.
-------------------------------------------------------------------------------------------------------------------*/

WITH customer_spending AS (
Select 
	GC.customer_id,
	SUM(GS.sales_amount) AS Total_spending,
	MIN(GS.order_date) AS first_order,
	MAX(GS.order_date) AS last_order,
	DATEDIFF(Month, MIN(GS.order_date), MAX(GS.order_date)) AS lifespan
from gold.fact_sales AS GS
LEFT JOIN gold.dim_customers AS GC
	ON GS.customer_key = GC.customer_key
GROUP BY GC.customer_id
)
Select 
	customer_segment,
	COUNT(customer_id) AS Total_customers
FROM(
Select 
	customer_id,
	Total_spending,
	lifespan,
	CASE 
		WHEN lifespan >= 12 AND Total_spending > 5000 THEN 'VIP'
		WHEN lifespan >= 12 AND Total_spending <=5000 THEN 'Regular'
		ELSE 'NEW'
	END AS customer_segment
FROM customer_spending) t
GROUP BY customer_segment
ORDER BY Total_customers DESC;
