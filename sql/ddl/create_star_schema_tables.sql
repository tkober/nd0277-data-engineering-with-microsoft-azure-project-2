DROP TABLE IF EXISTS fact_trip;
DROP TABLE IF EXISTS fact_payment;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_time;
DROP TABLE IF EXISTS dim_station;
DROP TABLE IF EXISTS dim_rider;

CREATE TABLE dim_rider (
    rider_id     BIGINT PRIMARY KEY,
    address      VARCHAR,
    first_name   VARCHAR,
    last_name    VARCHAR,
    birthday     DATE,
    is_member    BOOLEAN
);

CREATE TABLE dim_station (
    station_id   VARCHAR PRIMARY KEY,
    name         VARCHAR,
    latitude     DOUBLE PRECISION,
    longitude    DOUBLE PRECISION
);

CREATE TABLE dim_date (
    date_string       VARCHAR PRIMARY KEY,
    date              DATE,
    year              BIGINT,
    quarter           BIGINT,
    month             BIGINT,
    week              BIGINT,
    day               BIGINT,
    weekday           BIGINT,
    weekday_name      VARCHAR,
    month_name        VARCHAR,
    first_of_year     DATE,
    last_of_year      DATE,
    first_of_quarter  DATE,
    last_of_quarter   DATE,
    first_of_month    DATE,
    last_of_month     DATE,
    is_leap_year      BOOLEAN,
    is_weekend        BOOLEAN
);

CREATE TABLE dim_time (
    time_string  VARCHAR PRIMARY KEY,
    time         TIME,
    hour         BIGINT,
    minute       BIGINT,
    second       BIGINT
);

CREATE TABLE fact_payment (
    payment_id    BIGINT PRIMARY KEY,
    payment_date  VARCHAR NOT NULL,          
    rider_id      BIGINT  NOT NULL,          
    amount        DOUBLE PRECISION
);

CREATE TABLE fact_trip (
    trip_id               BIGINT PRIMARY KEY,
    rider_id              BIGINT  NOT NULL,  
    start_station_id      VARCHAR,            
    end_station_id        VARCHAR,            
    start_date            VARCHAR,           
    end_date              VARCHAR,           
    start_time            VARCHAR,           
    end_time              VARCHAR,           
    rideable_type         VARCHAR,
    trip_duration_seconds BIGINT,
    rider_age             BIGINT
);


CREATE INDEX idx_fact_payment_payment_date ON fact_payment (payment_date);
CREATE INDEX idx_fact_payment_rider_id     ON fact_payment (rider_id);


CREATE INDEX idx_fact_trip_rider_id        ON fact_trip (rider_id);
CREATE INDEX idx_fact_trip_start_station   ON fact_trip (start_station_id);
CREATE INDEX idx_fact_trip_end_station     ON fact_trip (end_station_id);
CREATE INDEX idx_fact_trip_start_date      ON fact_trip (start_date);
CREATE INDEX idx_fact_trip_end_date        ON fact_trip (end_date);
CREATE INDEX idx_fact_trip_start_time      ON fact_trip (start_time);
CREATE INDEX idx_fact_trip_end_time        ON fact_trip (end_time);