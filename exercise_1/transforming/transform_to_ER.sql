-- No Need to Recreate Hospitals Table, can utilize the original import


-- Create Procedures (Measures) Table
CREATE TABLE AS SELECT *
INTO procedures_detail
FROM procedures;

-- Complete a right outer join with the effective care table in order to bring
-- in all information relating to procedures and the hospitals which perform
-- them
SELECT (effective_care.hospital_id,
    effective_care.condition,
effective_care.score,
effective_care.sample,
effective_care.footnote)
INTO procedures_detail
FROM procedures_detail
RIGHT OUTER JOIN effective_care
ON procedures_detail.procedure_id=effective_care.procedure_id;

-- Complete a right outer join with the readmissions table in order to bring
-- in all information relating to procedures and the hospitals which perform
-- them
SELECT (readmissions.hospital_id,
    readmissions.condition,
    readmissions.national_comparison,
    readmissions.denominator,
    readmissions.score,
    readmissions.lower_est,
    readmissions.higher_est,
    readmissions.footnote)
INTO procedures_detail
FROM procedures_detail
RIGHT OUTER JOIN readmissions
ON procedures_detail.procedure_id=readmissions.procedure_id;
