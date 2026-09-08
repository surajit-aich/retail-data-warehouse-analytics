/*
====================================================================================================================
Database Exploration
====================================================================================================================
Purpose:
    - Explore the structure of the Gold layer before performing analytical queries.
    - Identify available tables, views, and their columns.
    - Understand the schema and data structure used for analysis.

Key Tables:
    - gold.dim_customers
    - gold.dim_product
    - gold.fact_sales
====================================================================================================================
*/



/* -----------------------------------------------------------------------------------------------------------------
1) Explore Database Objects
   - Identify all tables and views available in the database.
-------------------------------------------------------------------------------------------------------------------*/

SELECT *
from INFORMATION_SCHEMA.TABLES;


/* -----------------------------------------------------------------------------------------------------------------
2) Explore Table Columns
   - Review the columns, data types, and other metadata for the customer dimension.
-------------------------------------------------------------------------------------------------------------------*/

Select * 
from INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold' 
	AND	TABLE_NAME = 'dim_customers';
