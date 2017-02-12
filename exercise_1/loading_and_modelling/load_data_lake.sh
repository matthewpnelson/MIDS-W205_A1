#! /bin/bash


#download the zip containing all hospital files & unzip
#wget -qO- -O tmp.zip https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip && unzip tmp.zip && rm tmp.zip
#wget -o hospitals.zip https://data.medicare.gov/views/bg9k-emty/files/6c902f45-e28b-42f5-9f96-ae9d1e583472?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip

unzip Hospital_Revised_Flatfiles.zip -d Hospital_Revised_Flatfiles

#create HDFS folder for hospital files (first delete it if it exists already)
hdfs dfs -rm -r /user/w205/hospital_compare
hdfs dfs -mkdir /user/w205/hospital_compare

cd Hospital_Revised_Flatfiles

#remove headers, rename file and move to HDFS folder
tail -n +2 'Hospital General Information.csv' > hospitals.csv
hdfs dfs -mkdir /user/w205/hospital_compare/hospitals
hdfs dfs -put hospitals.csv /user/w205/hospital_compare/hospitals

tail -n +2 'Timely and Effective Care - Hospital.csv' > effective_care.csv
hdfs dfs -mkdir /user/w205/hospital_compare/effective_care
hdfs dfs -put effective_care.csv /user/w205/hospital_compare/effective_care

tail -n +2 'Readmissions and Deaths - Hospital.csv' > readmissions.csv
hdfs dfs -mkdir /user/w205/hospital_compare/readmissions
hdfs dfs -put readmissions.csv /user/w205/hospital_compare/readmissions

tail -n +2 'Measure Dates.csv' > measures.csv
hdfs dfs -mkdir /user/w205/hospital_compare/measures
hdfs dfs -put measures.csv /user/w205/hospital_compare/measures

tail -n +2 'hvbp_hcahps_05_28_2015.csv' > survey_responses.csv
hdfs dfs -mkdir /user/w205/hospital_compare/survey_responses
hdfs dfs -put survey_responses.csv /user/w205/hospital_compare/survey_responses

#create a lingering record of headers for files just in case
touch ../headers.txt
head -n 1 'Hospital General Information.csv' >> ../headers.txt
touch $"\n" headers.txt
head -n 1 'Timely and Effective Care - Hospital.csv' >> ../headers.txt
touch $'\n' headers.txt
head -n 1 'Readmissions and Deaths - Hospital.csv' >> ../headers.txt
touch $'\n' headers.txt
head -n 1 'Measure Dates.csv' >> ../headers.txt
touch $'\n' headers.txt
head -n 1 'hvbp_hcahps_05_28_2015.csv' >> ../headers.txt
hdfs dfs -put ../headers.txt /user/w205/hospital_compare

cd ..
#delete original zip file & folder
rm -r -f Hospital_Revised_Flatfiles
rm Hospital_Revised_Flatfiles.zip
