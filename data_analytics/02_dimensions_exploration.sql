/*
====================================================================================================================
Dimensions Exploration
====================================================================================================================
Purpose:
    - Explore key descriptive attributes available in the customer and product dimensions.
    - Understand the geographic coverage of customers.
    - Explore the product hierarchy from category to product level.
====================================================================================================================
*/


/* -----------------------------------------------------------------------------------------------------------------
1) Explore Customer Countries
   - Identify all countries represented in the customer dimension.
-------------------------------------------------------------------------------------------------------------------*/

Select Distinct 
	Country
FROM gold.dim_customers;

/* -----------------------------------------------------------------------------------------------------------------
2) Explore Product Hierarchy
   - Identify the available categories, subcategories, and products.
   - Sort the results to clearly show the product hierarchy.
-------------------------------------------------------------------------------------------------------------------*/

Select DISTINCT 
	category,
	subcategory,
	product_name
from gold.dim_product
ORDER BY
    category,
    subcategory,
    product_name;
