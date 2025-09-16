INSERT INTO dim_station (
    station_id,
    name,
    latitude,
    longitude
)
SELECT 
    station_id,
    name,
    latitude,
    longitude
FROM station 