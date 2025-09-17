IF OBJECT_ID('dbo.dim_riders') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dim_riders];
END

CREATE EXTERNAL TABLE dbo.dim_riders
WITH (
    LOCATION    = 'dbo.dim_riders',
    DATA_SOURCE = [project2adlfs_project2adl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
    rider_id, 
    address,
    first as first_name,
    last as last_name,
    birthday,
    is_member,
    account_start_date,
    account_end_date
FROM dbo.staging_rider; 
GO

SELECT TOP 100 * FROM dbo.dim_riders;
GO