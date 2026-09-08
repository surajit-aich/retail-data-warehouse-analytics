/*
====================================================================================================================
Silver Layer - Quality Checks
====================================================================================================================
Purpose:
    - Validate the quality, consistency, and integrity of data after transformation into the Silver layer.
    - Confirm that the cleaned and standardized data meets the expected technical and business rules.
    - Identify potential data-quality issues before the data is used in the Gold layer.

Data Quality Check Types:
    - Completeness & Uniqueness
    - Data Cleansing
    - Data Standardization
    - Data Validity
    - Date Validation
    - Referential Integrity
    - Business Rule Validation
    - Data Consistency

Tables Validated:
    - silver.crm_cust_info
    - silver.crm_prd_info
    - silver.crm_sales_details
    - silver.erp_cust_AZ12
    - silver.erp_loc_A101
    - silver.erp_px_cat_G1V2

Expected Result:
    - Quality-check queries are used to identify records that may violate defined data-quality,
      transformation, consistency, or business rules.
    - Any returned records should be reviewed and investigated based on the transformation logic
      and business requirements.
====================================================================================================================
*/


-- =================================================================================================================
-- Customer Information
-- =================================================================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Quality Check Type: Completeness & Uniqueness
-- Expectation: No Result

Select 
	cst_id,
	COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1
	OR cst_id IS NULL;

-- Check for Unwanted Spaces
-- Quality Check Type: Data Cleansing
-- Expectation: No Result

Select 
	cst_lastname
FROM silver.crm_cust_info
WHERE LEN(cst_lastname) != LEN(TRIM(cst_lastname));


-- Check Data Standardization and Consistency
-- Quality Check Type: Data Standardization & Consistency
-- Expectation: Only expected standardized values

Select DISTINCT 
	cst_marital_status, 
	cst_gndr
FROM silver.crm_cust_info;


-- =================================================================================================================
-- Product Information
-- =================================================================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Quality Check Type: Completeness & Uniqueness
-- Expectation: No Result

Select 
	prd_id,
	COUNT(*) 
from silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 
	OR prd_id is NULL;


-- Check for Unwanted Spaces
-- Quality Check Type: Data Cleansing
-- Expectation: No Result

Select 
	prd_nm
FROM silver.crm_prd_info
WHERE LEN(prd_nm) != LEN(TRIM(prd_nm))


-- Check for NULL or Negative Numbers
-- Quality Check Type: Data Validity
-- Expectation: No Result

Select prd_cost 
FROM silver.crm_prd_info
WHERE prd_cost < 0 
	OR prd_cost IS NULL

-- Check Data Standardization and Consistency
-- Quality Check Type: Data Standardization & Consistency
-- Expectation: Only expected standardized values

Select DISTINCT 
	prd_line
FROM silver.crm_prd_info;

-- Check for Invalid Date Order
-- Quality Check Type: Date Validation
-- Expectation: No Result

Select *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;


-- =================================================================================================================
-- Sales Details
-- =================================================================================================================

-- Check for Unwanted Spaces
-- Quality Check Type: Data Cleansing
-- Expectation: No Result

Select 
	sls_ord_num
FROM silver.crm_sales_details
WHERE LEN(sls_ord_num) != LEN(TRIM(sls_ord_num));

-- Check Product Referential Integrity
-- Quality Check Type: Referential Integrity
-- Expectation: No Result

Select * 
from silver.crm_sales_details
WHERE sls_prd_key NOT IN 
	(Select prd_key 
	FROM silver.crm_prd_info);

Select * 
from silver.crm_sales_details
WHERE sls_cust_id NOT IN 
(
	Select cst_id 
	FROM silver.crm_cust_info);

										
-- Check for NULL Dates
-- Quality Check Type: Completeness & Date Validation

SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt IS NULL
   OR sls_ship_dt IS NULL
   OR sls_due_dt IS NULL;

-- Check for Unrealistic Dates
-- Quality Check Type: Data Validity & Date Validation
-- Expectation: No Result

SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt < '1900-01-01'
   OR sls_order_dt > '2050-01-01'
   OR sls_ship_dt < '1900-01-01'
   OR sls_ship_dt > '2050-01-01'
   OR sls_due_dt < '1900-01-01'
   OR sls_due_dt > '2050-01-01';


-- Check for Invalid Date Order
-- Quality Check Type: Business Rule Validation
-- Expectation: No Result

Select * from silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt


-- Check Data Consistency: Sales = Quantity × Price
-- Quality Check Type: Business Rule Validation & Data Consistency
-- Business Assumptions:
-- 1. Sales should equal Quantity × Price.
-- 2. Sales, Quantity, and Price must contain valid positive values.
-- Expectation: No Result

Select 
	sls_quantity,
	sls_price,
	sls_sales
from silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price 
OR sls_sales IS NULL 
OR sls_sales <= 0 
OR sls_quantity IS NULL 
OR sls_quantity <= 0 
OR sls_price IS NULL 
OR sls_price <= 0 
ORDER BY sls_sales DESC;

-- =================================================================================================================
-- Customer Information from ERP
-- =================================================================================================================

											
-- Check for Out-of-Range Birthdates
-- Quality Check Type: Data Validity
Select 
	bdate
from silver.erp_cust_AZ12
WHERE bdate < '1924-01-01' 
	OR bdate > GETDATE();

-- Check Data Standardization and Consistency
-- Quality Check Type: Data Standardization & Consistency
-- Expectation: Only expected standardized values

Select Distinct 
	gen
FROM silver.erp_cust_AZ12;

-- =================================================================================================================
-- ERP Location
-- =================================================================================================================
											
-- Check Data Standardization and Consistency
-- Quality Check Type: Data Standardization & Consistency
-- Expectation: Only expected standardized values

Select DISTINCT
	cntry			
from silver.erp_loc_A101;

											
-- =================================================================================================================
-- ERP Product Category
-- =================================================================================================================

-- Check for Unwanted Spaces
-- Quality Check Type: Data Cleansing
-- Expectation: No Result

Select *
from silver.erp_px_cat_G1V2
WHERE LEN(cat) != LEN(TRIM(cat))
	OR LEN(subcat) != LEN(TRIM(subcat))
	OR LEN(maintenance) != LEN(TRIM(maintenance));

-- Check Data Standardization and Consistency
-- Quality Check Type: Data Standardization & Consistency
-- Expectation: Only expected standardized values

Select DISTINCT
	cat,
	subcat,
	maintenance
FROM silver.erp_px_cat_G1V2;


