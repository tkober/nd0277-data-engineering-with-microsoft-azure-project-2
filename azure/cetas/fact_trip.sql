SELECT
    t.trip_id,
    t.rider_id,
    t.start_station_id,
    t.end_station_id,
    CONVERT(VARCHAR(8), t.start_at, 112) AS start_date,                 -- 'YYYYMMDD'
    CONVERT(VARCHAR(8), t.ended_at, 112) AS end_date,                   -- 'YYYYMMDD'
    REPLACE(CONVERT(VARCHAR(8), t.start_at, 108), ':', '') AS start_time, -- 'HHMMSS'
    REPLACE(CONVERT(VARCHAR(8), t.ended_at, 108), ':', '') AS end_time,   -- 'HHMMSS'
    t.rideable_type,
    CAST(DATEDIFF(SECOND, t.start_at, t.ended_at) AS BIGINT) AS trip_duration_seconds,
    DATEDIFF(YEAR, r.birthday, t.ended_at)
      - CASE
          WHEN DATEADD(YEAR, DATEDIFF(YEAR, r.birthday, t.ended_at), r.birthday) > t.ended_at
            THEN 1 ELSE 0
        END AS rider_age
FROM dbo.staging_trip AS t
JOIN dbo.staging_rider AS r
  ON t.rider_id = r.rider_id;