/*
====================================================================================================================
Customer Report
====================================================================================================================
Purpose:
    - Consolidate key customer information, metrics, and behavioral insights into a single report.
    - Analyze customer demographics, purchasing behavior, and engagement.
    - Segment customers based on age, spending behavior, and relationship lifespan.
    - Provide key performance indicators to support customer analysis and decision-making.

Key Insights:
    - Customer age and age group
    - Customer segment
    - Recency
    - Total orders, revenue, and quantity
    - Unique products purchased
    - Customer lifespan
    - Average order value
    - Average monthly spend

SQL Functions Used:
    - CONCAT()
    - DATEDIFF()
    - COUNT()
    - SUM()
    - MIN()
    - MAX()
    - CASE
====================================================================================================================
*/


-- =============================================================================
-- Create Report: gold.report_customers
-- =============================================================================


IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS 

/* -----------------------------------------------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
-------------------------------------------------------------------------------------------------------------------*/

WITH base_query AS (
Select 
	GS.order_number,
	GS.product_key,
	GS.order_date,
	GS.sales_amount,
	GS.quantity,
	GC.customer_id,
	CONCAT(GC.first_name, ' ',GC.last_name) AS customer_name,
	DATEDIFF(Year, GC.birthdate, GETDATE()) AS Age
FROM gold.fact_sales AS GS
LEFT JOIN gold.dim_customers AS GC
	ON GS.customer_key = GC.customer_key
WHERE GS.order_date IS NOT NULL
)

/* -----------------------------------------------------------------------------------------------------------------
2) Customer Aggregation: Summarizes key metrics at the customer level
-------------------------------------------------------------------------------------------------------------------*/

, customer_aggregation AS (
Select 
	customer_id,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS Total_orders,
	SUM(sales_amount) AS Total_revenue,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS unique_products_purchased,
	MAX(order_date) AS last_order,
	DATEDIFF(Month, MIN(order_date), MAX(order_date)) AS customer_lifespan_months
FROM base_query
GROUP BY customer_id,
	customer_name,
	age
)

/* -----------------------------------------------------------------------------------------------------------------
3) Final Customer Report: Adds customer segments and calculates key performance indicators
   - Categorize customers into age groups.
   - Segment customers based on spending and lifespan.
   - Calculate recency, average order value, and average monthly spend.
-------------------------------------------------------------------------------------------------------------------*/

Select 
	customer_id,
	customer_name,
	age,
	CASE
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE '50 And above'
	END AS age_group,
	CASE 
		WHEN customer_lifespan_months >= 12 AND Total_revenue > 5000 THEN 'VIP'
		WHEN customer_lifespan_months >= 12 AND Total_revenue <=5000 THEN 'Regular'
		ELSE 'NEW'
	END AS customer_segment,
	last_order,
	DATEDIFF(Month, last_order, GETDATE()) AS recency,
	Total_orders,
	Total_revenue,
	total_quantity,
	unique_products_purchased,
	customer_lifespan_months,
	-- Average Order value
	CASE
		WHEN Total_orders = 0 THEN 0
		ELSE Total_revenue / Total_orders
	END AS Average_order_value,
	-- Average Monthly Spending 
	CASE
		WHEN customer_lifespan_months = 0 THEN Total_revenue
		ELSE Total_revenue / customer_lifespan_months
	END AS average_monthly_spend
FROM customer_aggregation;
