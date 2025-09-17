IF OBJECT_ID('dbo.staging_station') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[staging_station];
END

CREATE EXTERNAL TABLE dbo.staging_station
WITH (
    LOCATION    = 'dbo.staging_station',
    DATA_SOURCE = [project2adlfs_project2adl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
    station_id,
    name,
    latitude,
    longitude
FROM dbo.staging_station;
GO

SELECT TOP 100 * FROM dbo.staging_station
GO