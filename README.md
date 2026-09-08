# Retail Data Warehouse & Analytics

---

Retail businesses collect data from multiple systems, but that data is scattered, 
messy, and hard to analyze directly. This project solves that by building a complete 
data warehouse from scratch — pulling raw data from CRM and ERP sources, cleaning 
and transforming it layer by layer, and finally delivering business-ready analytics 
and reports through SQL Server.

Built using SQL Server and SSMS with real-world style retail data containing 
60,000+ sales transactions across 6 source files from CRM and ERP systems.

---

## Tech Stack

- Tool: SQL Server Management Studio (SSMS)
- Language: T-SQL
- Architecture: Medallion Architecture (Bronze → Silver → Gold)
- Data Modelling: Star Schema (Fact + Dimension views)
- Version Control: GitHub

---

## Dataset Overview

Two source systems with **6 total datasets:**

**CRM System — 3 files**
Contains customer master information (~18,493 rows), product master information 
(~397 rows), and sales transactions (~60,398 rows).

**ERP System — 3 files**
Contains customer birthdate and gender (~18,483 rows), customer country and 
location (~18,484 rows), and product categories and subcategories (~36 rows).

---

## Data Pipeline

Raw CSV Files → Bronze Layer → Silver Layer → Gold Layer → Analytics & Reports

- **Bronze** → Raw data loaded directly from CSV files without any changes. 
Preserves the original source structure completely.
- **Silver** → Data is cleaned, standardized and transformed here. Handles 
duplicates, nulls, date conversions and value standardization.
- **Gold** → Business-ready dimension and fact views built here using Star 
Schema for reporting and analysis.

---

## Analytics Performed

**Exploratory Data Analysis (EDA):**
- Database and schema exploration
- Dimensions exploration
- Date range exploration
- Measures and KPI exploration
- Magnitude analysis
- Ranking analysis

**Advanced Analytics:**
- Change over time analysis
- Cumulative and running total analysis
- Performance and year-over-year analysis
- Part-to-whole analysis
- Data segmentation

**Business Reports:**
- Customer Report → Age groups, customer segments, recency, average order 
value, average monthly spend
- Product Report → Product segments, revenue, average order revenue, 
average monthly revenue

---

## How to Run

1. Run `scripts/init_database.sql` → creates the database and schemas
2. Run `scripts/bronze/ddl_bronze.sql` → creates Bronze layer tables
3. Run `scripts/bronze/proc_load_bronze.sql` → loads raw data (update file 
paths to match your local machine)
4. Run `scripts/silver/ddl_silver.sql` → creates Silver layer tables
5. Run `scripts/silver/proc_load_silver.sql` → loads cleaned and transformed data
6. Run `scripts/gold/ddl_gold.sql` → creates Gold layer views
7. Run `tests/quality_checks_silver.sql` → validates Silver layer data
8. Run `tests/quality_checks_gold.sql` → validates Gold layer data
9. Explore `data_analytics/` → run any analysis from EDA to business reports

---

## Skills Demonstrated

- Data warehouse design using Medallion Architecture (Bronze, Silver, Gold)
- ETL pipeline development using stored procedures
- Data cleaning and standardization in T-SQL
- Data modelling with Fact and Dimension views (Star Schema)
- Window functions — ROW_NUMBER, LAG, LEAD, SUM OVER, AVG OVER
- CTEs and subqueries for complex business logic
- Customer and product segmentation
- Year-over-year and cumulative performance analysis
- Business report creation using SQL views

---

## Author

**Surajit Aich**
[GitHub](https://github.com/surajit-aich)

---

## Disclaimer

The datasets used in this project are sourced from the **Data With Baraa** 
YouTube channel and are used purely for learning and portfolio purposes.
