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