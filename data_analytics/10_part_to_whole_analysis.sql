/*
====================================================================================================================
Part-to-Whole Analysis
====================================================================================================================
Purpose:
    - Analyze each product category's contribution to overall sales.
    - Calculate total revenue for each category.
    - Calculate each category's percentage contribution to overall sales.
    - Identify categories with the highest revenue contribution.

Metrics Analyzed:
    - Category revenue
    - Overall sales
    - Percentage of total sales

SQL Functions Used:
    - SUM()
    - CAST()
    - ROUND()
    - CONCAT()
====================================================================================================================
*/

WITH category_sales AS (
Select 
	GP.category,
	SUM(GS.sales_amount) AS Total_revenue
FROM gold.fact_sales AS GS
LEFT JOIN gold.dim_product AS GP
	ON GS.product_key = GP.product_key
GROUP BY GP.category
)

Select 
	category,
	total_revenue,
	SUM(total_revenue) OVER() AS overall_sales,
	CONCAT(ROUND((CAST (total_revenue AS FLOAT) 
					/ SUM(total_revenue) OVER()) * 100 ,2),'%') AS percentage_of_total
FROm category_sales
ORDER BY Total_revenue DESC;
