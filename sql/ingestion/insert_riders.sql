INSERT INTO dim_rider (
    rider_id, 
    address,
    first_name,
    last_name,
    birthday,
    is_member,
    account_start_date,
    account_end_date
)
SELECT 
    rider_id, 
    address,
    first as first_name,
    last as last_name,
    birthday,
    is_member,
    account_start_date,
    account_end_date
FROM rider 