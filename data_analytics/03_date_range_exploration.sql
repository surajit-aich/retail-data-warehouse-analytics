/*
====================================================================================================================
Date Range Exploration
====================================================================================================================
Purpose:
    - Understand the time period covered by the sales data.
    - Identify the oldest and youngest customers based on birthdate.
====================================================================================================================
*/


/* -----------------------------------------------------------------------------------------------------------------
1) Explore Sales Date Range
   - Identify the first and last order dates.
   - Calculate the available sales period in years and months.
-------------------------------------------------------------------------------------------------------------------*/

Select 
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(year,MIN(order_date),MAX(order_date)) AS order_range_years,
	DATEDIFF(month,MIN(order_date),MAX(order_date)) AS order_range_months
from gold.fact_sales;

/* -----------------------------------------------------------------------------------------------------------------
2) Explore Customer Birthdate Range
   - Identify the oldest and youngest customers.
   - Calculate their approximate ages.
-------------------------------------------------------------------------------------------------------------------*/

Select 
	MIN(birthdate) AS oldest_customer_birthdate,
	DATEDIFF(year,MIN(birthdate),GETDATE()) AS oldest_customer_age,
	MAX(birthdate) AS youngest_customer_birthdate,
	DATEDIFF(year,MAX(birthdate),GETDATE()) AS youngest_customer_age
from gold.dim_customers;
