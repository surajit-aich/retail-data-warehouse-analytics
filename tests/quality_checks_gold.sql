
/*
====================================================================================================================
Gold Layer - Quality Checks
====================================================================================================================
Purpose:
    - Validate the quality, consistency, and integrity of the Gold layer.
    - Confirm that dimension keys are unique and properly populated.
    - Verify that fact records are correctly connected to their dimensions.
    - Confirm that Gold measures follow the expected business rules.

Tables Validated:
    - gold.dim_customers
    - gold.dim_product
    - gold.fact_sales

Quality Check Types:
    - Completeness & Uniqueness
    - Referential Integrity
    - Business Rule Validation
    - Data Consistency

Expected Result:
    - Quality-check queries are used to identify records that may violate defined
      data-quality, integrity, or business rules.
    - Any returned records should be reviewed and investigated.
====================================================================================================================
*/



-- =================================================================================================================
-- Customer Dimension
-- =================================================================================================================

-- Check for NULLs or Duplicates in Customer Surrogate Key
-- Quality Check Type: Completeness & Uniqueness
-- Expectation: No Result

SELECT
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING customer_key IS NULL
    OR COUNT(*) > 1;

-- Check for NULLs or Duplicates in Customer ID
-- Quality Check Type: Completeness & Uniqueness
-- Expectation: No Result

SELECT
    customer_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_id
HAVING customer_id IS NULL
    OR COUNT(*) > 1;


-- =================================================================================================================
-- Product Dimension
-- =================================================================================================================

-- Check for NULLs or Duplicates in Product Surrogate Key
-- Quality Check Type: Completeness & Uniqueness
-- Expectation: No Result

SELECT
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_product
GROUP BY product_key
HAVING product_key IS NULL
    OR COUNT(*) > 1;

-- Check for NULLs or Duplicates in Product ID
-- Quality Check Type: Completeness & Uniqueness
-- Expectation: No Result

SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM gold.dim_product
GROUP BY product_id
HAVING product_id IS NULL
    OR COUNT(*) > 1;


-- Check for NULLs or Duplicates in Product Number
-- Quality Check Type: Completeness & Uniqueness
-- Expectation: No Result

SELECT
    product_number,
    COUNT(*) AS duplicate_count
FROM gold.dim_product
GROUP BY product_number
HAVING product_number IS NULL
    OR COUNT(*) > 1;

-- =================================================================================================================
-- Fact Sales
-- =================================================================================================================

-- Check Customer Referential Integrity
-- Quality Check Type: Referential Integrity
-- Expectation: No Result

SELECT *
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c
    ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;

-- Check Product Referential Integrity
-- Quality Check Type: Referential Integrity
-- Expectation: No Result

SELECT *
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_product AS p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL;

-- Check Sales Data Consistency
-- Quality Check Type: Business Rule Validation & Data Consistency
-- Expectation: No Result

SELECT
    sales_amount,
    quantity,
    price
FROM gold.fact_sales
WHERE sales_amount IS NULL
   OR sales_amount <= 0
   OR quantity IS NULL
   OR quantity <= 0
   OR price IS NULL
   OR price <= 0
   OR sales_amount != quantity * price;








