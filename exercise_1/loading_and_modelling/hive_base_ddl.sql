
DROP TABLE hospitals;

CREATE EXTERNAL TABLE hospitals(hospital_id STRING,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county_name STRING,
    phone_number STRING,
    hospital_type STRING,
    hospital_ownership STRING,
    emergency_services STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "",
    "escapeChar" = '\\')
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare/hospitals/';
