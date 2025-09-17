INSERT INTO fact_trip 
(
    trip_id,
    rider_id,
    start_station_id,
    end_station_id,
    start_date,
    end_date,
    start_time,
    end_time,
    rideable_type,
    trip_duration_seconds,
    rider_age
)
SELECT
    trip_id,
    trip.rider_id,
    start_station_id,
    end_station_id,
    to_char(start_at, 'YYYYMMDD') as start_date,
    to_char(ended_at, 'YYYYMMDD') as end_date,
    to_char(start_at, 'HH24MISS') as start_time,
    to_char(ended_at, 'HH24MISS') as end_time,
    rideable_type,
    extract(EPOCH FROM (ended_at - start_at))::BIGINT as trip_duration_seconds,
    extract(YEAR FROM age(ended_at, birthday)) as rider_age

FROM trip
INNER JOIN rider ON trip.rider_id = rider.rider_id 