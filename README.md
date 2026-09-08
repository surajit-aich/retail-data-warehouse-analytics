Retail Data Warehouse & Analytics

Retail businesses collect data from multiple systems, but that data is scattered, messy, and hard to use directly. This project solves that by building a complete SQL data warehouse from scratch — pulling raw data from CRM and ERP sources, cleaning and transforming it step by step, and finally delivering business-ready analytics and reports through SQL Server.

Built using SQL Server and SSMS with real-world style retail data containing 60,000+ sales transactions across 3 source tables from CRM and 3 from ERP.

Tech Stack
Tool: SQL Server Management Studio (SSMS)
Language: T-SQL
Architecture: Medallion Architecture (Bronze → Silver → Gold)
Data Modelling: Star Schema (Fact + Dimension views)
Version Control: GitHub
Dataset Overview

Two source systems with 6 total datasets:

CRM System — 3 tables:

File	Description	Rows
cust_info.csv	Customer master information	~18,493
prd_info.csv	Product master information	~397
sales_details.csv	Sales transactions	~60,398

ERP System — 3 tables:

File	Description	Rows
CUST_AZ12.csv	Customer birthdate and gender	~18,483
LOC_A101.csv	Customer country and location	~18,484
PX_CAT_G1V2.csv	Product categories and subcategories	~36
Data Pipeline
CRM Sources ──┐
              ├──► Bronze Layer ──► Silver Layer ──► Gold Layer ──► Analytics & Reports
ERP Sources ──┘
  (Raw Data)      (Cleaned)        (Transformed)    (Business-Ready)
Architecture
Bronze Layer → Raw data loaded directly from CSV files without any changes. Preserves the original source structure completely.
Silver Layer → Data is cleaned, standardized and transformed here. Handles duplicates, nulls, date conversions and value standardization.
Gold Layer → Business-ready dimension and fact views created here using Star Schema for reporting and analysis.
Analytics Performed

Exploratory Data Analysis (EDA):

Database and schema exploration
Dimensions exploration
Date range exploration
Measures and KPI exploration
Magnitude analysis
Ranking analysis

Advanced Analytics:

Change over time analysis
Cumulative and running total analysis
Performance and year-over-year analysis
Part-to-whole analysis
Data segmentation

Business Reports:

Customer Report → Age groups, customer segments, recency, average order value, average monthly spend
Product Report → Product segments, revenue, average order revenue, average monthly revenue
How to Run
Run scripts/init_database.sql → creates the database and schemas
Run scripts/bronze/ddl_bronze.sql → creates Bronze layer tables
Run scripts/bronze/proc_load_bronze.sql → loads raw data (update file paths to match your local machine)
Run scripts/silver/ddl_silver.sql → creates Silver layer tables
Run scripts/silver/proc_load_silver.sql → loads cleaned and transformed data
Run scripts/gold/ddl_gold.sql → creates Gold layer views
Run tests/quality_checks_silver.sql → validates Silver layer data
Run tests/quality_checks_gold.sql → validates Gold layer data
Explore data_analytics/ → run any analysis from EDA to business reports
Skills Demonstrated
Data warehouse design using Medallion Architecture
ETL pipeline development using stored procedures
Data cleaning and standardization in T-SQL
Data modelling with Fact and Dimension views (Star Schema)
Window functions — ROW_NUMBER, LAG, LEAD, SUM OVER, AVG OVER
CTEs and subqueries for complex business logic
Customer and product segmentation
Year-over-year and cumulative performance analysis
Business report creation using SQL views
Author

Surajit Aich
GitHub
