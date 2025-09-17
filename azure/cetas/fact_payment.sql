SELECT 
    payment_id,
    CONVERT(VARCHAR(8), [date], 112) as payment_date,
    rider_id,
    amount
FROM dbo.staging_payment