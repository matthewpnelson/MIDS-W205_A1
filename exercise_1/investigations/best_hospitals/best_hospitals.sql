-- Best Hospitals SQL query

-- What hospitals are models of high-quality care? That is, which hospitals have the most consistently high scores for a variety of procedures.

-- Tables to use: procedures_detail, hospitals, survey_averages

SELECT hospitals.hospital_id, hospitals.hospital_name,
    SUM(procedures_detail.care_score) AS Total_Score,
    avg(procedures_detail.care_score) AS Avg_Score,
    max(procedures_detail.care_score) - max(procedures_detail.care_score) AS Var_Score
    count(procedures_detail.care_score) AS Count_Score
    FROM hospitals
    LEFT OUTER JOIN procedures_detail
    ON hospitals.hospital_id = procedures_detail.care_hospital_id
    --WHERE Count_Score > 5
    GROUP BY procedures_detail.care_score
    ORDER BY Avg_Score DESC
    LIMIT 50;
