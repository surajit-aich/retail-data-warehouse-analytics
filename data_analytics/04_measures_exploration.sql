/*
====================================================================================================================
Measures Exploration (Key Metrics)
====================================================================================================================
Purpose:
    - Calculate key business metrics to provide an overall view of sales performance.
    - Measure total sales, quantity, orders, products, and customers.
    - Generate a consolidated report of the key business metrics.

SQL Functions Used:
    - SUM()
    - AVG()
    - COUNT()
====================================================================================================================
*/
											

/* -----------------------------------------------------------------------------------------------------------------
1) Calculate Total Sales
-------------------------------------------------------------------------------------------------------------------*/

Select 
	SUM(sales_amount) AS  total_sales
From gold.fact_sales;

/* -----------------------------------------------------------------------------------------------------------------
2) Calculate Total Quantity Sold
-------------------------------------------------------------------------------------------------------------------*/

Select 
	SUM(quantity) AS total_quantity
FROM gold.fact_sales;

/* -----------------------------------------------------------------------------------------------------------------
3) Calculate Average Selling Price
-------------------------------------------------------------------------------------------------------------------*/

Select 
	AVG(price) AS average_selling_price
FROM gold.fact_sales;

/* -----------------------------------------------------------------------------------------------------------------
4) Calculate Total Number of Orders
   - DISTINCT is used because one order can contain multiple products/order lines.
-------------------------------------------------------------------------------------------------------------------*/

SELECT  
	COUNT(DISTINCT order_number) AS total_orders 
from gold.fact_sales;

/* -----------------------------------------------------------------------------------------------------------------
5) Calculate Total Number of Products
-------------------------------------------------------------------------------------------------------------------*/

SELECT  
	COUNT(DISTINCT product_key) AS total_products 
from gold.dim_product;

/* -----------------------------------------------------------------------------------------------------------------
6) Calculate Total Number of Customers
-------------------------------------------------------------------------------------------------------------------*/

SELECT  
	COUNT(DISTINCT customer_key) AS total_customers 
from gold.dim_customers;

/* -----------------------------------------------------------------------------------------------------------------
7) Calculate Total Number of Customers Who Have Placed an Order
-------------------------------------------------------------------------------------------------------------------*/

Select COUNT(DISTINCT Customer_key) AS total_ordered_customers 
FROM gold.fact_sales;

/* -----------------------------------------------------------------------------------------------------------------
8) Generate Consolidated KPI Report
   - Combine the key business metrics into a single result set for quick review.
-------------------------------------------------------------------------------------------------------------------*/

Select
	'Total Sales' AS measure_name,
	SUM(sales_amount) AS measure_value
From gold.fact_sales
UNION ALL 
Select 
	'Total Quantity' AS measure_name,
	SUM(quantity) AS measure_value
FROM gold.fact_sales
UNION ALL
Select 
	'Average Selling price' AS measure_name,
	AVG(price) AS measure_value
FROM gold.fact_sales
UNION ALL
SELECT 
	'Total Orders' AS measure_name,
	COUNT(DISTINCT order_number) AS measure_value
from gold.fact_sales
UNION ALL
SELECT 
	'Total Products' AS measure_name,
	COUNT(DISTINCT product_key) AS measure_value
from gold.dim_product
UNION ALL
SELECT 
	'Total Customers' AS measure_name,
	COUNT(DISTINCT customer_key) AS measure_value
from gold.dim_customers
UNION ALL
Select 
	'Total Ordered Customers' AS measure_name,
	COUNT(DISTINCT Customer_key) AS measure_value 
FROM gold.fact_sales;
