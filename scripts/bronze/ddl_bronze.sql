/*
====================================================================================================================
Bronze Layer - Table Creation
====================================================================================================================
Purpose:
    - Create the Bronze layer tables for storing raw source data.
    - Preserve the source data structure and values without applying transformations.
    - Recreate Bronze tables when they already exist to support repeatable development and testing.

Tables Created:
    - bronze.crm_cust_info
    - bronze.crm_prd_info
    - bronze.crm_sales_details
    - bronze.erp_cust_AZ12
    - bronze.erp_loc_A101
    - bronze.erp_px_cat_G1V2

SQL Functions & Statements Used:
    - OBJECT_ID()
    - DROP TABLE
    - CREATE TABLE
====================================================================================================================
*/


-- =============================================================================
-- Create Table: bronze.crm_cust_info
-- =============================================================================

IF OBJECT_ID ('bronze.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info;

CREATE TABLE bronze.crm_cust_info (
	cst_id INT,
	cst_key VARCHAR(50),
	cst_firstname VARCHAR(50),
	cst_lastname VARCHAR(50),
	cst_marital_status VARCHAR(50),
	cst_gndr VARCHAR(50),
	cst_create_date DATE
);
GO

-- =============================================================================
-- Create Table: bronze.crm_prd_info
-- =============================================================================

IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;

CREATE TABLE bronze.crm_prd_info (
	prd_id INT,
	prd_key VARCHAR(50),
	prd_nm VARCHAR(50),
	prd_cost INT,
	prd_line VARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME
);
GO

-- =============================================================================
-- Create Table: bronze.crm_sales_details
-- =============================================================================

IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;

CREATE TABLE bronze.crm_sales_details (
	sls_ord_num VARCHAR(50),
	sls_prd_key VARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);
GO

-- =============================================================================
-- Create Table: bronze.erp_cust_AZ12
-- =============================================================================

IF OBJECT_ID ('bronze.erp_cust_AZ12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_AZ12;

CREATE TABLE bronze.erp_cust_AZ12 (
	cid VARCHAR(50),
	bdate DATE,
	gen VARCHAR(50)
);
GO

-- =============================================================================
-- Create Table: bronze.erp_loc_A101
-- =============================================================================

IF OBJECT_ID ('bronze.erp_loc_A101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_A101;

CREATE TABLE bronze.erp_loc_A101 (
	cid VARCHAR(50),
	cntry VARCHAR(50)
);
GO

-- =============================================================================
-- Create Table: bronze.erp_px_cat_G1V2
-- =============================================================================

IF OBJECT_ID ('bronze.erp_px_cat_G1V2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_G1V2;

CREATE TABLE bronze.erp_px_cat_G1V2 (
	id  VARCHAR(50),
	cat VARCHAR(50),
	subcat VARCHAR(50),
	maintenance VARCHAR(50)
);
GO





	