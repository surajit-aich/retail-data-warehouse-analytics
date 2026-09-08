/*
====================================================================================================================
Database Initialization
====================================================================================================================
Purpose:
    - Create the Retail_DataWarehouse database.
    - Recreate the database when it already exists.
    - Create the Bronze, Silver, and Gold schemas for the data warehouse architecture.

Warehouse Architecture:
    - Bronze → Raw data
    - Silver → Cleaned and transformed data
    - Gold   → Business-ready data

SQL Statements Used:
    - DB_ID()
    - ALTER DATABASE
    - DROP DATABASE
    - CREATE DATABASE
    - USE
    - CREATE SCHEMA
====================================================================================================================
*/


-- =============================================================================
-- Create Database: Retail_DataWarehouse
-- =============================================================================

USE master;
GO

IF DB_ID ('Retail_DataWarehouse') IS NOT NULL
BEGIN	
	ALTER DATABASE Retail_DataWarehouse
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

	DROP DATABASE Retail_DataWarehouse;
END;
GO

CREATE DATABASE Retail_DataWarehouse;
GO

USE Retail_DataWarehouse;
GO

-- =============================================================================
-- Create Schemas: Bronze, Silver, Gold
-- =============================================================================

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
