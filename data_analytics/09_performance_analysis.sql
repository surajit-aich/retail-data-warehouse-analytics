/*
====================================================================================================================
Performance Analysis
====================================================================================================================
Purpose:
    - Analyze yearly product sales performance.
    - Compare each product's yearly sales against its average yearly sales.
    - Compare each product's sales with the previous year's sales.
    - Identify yearly sales trends and performance changes.

Metrics Analyzed:
    - Current year sales
    - Average yearly sales
    - Difference from average sales
    - Previous year sales
    - Year-over-year sales difference
    - Year-over-year sales change

SQL Functions Used:
    - YEAR()
    - SUM()
    - AVG()
    - LAG()
====================================================================================================================
*/											

WITH yearly_product_sales AS (
Select 
	YEAR(GS.order_date) AS Year,
	GP.product_id,
	GP.product_name,
	SUM(GS.sales_amount) AS current_year_sales
FROM gold.fact_sales AS GS
LEFT JOIN gold.dim_product AS GP
	ON GS.product_key = GP.product_key
WHERE order_date IS NOT NULL
GROUP BY YEAR(GS.order_date),
	GP.product_id,
	GP.product_name
)

Select 
	Year,
	product_id,
	product_name,
	current_year_sales,
	AVG(current_year_sales) OVER(
					PARTITION BY product_name) AS avg_yearly_sales,
	current_year_sales - AVG(current_year_sales) OVER(
					PARTITION BY product_name) AS sales_vs_average,
	CASE
		WHEN current_year_sales - AVG(current_year_sales) OVER(
					PARTITION BY product_name) > 0 THEN 'Above Average'
		WHEN current_year_sales - AVG(current_year_sales) OVER(
					PARTITION BY product_name) < 0 THEN 'Below Average'
		ELSE 'Avg'
	END AS sales_performance,
	-- Year over year Analysis 
	LAG(current_year_sales) OVER(
							PARTITION BY product_name 
							ORDER BY Year ) AS previous_year_sales,
	current_year_sales - LAG(current_year_sales) OVER(
							PARTITION BY product_name 
							ORDER BY Year ) AS yoy_sales_difference,
	CASE
		WHEN current_year_sales - LAG(current_year_sales) OVER(
							PARTITION BY product_name 
							ORDER BY Year ) > 0 THEN 'Increase'
		WHEN current_year_sales - LAG(current_year_sales) OVER(
							PARTITION BY product_name 
							ORDER BY Year ) < 0  THEN 'Decrease'
		ELSE 'No Changes'
	END AS yoy_sales_change
FROM yearly_product_sales
ORDER BY product_name, Year;
