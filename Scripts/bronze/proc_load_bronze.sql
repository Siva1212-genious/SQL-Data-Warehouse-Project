/*
===========================================================================================
Stored Procedure : Load Bronze Layer (Source --> Bronze)
===========================================================================================
Script Purpose:
      This stored procedure loads data into the 'bronze' schema from external CSV files.
      It performs the following actions:
      - Truncates the bronze tables before loading data.
      - Uses the 'BULK INSERT' command to load data form csv files to bronze tables.


Parameters: 
    None.
   This stored procedure does not accept any parameters or return any values.

Usage Examples:
    EXEC bronze.load_bronze;
===========================================================================================
*/

CREATE PROCEDURE Bronze.load_bronze AS
Begin
	Begin Try
	    Declare @Begin_Time DateTime, @End_Time DateTime, @Total_Begin_Time DateTime, @Total_End_Time DateTime;
		
		print '======================================================================'
		print 'Loading Bronze Layer'
		print '======================================================================'


		Print '==========================================='
		print 'Loading CRM Tables'
		print '==========================================='
		
		SET @Total_Begin_Time =GetDate(); 
		Print @Total_Begin_Time
			SET @Begin_Time = GetDate();
		--Lets us load Cust_info data
			print '>> Truncating Table : Bronze.crm_cust_info'
			Truncate table Bronze.crm_cust_info

			print '>> Inserting Data Into Bronze.crm_cust_info'
			Bulk Insert Bronze.crm_cust_info
			from 'C:\Users\sivas\Desktop\SQL DataWarehouse\Datasets\Datasource_CRM\cust_info.csv'
			with (

				 Firstrow = 2,
				 Fieldterminator = ',',
				 Tablock 
			);
			SET @End_Time = GetDate();
			print '>> Loading Time : ' + cast(Datediff(second, @Begin_Time, @End_Time) as NVARCHAR) + 'Seconds';
			print '-----------------------------'


			--Let us load prd_info----------------------------------------------------
			SET @Begin_Time = GetDate();
			print '>> Truncating Table : Bronze.crm_prd_info'
			Truncate table Bronze.crm_prd_info

			print '>> Inserting Data Into Bronze.crm_prd_info'
			Bulk Insert Bronze.crm_prd_info
			from 'C:\Users\sivas\Desktop\SQL DataWarehouse\Datasets\Datasource_CRM\prd_info.csv'
			with(
				firstrow = 2,
				fieldterminator = ',',
				tablock      -- you can add many fields according to the requirement.
			) ;
			SET @End_Time = GetDate();
			print '>> Loading Time : ' + Cast(Datediff(second, @Begin_Time, @End_Time) as NVARCHAR) + 'Seconds';
			print '---------------------'


			-- Let us load sales_details------------------------------------------
			SET @Begin_Time = GetDate();
			print '>> Truncating Table : Bronze.crm_sales_details'
			TRUNCATE TABLE Bronze.crm_sales_details 

			print '>> Inserting Data Into Bronze.crm_sales_details'
			Bulk Insert Bronze.crm_sales_details
			from 'C:\Users\sivas\Desktop\SQL DataWarehouse\Datasets\Datasource_CRM\sales_details.csv'
			with(
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);
			SET @End_Time = GetDate();
			print '>> Loading Time : ' + Cast(Datediff(second, @Begin_Time, @End_Time) as NVARCHAR) + 'Seconds';
			print '--------------------------'


			print '===========================================';
			print 'Print ERP data';
			print '===========================================';

			--Let us load ERP_Customer details--------------------------------
			SET @Begin_Time = GetDate();
			print '>> Truncating Table : Bronze.erp_cust_az12'
			Truncate table Bronze.erp_cust_az12

			print '>> Inserting Data Into Bronze.erp_cust_az12'
			Bulk Insert Bronze.erp_cust_az12
			from 'C:\Users\sivas\Desktop\SQL DataWarehouse\Datasets\Datasource_ERP\CUST_AZ12.csv'
			with(
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);
			SET @End_Time = Getdate();
			print '>> Loading Data : ' + cast(Datediff(second, @Begin_Time, @End_Time) as NVARCHAR) + 'Second'; 
			print '--------------------------------';


			--Lets us load Bronze.erp_loc_a101
			SET @Begin_Time = GetDate();
			print '>> Truncating Table : Bronze.erp_loc_a101'
			Truncate table Bronze.erp_loc_a101

			print '>> Inserting Data Into Bronze.erp_loc_a101'
			Bulk Insert Bronze.erp_loc_a101
			from 'C:\Users\sivas\Desktop\SQL DataWarehouse\Datasets\Datasource_ERP\LOC_A101.csv'
			with(
			   firstrow = 2,
			   fieldterminator = ',',
			   tablock
			);
			SET @End_Time = GetDate();
			print '>> Loading Data : '+ cast(Datediff(second, @Begin_Time, @End_Time) as NVARCHAR) + 'Seconds';
			print '------------------------------';



			--Let us load Bronze.erp_px_cat_g1v2
			SET @Begin_Time = GetDate();
			print '>> Truncating Table : Bronze.erp_px_cat_g1v2'
			Truncate table Bronze.erp_px_cat_g1v2 

			print '>> Inserting Data Into Bronze.erp_px_cat_g1v2'
			Bulk Insert Bronze.erp_px_cat_g1v2
			from 'C:\Users\sivas\Desktop\SQL DataWarehouse\Datasets\Datasource_ERP\PX_CAT_G1V2.csv'
			with(
				firstrow = 2,
				fieldterminator = ',',
				tablock
			);
			SET @End_Time = GetDate();
			print '>> Loading Data: ' + cast(Datediff(second, @Begin_Time, @End_Time) as NVARCHAR) + 'Seconds';


	   SET @Total_End_Time = GetDate();
	   print @Total_End_Time
	   print 'Loading Bronze Layer Is Completed.'
	   print 'Total time taken to load :' + cast(Datediff(second, @Total_Begin_Time, @Total_End_Time) as NVARCHAR) + 'Seconds';

	END TRY
	Begin catch
	     print '============================================================'
		 print 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		 Print 'Error_Message' + ERROR_MESSAGE()
		 Print 'Error_Message' + CAST(ERROR_NUMBER() AS NVARCHAR)
		 PRINT 'Error_Message' + CAST(ERROR_STATE() AS NVARCHAR)

		 print '============================================================'
	End catch
END
