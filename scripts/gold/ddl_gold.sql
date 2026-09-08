
/*
====================================================================================================================
Gold Layer - View Creation
====================================================================================================================
Purpose:
    - Create business-ready views for reporting and analytics.
    - Integrate cleaned and transformed data from the Silver layer.
    - Create customer and product dimension views.
    - Create the sales fact view.
    - Provide a simplified and business-friendly structure for downstream analysis.

Views Created:
    - gold.dim_customers
    - gold.dim_product
    - gold.fact_sales

Data Flow:
    - Silver → Gold

SQL Functions & Statements Used:
    - ROW_NUMBER()
    - CASE
    - CREATE VIEW
    - SELECT
    - LEFT JOIN
    - WHERE
====================================================================================================================
*/


-- =================================================================================================================
-- Customer Dimension
-- =================================================================================================================

CREATE OR ALTER VIEW gold.dim_customers AS 
Select 
	ROW_NUMBER () OVER(ORDER BY cst_id) AS customer_key,
	crm.cst_id AS customer_id,
	crm.cst_key AS customer_number,
	crm.cst_firstname AS first_name,
	crm.cst_lastname AS last_name,
	erp_loc.cntry AS country,
	crm.cst_marital_status AS marital_status,
	CASE
		WHEN crm.cst_gndr != 'UNKNOWN' THEN crm.cst_gndr
		WHEN erp_cust.gen IS NOT NULL AND erp_cust.gen != 'UNKNOWN'
			THEN erp_cust.gen
		ELSE 'UNKNOWN'
	END AS gender,
	erp_cust.bdate AS birthdate,
	crm.cst_create_date AS create_date
from silver.crm_cust_info AS crm
LEFT JOIN silver.erp_cust_AZ12 AS erp_cust
ON crm.cst_key = erp_cust.cid
LEFT JOIN silver.erp_loc_A101 AS erp_loc
ON crm.cst_key = erp_loc.cid;
GO

-- =================================================================================================================
-- Product Dimension
-- =================================================================================================================

CREATE OR ALTER VIEW gold.dim_product AS 
Select 
	ROW_NUMBER () OVER(ORDER BY crm_p.prd_start_dt, crm_p.prd_key) AS product_key,
	crm_p.prd_id AS product_id,
	crm_p.prd_key AS product_number,
	crm_p.prd_nm AS product_name,
	crm_p.cat_id AS category_id,
	erp_p.cat AS category,
	erp_p.subcat AS subcategory,
	erp_p.maintenance,
	crm_p.prd_cost AS cost,
	crm_p.prd_line AS product_line,
	crm_p.prd_start_dt AS start_date
from silver.crm_prd_info AS crm_p
LEFT JOIN silver.erp_px_cat_G1V2 AS erp_p
ON crm_p.cat_id = erp_p.id
WHERE crm_p.prd_end_dt IS NULL; -- Filter Out all historical Data
GO

-- =================================================================================================================
-- Sales Fact
-- =================================================================================================================

CREATE OR ALTER VIEW gold.fact_sales AS
Select 
	crm_s.sls_ord_num AS order_number,
	cus.customer_key,
	prd.product_key,
	crm_s.sls_order_dt AS order_date,
	crm_s.sls_ship_dt AS shipping_date,
	crm_s.sls_due_dt AS due_date,
	crm_s.sls_sales AS sales_amount,
	crm_s.sls_quantity AS quantity,
	crm_s.sls_price AS price
from silver.crm_sales_details AS crm_s
LEFT JOIN gold.dim_customers AS cus
	ON crm_s.sls_cust_id = cus.customer_id
LEFT JOIN gold.dim_product AS prd
	ON crm_s.sls_prd_key = prd.product_number;
GO





 













