/*
====================================================================================================================
Product Report
====================================================================================================================
Purpose:
    - Consolidate key product information, metrics, and performance indicators into a single report.
    - Analyze product sales, customer reach, and purchasing activity.
    - Segment products based on their revenue performance.
    - Provide key performance indicators to support product analysis and decision-making.

Key Insights:
    - Product category and subcategory
    - Product cost and product line
    - Product segment
    - Recency
    - Total orders, revenue, and quantity
    - Total customers
    - Product lifespan
    - Average selling price
    - Average order revenue
    - Average monthly revenue

SQL Functions Used:
    - COUNT()
    - SUM()
    - MAX()
    - MIN()
    - DATEDIFF()
    - AVG()
    - CAST()
    - NULLIF()
    - ROUND()
    - CASE
====================================================================================================================
*/


-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================

IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS

/* -----------------------------------------------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
-------------------------------------------------------------------------------------------------------------------*/

WITH product_sales_base AS (
Select 
	GP.product_id,
	GP.category,
	GP.subcategory,
	GP.product_name,
	GP.cost,
	GP.product_line,
	GS.order_number,
	GS.sales_amount,
	GS.quantity,
	GS.customer_key,
	GS.order_date
FROM gold.fact_sales AS GS
LEFT JOIN gold.dim_product AS GP
	ON GS.product_key = GP.product_key
)

/* -----------------------------------------------------------------------------------------------------------------
2) Product Aggregation: Summarizes key metrics at the product level
-------------------------------------------------------------------------------------------------------------------*/

, product_aggregation AS (
Select 
	product_id,
	category,
	subcategory,
	product_name,
	cost,
	product_line,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(Sales_amount) AS total_revenue,
	SUM(Quantity) AS total_quantity,
	COUNT(DISTINCT customer_key) AS total_customers,
	MAX(order_date) AS last_order,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS product_lifespan_months,
	ROUND(AVG(CAST(sales_amount AS float) / NULLIF(quantity,0)),2) AS average_selling_price
FROM product_sales_base
GROUP BY product_id,
	category,
	subcategory,
	product_name,
	cost,
	product_line
	
)

/* -----------------------------------------------------------------------------------------------------------------
3) Final Product Report: Combines product metrics, segments, and key performance indicators
   - Calculate product recency.
   - Segment products based on revenue performance.
   - Calculate average order revenue and average monthly revenue.
-------------------------------------------------------------------------------------------------------------------*/

Select 
	product_id,
	category,
	subcategory,
	product_name,
	cost,
	product_line,
	last_order,
	DATEDIFF(MONTH,last_order, GETDATE()) AS recency_in_months,
	CASE
		WHEN total_revenue > 50000 THEN 'High Performer'
		WHEN total_revenue >=10000 THEN 'Mid range'
		ELSE 'Low Performer'
	END AS product_segment,
	total_orders,
	total_revenue,
	total_quantity,
	total_customers,
	product_lifespan_months,
	average_selling_price,
	-- Average Order Revenue (AOR)
	CASE
		WHEN total_orders = 0 THEN 0
		ELSE total_revenue / total_orders
	END AS Average_order_revenue,
	-- Average Monthly Revenue 
	CASE
		WHEN product_lifespan_months = 0 THEN total_revenue
		ELSE total_revenue / product_lifespan_months
	END AS average_monthly_revenue
from product_aggregation;
