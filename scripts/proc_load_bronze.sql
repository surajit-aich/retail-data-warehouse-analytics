
/*
====================================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
====================================================================================================================
Script Purpose:
    This stored procedure loads raw source data from external CSV files into the Bronze layer.
    It performs the following actions:
    - Truncates the Bronze tables before loading new data.
    - Uses BULK INSERT to load data from CSV files into the Bronze tables.
    - Tracks the total Bronze layer load duration.
    - Handles and reports errors that occur during the loading process.

Tables Loaded:
    - bronze.crm_cust_info
    - bronze.crm_prd_info
    - bronze.crm_sales_details
    - bronze.erp_cust_AZ12
    - bronze.erp_loc_A101
    - bronze.erp_px_cat_G1V2

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
====================================================================================================================
*/



CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	BEGIN TRY


		DECLARE @start_time DATETIME, @end_time DATETIME;

		PRINT '====================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================================================';

		SET @start_time = GETDATE();

		PRINT '--------------------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------------------------------';

		PRINT '>> Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT '>> Inserting Data Into : bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info 
		FROM 'D:\All About SQL\SQL Data Warehouse Project (YT - Data With Baraa)\Project Materials\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Data Into : bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\All About SQL\SQL Data Warehouse Project (YT - Data With Baraa)\Project Materials\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Data Into : bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\All About SQL\SQL Data Warehouse Project (YT - Data With Baraa)\Project Materials\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);


		PRINT '--------------------------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '--------------------------------------------------------------------';

		PRINT '>> Truncating Table : bronze.erp_cust_AZ12';
		TRUNCATE TABLE bronze.erp_cust_AZ12;

		PRINT '>> Inserting Data Into : bronze.erp_cust_AZ12';
		BULK INSERT bronze.erp_cust_AZ12
		FROM 'D:\All About SQL\SQL Data Warehouse Project (YT - Data With Baraa)\Project Materials\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table : bronze.erp_loc_A101';
		TRUNCATE TABLE bronze.erp_loc_A101;

		PRINT '>> Inserting Data Into : bronze.erp_loc_A101';
		BULK INSERT bronze.erp_loc_A101
		FROM 'D:\All About SQL\SQL Data Warehouse Project (YT - Data With Baraa)\Project Materials\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		PRINT '>> Truncating Table : bronze.erp_px_cat_G1V2';
		TRUNCATE TABLE bronze.erp_px_cat_G1V2;

		PRINT '>> Inserting Data Into : bronze.erp_px_cat_G1V2';
		BULK INSERT bronze.erp_px_cat_G1V2
		FROM 'D:\All About SQL\SQL Data Warehouse Project (YT - Data With Baraa)\Project Materials\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);

		SET @end_time = GETDATE();

		PRINT '====================================================================';
        PRINT 'Bronze Layer Load Completed Successfully';
        PRINT 'Total Load Duration: ' 
              + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR)
              + ' seconds';
        PRINT '====================================================================';

	END TRY

	BEGIN CATCH
			PRINT '=================================================================';
			PRINT 'ERROR DETECTED DURING BRONZE LAYER';
			PRINT '=================================================================';
			
			PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
			PRINT 'Error Message: ' + ERROR_MESSAGE();
			PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);

			PRINT '==================================================================';
		
		END CATCH 
END;






