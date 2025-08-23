USE Jobs_Data;

CREATE TABLE Jobs_datas (
    Company_Clean            VARCHAR(255) NULL,
    Rating                   VARCHAR(255) NULL,
    City                     VARCHAR(100) NULL,
    State_Country            VARCHAR(500) NULL,
    Location                 VARCHAR(255) NULL,
    Position_Name            VARCHAR(255) NULL,
    Python                   VARCHAR(500) NULL,
    SQL                VARCHAR(500) NULL,
    R                        VARCHAR(500) NULL,
    Machine_Learning         VARCHAR(500) NULL,
    Excel                    VARCHAR(500) NULL,
    Tableau                 VARCHAR(500) NULL,
    Deep_Learning                   VARCHAR(500) NULL,
    PowerBI                  VARCHAR(500) NULL,
    Degree_Required          VARCHAR(500) NULL,
    Description       VARCHAR(Max) NULL,
    Pay_Period_Detect       VARCHAR(500) NULL,
    Min_Salary               VARCHAR(500) NULL,
    Max_Salary               VARCHAR(500) NULL,
    Avg_Salary               VARCHAR(500) NULL,
    Salary_Clean           VARCHAR(500) NULL,
    Currency          VARCHAR(100) NULL,
    Salary                   VARCHAR(500) NULL,
    Url                      VARCHAR(MAX) NULL,
    JobType_All              VARCHAR(500) NULL,
    JobType_0                VARCHAR(500) NULL,
    JobType_1                VARCHAR(500) NULL,
    JobType_2                VARCHAR(500) NULL,
    JobType_3                VARCHAR(500) NULL,
    Search_Input_country     VARCHAR(500) NULL,
    Search_Input_position    VARCHAR(500) NULL,
    External_Apply_Link      VARCHAR(MAX) NULL
);


SELECT COUNT(*) AS total_jobs FROM jobsdata;

SELECT DISTINCT Position_Name FROM jobsdata;

SELECT * FROM jobsdata;

SELECT * FROM jobsdata
ORDER BY Salary;

SELECT Position_Name,city, Salary
FROM jobsdata
WHERE Salary IS NULL;

SELECT COUNT(Position_Name), Location
FROM jobsdata
GROUP BY Location
HAVING COUNT(Position_Name)>5;

--See distinct job positions:
SELECT DISTINCT Position_Name FROM jobsdata;

--Check date ranges:
SELECT MIN(Search_input_position), MAX(Search_input_position)
FROM jobsdata;

--Avg salary by job role:
SELECT Position_Name, ROUND(AVG(CAST(Avg_Salary AS FLOAT)),2) AS avg_salary
FROM jobsdata
WHERE Avg_Salary IS NOT NULL
AND ISNUMERIC(Avg_Salary)=1
GROUP BY Position_Name
ORDER BY avg_salary DESC;

--Top 10 locations by number of jobs:
SELECT City, COUNT(*) AS total_jobs
FROM jobsdata
GROUP BY City
ORDER BY total_jobs DESC;

--Top 10 skills based on column count(python,SQL, etc.)
SELECT 'python' AS skill, COUNT(*) AS total_jobs
FROM Jobsdata
WHERE Python ='Yes'
UNION ALL 
SELECT 'SQL' AS skill, COUNT(*) AS total_jobs
FROM jobsdata
WHERE SQL ='Yes'
UNION ALL 
SELECT 'R' AS skill, COUNT(*) AS total_jobs
FROM Jobsdata
WHERE R ='Yes'
UNION ALL 
SELECT 'machine Learning' AS skill, COUNT(*) AS total_jobs
FROM jobsdata
WHERE machine_learning ='Yes'
ORDER BY total_jobs DESC;

---- Highest paying roles
SELECT Position_Name, City, MAX(Avg_Salary) AS max_salary
FROM jobsdata
WHERE Avg_Salary IS NOT NULL
GROUP BY Position_Name, City
ORDER BY max_salary DESC;

-- Salary by city:
SELECT 
    City, 
    ROUND(AVG(CAST(Avg_Salary AS FLOAT)), 2) AS avg_salary
FROM jobsdata
WHERE TRY_CAST(Avg_Salary AS FLOAT) IS NOT NULL
GROUP BY City
ORDER BY avg_salary DESC;


--Remote vs Onsite:

SELECT JobType_All, COUNT(*) AS total_jobs
FROM jobsdata
GROUP BY JobType_All
ORDER BY total_jobs DESC;

--Output summary table for dashboard:
CREATE VIEW jobs_summary AS 
SELECT 
    Position_Name,
    City,
    State_Country,
    ROUND(AVG(CAST(Avg_Salary AS FLOAT)), 2) AS avg_salary,
    COUNT(*) AS job_count,
    SUM(CASE WHEN Python = 1 THEN 1 ELSE 0 END) AS python_count,
    SUM(CASE WHEN SQL = 1 THEN 1 ELSE 0 END) AS sql_count,
    SUM(CASE WHEN machine_learning = 1 THEN 1 ELSE 0 END) AS ml_count,
    SUM(CASE WHEN PowerBI = 1 THEN 1 ELSE 0 END) AS powerbi_count
FROM jobsdata
GROUP BY Position_Name, City, State_Country;


