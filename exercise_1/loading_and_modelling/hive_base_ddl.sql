
DROP TABLE hospitals;

CREATE EXTERNAL TABLE hospitals
(
    hospital_id string,
    hospital_name string,
    address string,
    city string,
    state string,
    zip_code string,
    county_name string,
    phone_number string,
    hospital_type string,
    hospital_ownership string,
    emergency_services string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES(
    "separatorChar" = ",",
    "quoteChar" = "",
    "escapeChar" = '\\'
)
STORED AS TEXTFILE
LOCATION '/user/w205/hospital_compare';
