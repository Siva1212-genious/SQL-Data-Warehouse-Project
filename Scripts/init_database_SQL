/*
========================================
Create Database and Schemas
========================================

Script Purpose:
            This script creates a new database named 'Datawarehouse' after checking if it already exists.
			If the database exists, it is dropped and recreated. 
			Additionally, the script sets up three schemas with in the database : 'Bronze', 'Silver' and 'Gold'.

WARNING:
      Running this script will drop the entire 'Datawarehouse' database if it exists.
	  All data in the database will be permanently deleted.
	  Proceed with caution and ensure you have proper backups before running this scripts.
*/

use master;
GO

--Drop and recreate the 'Datawarehouse' Database
If EXISTS (select 1 from sys.databases where name = 'Datawarehouse')
BEGIN
    ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE Datawarehouse;
END;
GO


--Create 'Datawarehouse' Database
Create DATABASE Datawarehouse
GO


use Datawarehouse
GO


--Create Schemas

Create Schema Bronze;
GO

Create Schema Silver;
GO

Create Schema Gold;
GO

