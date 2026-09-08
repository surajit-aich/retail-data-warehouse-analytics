
/*
====================================================================================================================
Silver Layer - Table Creation
====================================================================================================================
Purpose:
    - Create the Silver layer tables for storing cleaned and transformed data.
    - Prepare the table structure for data loaded from the Bronze layer.
    - Convert selected data types to support Silver layer transformations.
    - Add a data warehouse creation timestamp to track when records are loaded.

Tables Created:
    - silver.crm_cust_info
    - silver.crm_prd_info
    - silver.crm_sales_details
    - silver.erp_cust_AZ12
    - silver.erp_loc_A101
    - silver.erp_px_cat_G1V2

SQL Functions & Statements Used:
    - OBJECT_ID()
    - DROP TABLE
    - CREATE TABLE
    - GETDATE()
====================================================================================================================
*/


-- =============================================================================
-- Create Table: silver.crm_cust_info
-- =============================================================================

IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;

CREATE TABLE silver.crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_marital_status VARCHAR(50),
	cst_gndr VARCHAR(50),
	cst_create_date DATE,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO

-- =============================================================================
-- Create Table: silver.crm_prd_info
-- =============================================================================

IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;

CREATE TABLE silver.crm_prd_info (
	prd_id INT,
	prd_key VARCHAR(50),
	cat_id VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(50),
	prd_start_dt DATE,
	prd_end_dt DATE,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO


-- =============================================================================
-- Create Table: silver.crm_sales_details
-- =============================================================================

IF OBJECT_ID ('silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details;

CREATE TABLE silver.crm_sales_details (
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt DATE,
	sls_ship_dt DATE,
	sls_due_dt DATE,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT,
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO


-- =============================================================================
-- Create Table: silver.erp_cust_AZ12
-- =============================================================================

IF OBJECT_ID ('silver.erp_cust_AZ12', 'U') IS NOT NULL
	DROP TABLE silver.erp_cust_AZ12;

CREATE TABLE silver.erp_cust_AZ12 (
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO


-- =============================================================================
-- Create Table: silver.erp_loc_A101
-- =============================================================================

IF OBJECT_ID ('silver.erp_loc_A101', 'U') IS NOT NULL
	DROP TABLE silver.erp_loc_A101;

CREATE TABLE silver.erp_loc_A101 (
	cid VARCHAR(50),
	cntry VARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);
GO


-- =============================================================================
-- Create Table: silver.erp_px_cat_G1V2
-- =============================================================================

IF OBJECT_ID ('silver.erp_px_cat_G1V2', 'U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_G1V2;

CREATE TABLE silver.erp_px_cat_G1V2 (
	id VARCHAR(50),
	cat VARCHAR(50),
	subcat VARCHAR(50),
	maintenance VARCHAR(50),
	dwh_create_date DATETIME DEFAULT GETDATE()
);


