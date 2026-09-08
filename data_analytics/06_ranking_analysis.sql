/*
====================================================================================================================
Ranking Analysis
====================================================================================================================
Purpose:
    - Identify top and bottom performers based on revenue.
    - Rank customers and products to understand revenue contribution.
    - Highlight high-performing and underperforming products.

SQL Functions Used:
    - SUM()
    - ROW_NUMBER()
====================================================================================================================
*/



/* -----------------------------------------------------------------------------------------------------------------
1) Identify Top 5 Products by Revenue
   - Rank products based on the total revenue they have generated.
-------------------------------------------------------------------------------------------------------------------*/

SELECT * 
FROM(
Select 
	GP.product_id,
	GP.product_number,
	GP.product_name,
	SUM(GS.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER(ORDER BY SUM(GS.sales_amount) DESC) AS rank_products
FROM gold.fact_sales AS GS
LEFT JOIN gold.dim_product AS GP
	ON GS.product_key = GP.product_key
GROUP BY GP.product_id,
	GP.product_number,
	GP.product_name) t
WHERE rank_products < 6;

/* -----------------------------------------------------------------------------------------------------------------
2) Identify Bottom 5 Products by Revenue
   - Identify products with the lowest total revenue.
-------------------------------------------------------------------------------------------------------------------*/

Select TOP 5 
	GP.product_id,
	GP.product_number,
	GP.product_name,
	SUM(GS.sales_amount) AS total_revenue
FROM gold.fact_sales AS GS
LEFT JOIN gold.dim_product AS GP
	ON GS.product_key = GP.product_key
GROUP BY GP.product_id,
	GP.product_number,
	GP.product_name
ORDER BY total_revenue ASC;

/* -----------------------------------------------------------------------------------------------------------------
3) Identify Top 10 Customers by Revenue
   - Rank customers based on the total revenue they have generated.
-------------------------------------------------------------------------------------------------------------------*/

SELECT TOP 10
    GC.customer_key,
    GC.first_name,
    GC.last_name,
    SUM(GS.sales_amount) AS total_revenue
FROM gold.fact_sales AS GS
LEFT JOIN gold.dim_customers AS GC
    ON GS.customer_key = GC.customer_key
GROUP BY
    GC.customer_key,
    GC.first_name,
    GC.last_name
ORDER BY total_revenue DESC;
