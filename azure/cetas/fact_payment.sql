IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
BEGIN
    DROP EXTERNAL TABLE [dbo].[fact_payment];
END

CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION    = 'dbo.fact_payment',
    DATA_SOURCE = [project2adlfs_project2adl_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS
SELECT 
    payment_id,
    CONVERT(VARCHAR(8), [date], 112) as payment_date,
    rider_id,
    amount
FROM dbo.staging_payment
GO

SELECT TOP 100 * FROM dbo.fact_payment;
GO
