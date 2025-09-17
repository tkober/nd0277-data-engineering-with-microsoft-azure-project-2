IF OBJECT_ID('dbo.dim_time') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[dim_time];
END

CREATE EXTERNAL TABLE dbo.dim_time
WITH (
    LOCATION    = 'dbo.dim_time',
    DATA_SOURCE = [project2adlfs_project2adl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT DISTINCT
    REPLACE(CONVERT(VARCHAR(8), a_timestamp, 108), ':', '') AS time_string,
    CAST(a_timestamp AS time)        AS [time],
    DATEPART(HOUR,   a_timestamp)    AS [hour],
    DATEPART(MINUTE, a_timestamp)    AS [minute],
    DATEPART(SECOND, a_timestamp)    AS [second]
FROM (
    SELECT start_at AS a_timestamp FROM dbo.staging_trip
    UNION ALL
    SELECT ended_at AS a_timestamp   FROM dbo.staging_trip
) s;
GO

SELECT TOP 100 * FROM dbo.dim_time;
GO
