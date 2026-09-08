/*
====================================================================================================================
Change Over Time Analysis
====================================================================================================================
Purpose:
    - Analyze sales performance and customer activity over time.
    - Track changes in revenue, customers, and quantity sold at the monthly level.

SQL Functions Used:
    - YEAR()
    - MONTH()
    - SUM()
    - COUNT()
====================================================================================================================
*/


/* -----------------------------------------------------------------------------------------------------------------
1) Monthly Sales Analysis Using Date Functions
   - Analyze revenue, customers, and quantity sold by year and month.
-------------------------------------------------------------------------------------------------------------------*/

Select
	YEAR(order_date) AS Year,
	MONTH(order_date) AS Month,
	SUM(sales_amount) AS  total_revenue,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(Quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date),
	YEAR(order_date)
ORDER By YEAR(order_date), MONTH(order_date);


/* -----------------------------------------------------------------------------------------------------------------
2) Monthly Sales Analysis Using FORMAT()
   - Format the order date as Year-Month for a more readable presentation.
   - Analyze revenue, customers, and quantity sold by formatted month.
-------------------------------------------------------------------------------------------------------------------*/

Select
	FORMAT(order_date,'yyyy-MMM') AS order_month,
	SUM(sales_amount) AS  total_Revenue,
	COUNT(DISTINCT customer_key) AS total_customers,
	SUM(Quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date,'yyyy-MMM')
ORDER By FORMAT(order_date,'yyyy-MMM');
