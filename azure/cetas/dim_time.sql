SELECT DISTINCT
    REPLACE(CONVERT(VARCHAR(8), a_timestamp, 108), ':', '') AS time_string,
    CAST(a_timestamp AS time)        AS [time],
    DATEPART(HOUR,   a_timestamp)    AS [hour],
    DATEPART(MINUTE, a_timestamp)    AS [minute],
    DATEPART(SECOND, a_timestamp)    AS [second]
FROM (
    SELECT start_at AS a_timestamp FROM dbo.staging_trip
    UNION ALL
    SELECT ended_at AS a_timestamp   FROM dbo.staging_trip
) s;