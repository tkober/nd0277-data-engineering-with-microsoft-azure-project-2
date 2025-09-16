INSERT INTO dim_time (
    time_string,
    time,
    hour,
    minute,
    second
)
SELECT DISTINCT
    to_char(a_timestamp, 'HH24MISS') as time_string,
    a_timestamp::time as time,
    extract(HOUR from a_timestamp) as hour,
    extract(MINUTE from a_timestamp) as minute,
    extract(SECOND from a_timestamp)::INT as second
FROM (
    SELECT start_at as a_timestamp from trip
    UNION ALL
    SELECT ended_at as a_timestamp from trip
);