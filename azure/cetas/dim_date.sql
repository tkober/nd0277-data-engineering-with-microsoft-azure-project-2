SELECT DISTINCT
    CONVERT(VARCHAR(8), CAST(a_date AS date), 112)            AS date_string,   -- 'YYYYMMDD'
    CAST(a_date AS date)                                      AS [date],
    DATEPART(YEAR,    a_date)                                 AS [year],
    DATEPART(QUARTER, a_date)                                 AS [quarter],
    DATEPART(MONTH,   a_date)                                 AS [month],
    DATEPART(ISO_WEEK, a_date)                                AS [week],        
    DATEPART(DAY,     a_date)                                 AS [day],
    ((DATEPART(WEEKDAY, a_date) + @@DATEFIRST + 5) % 7) + 1   AS [weekday],     
    DATENAME(WEEKDAY, a_date)                                 AS weekday_name,  
    DATENAME(MONTH,   a_date)                                 AS month_name,    
    DATEFROMPARTS(YEAR(a_date), 1, 1)                         AS first_of_year,
    EOMONTH(DATEFROMPARTS(YEAR(a_date), 12, 1))               AS last_of_year,
    DATEFROMPARTS(YEAR(a_date), ( (DATEPART(QUARTER,a_date)-1)*3 )+1, 1) AS first_of_quarter,
    EOMONTH(DATEFROMPARTS(YEAR(a_date), ( (DATEPART(QUARTER,a_date)-1)*3 )+1, 1), 2) AS last_of_quarter,
    DATEFROMPARTS(YEAR(a_date), MONTH(a_date), 1)             AS first_of_month,
    EOMONTH(a_date)                                           AS last_of_month,
    IIF( (YEAR(a_date)%4=0 AND YEAR(a_date)%100<>0) OR YEAR(a_date)%400=0, 1, 0) AS is_leap_year,
    IIF( ((DATEPART(WEEKDAY, a_date) + @@DATEFIRST + 5) % 7) + 1 IN (6,7), 1, 0)  AS is_weekend
FROM (
    SELECT start_at AS a_date FROM dbo.staging_trip
    UNION ALL
    SELECT ended_at AS a_date FROM dbo.staging_trip
    UNION ALL
    SELECT [date]   AS a_date FROM dbo.staging_payment
) s;