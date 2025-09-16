INSERT INTO fact_payment (
    payment_id,
    payment_date,
    rider_id,
    amount
)
SELECT 
    payment_id,
    to_char(date, 'YYYYMMDD') as payment_date,
    rider_id,
    amount
FROM payment