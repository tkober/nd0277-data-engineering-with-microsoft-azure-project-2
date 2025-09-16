INSERT INTO dim_date
(
    date_string,
    date,
    year,
    quarter,
    month,
    week,
    day,
    weekday,
    weekday_name,
    month_name,
    first_of_year,
    last_of_year,
    first_of_quarter,
    last_of_quarter,
    first_of_month,
    last_of_month,
    is_leap_year,
    is_weekend
)
SELECT DISTINCT 
    to_char(a_date, 'YYYYMMDD')                              AS date_string,
    a_date::date                                             AS date,
    EXTRACT(YEAR    FROM a_date)::int                        AS year,
    EXTRACT(QUARTER FROM a_date)::int                        AS quarter,
    EXTRACT(MONTH   FROM a_date)::int                        AS month,
    EXTRACT(WEEK    FROM a_date)::int                        AS week,
    EXTRACT(DAY     FROM a_date)::int                        AS day,
    EXTRACT(ISODOW  FROM a_date)::int                        AS weekday,
    to_char(a_date, 'FMDay')                                 AS weekday_name,
    to_char(a_date, 'FMMonth')                               AS month_name,
    date_trunc('year',    a_date)::date                      AS first_of_year,
    (date_trunc('year',    a_date) + interval '1 year' - interval '1 day')::date    AS last_of_year,
    date_trunc('quarter', a_date)::date                      AS first_of_quarter,
    (date_trunc('quarter', a_date) + interval '3 months' - interval '1 day')::date  AS last_of_quarter,
    date_trunc('month',   a_date)::date                      AS first_of_month,
    (date_trunc('month',   a_date) + interval '1 month' - interval '1 day')::date   AS last_of_month,
    (
      (EXTRACT(YEAR FROM a_date)::int % 4 = 0 AND EXTRACT(YEAR FROM a_date)::int % 100 <> 0)
      OR EXTRACT(YEAR FROM a_date)::int % 400 = 0
    )                                                        AS is_leap_year,
    (EXTRACT(ISODOW FROM a_date) IN (6,7))                   AS is_weekend
FROM (
    SELECT start_at AS a_date FROM trip
    UNION ALL
    SELECT ended_at AS a_date FROM trip
    UNION ALL
    SELECT date     AS a_date FROM payment
);
