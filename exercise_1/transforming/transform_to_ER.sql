-- No Need to Recreate hospitals Table, can utilize the original import
-- No Need to Recreate survey_averages Table, can utilize the original import



DROP TABLE procedures_detail_temp;

CREATE TABLE procedures_detail_temp
    STORED AS TEXTFILE
    -- LOCATION '/user/w205/hospital_compare/readmissions'
   AS
SELECT procedures.*,
   care.hospital_id AS care_hospital_id,
   care.condition AS care_condition,
   care.score AS care_score,
   care.sample AS care_sample,
   care.footnote AS care_footnote
FROM procedures
LEFT OUTER JOIN care
ON procedures.procedure_id = care.procedure_id;

DROP TABLE procedures_detail;

CREATE TABLE procedures_detail
    STORED AS TEXTFILE
    -- LOCATION '/user/w205/hospital_compare/readmissions'
   AS
SELECT procedures_detail_temp.*,
   readmissions.hospital_id AS readmissions_hospital_id,
   readmissions.condition AS readmissions_condition,
   readmissions.national_comparison AS readmissions_national_comparison,
   readmissions.denominator AS readmissions_denominator,
   readmissions.score AS readmissions_score,
   readmissions.lower_est AS readmissions_lower_est,
   readmissions.higher_est AS readmissions_higher_est,
   readmissions.footnote AS readmissions_footnote
FROM procedures_detail_temp
LEFT OUTER JOIN readmissions
ON procedures_detail_temp.procedure_id = readmissions.procedure_id;

DROP TABLE procedures_detail_temp;

-- DROP TABLE procedures_detail_temp1;
--
-- CREATE TABLE procedures_detail_temp1(procedures.*, care_hospital_id, care_condition, care_score, care_sample, care_footnote)
--     ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
--     WITH SERDEPROPERTIES (
--         "separatorChar" = ",",
--         "quoteChar" = "'",
--         "escapeChar" = "\\"
--     )
--     STORED AS TEXTFILE
--     LOCATION'/user/w205/hospital_compare/'
--    AS
-- SELECT procedures.*,
--    care.hospital_id AS care_hospital_id,
--    care.condition AS care_condition,
--    care.score AS care_score,
--    care.sample AS care_sample,
--    care.footnote AS care_footnote
-- FROM procedures_detail_temp1
-- LEFT OUTER JOIN care
-- ON procedures.procedure_id = care.procedure_id;
--
--


-- Create Procedures (Measures) Table
-- DROP TABLE procedures_detail_temp1;
--
-- CREATE TABLE procedures_detail_temp1
-- AS SELECT *
-- FROM procedures;
--
-- -- Complete a left outer join with the effective care table in order to bring
-- -- in all information relating to procedures and the hospitals which perform
-- -- them
--
-- -- Working code, duplicates the table but ads joined data.
-- -- Could not get INSERT INTO SELECT procedures_detail working...
-- DROP TABLE procedures_detail_temp2;
--
-- CREATE TABLE procedures_detail_temp2 AS
-- SELECT procedures_detail_temp1.*,
--     care.hospital_id AS care_hospital_id,
--     care.condition AS care_condition,
--     care.score AS care_score,
--     care.sample AS care_sample,
--     care.footnote AS care_footnote
-- FROM procedures_detail_temp1
-- LEFT OUTER JOIN care
-- ON procedures_detail_temp1.procedure_id = care.procedure_id;
--
-- DROP TABLE procedures_detail_temp1;
--
-- -- Couldn't get this working...
-- --INSERT INTO procedures_detail (care_hospital_id, care_condition, care_score, care_sample, care_footnote)
-- --SELECT care.hospital_id AS care_hospital_id,
-- --    care.condition AS care_condition,
-- --    care.score AS care_score,
-- --    care.sample AS care_sample,
-- --    care.footnote AS care_footnote
-- --FROM procedures_detail
-- --LEFT OUTER JOIN care
-- --ON procedures_detail.procedure_id = care.procedure_id;
--
--
-- -- Complete a left outer join with the readmissions table in order to bring
-- -- in all information relating to procedures and the hospitals which perform
-- -- them
-- DROP TABLE procedures_detail;
--
-- CREATE TABLE procedures_detail AS
-- SELECT procedures_detail_temp2.*,
--     readmissions.hospital_id AS readmissions_hospital_id,
--     readmissions.condition AS readmissions_condition,
--     readmissions.national_comparison AS readmissions_national_comparison,
--     readmissions.denominator AS readmissions_denominator,
--     readmissions.score AS readmissions_score,
--     readmissions.lower_est AS readmissions_lower_est,
--     readmissions.higher_est AS readmissions_higher_est,
--     readmissions.footnote AS readmissions_footnote
-- FROM procedures_detail_temp2
-- LEFT OUTER JOIN readmissions
-- ON procedures_detail_temp2.procedure_id = readmissions.procedure_id;
--
-- DROP TABLE procedures_detail_temp2;
--
-- SELECT measure_start
-- FROM procedures
-- WHERE procedure_id = '"MORT_30_AMI"'
-- LIMIT 50;
--
-- SELECT procedures_detail_temp2.procedure_id,
--     readmissions.procedure_id
-- FROM procedures_detail_temp2
-- LEFT OUTER JOIN readmissions
-- ON procedures_detail_temp2.procedure_id = readmissions.procedure_id
-- LIMIT 50;


-- to query column names
-- SHOW COLUMNS FROM care

-- to query you need to use double quotes!?!
-- SELECT measure_start, measure_
-- FROM procedures_detail
-- WHERE procedure_id = '"AMI_7a"'
-- LIMIT 10;

-- change data type?
--ALTER TABLE care
--ALTER COLUMN score INTEGER
