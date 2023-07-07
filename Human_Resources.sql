## Question 1
SELECT gender, count(*) AS Count
FROM Human_Resources
WHERE termdate IS NULL
GROUP BY gender;
--------------------------
## Question 2
SELECT race, count(*) AS Count
FROM Human_Resources
WHERE termdate IS NULL
GROUP BY race
ORDER BY Count DESC;
--------------------------
## Question 3
SELECT CASE
                WHEN age >= 18 AND age <= 25 THEN '18-25'
                WHEN age >= 26 AND age <= 35 THEN '26-35'
                WHEN age >= 36 AND age <= 45 THEN '36-45'
                WHEN age >= 46 AND age <= 55 THEN '46-55'
                WHEN age >= 56 AND age <= 65 THEN '56-65'
                Else '65+' END AS age_group, gender, COUNT(*) AS Count
FROM Human_Resources
WHERE termdate is NULL
GROUP BY age_group, gender
ORDER BY age_group,gender;
--------------------------
## Question 4
SELECT location, COUNT(*) AS Count
FROM Human_Resources
WHERE termdate IS NULL
GROUP BY location
ORDER BY Count DESC;
--------------------------
## Question 5
SELECT ROUND(AVG(DATEDIFF(termdate, hire_date))/365,0) AS avg_length_of_employment
FROM Human_Resources
WHERE termdate IS NOT NULL  AND termdate <= CURDATE();
--------------------------
## Question 6
SELECT department, gender, COUNT(*) AS Count
FROM Human_Resources
WHERE termdate IS NULL
GROUP BY department, gender
ORDER BY department;
--------------------------
## Question 7
SELECT jobtitle, count(*) as Count
FROM Human_Resources
WHERE termdate IS NULL
GROUP BY jobtitle
ORDER BY Count DESC;
--------------------------
## Question 8
SELECT department,
    total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
FROM(
    SELECT department,
    COUNT(*) AS total_count,
    SUM(CASE WHEN termdate IS NOT NULL AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
    FROM Human_Resources
    GROUP BY department) AS subquery
ORDER BY termination_rate DESC;
--------------------------
## Question 9
SELECT location_state, COUNT(*) AS Count
FROM Human_Resources
WHERE termdate IS NULL
GROUP BY location_state
ORDER BY Count DESC;
--------------------------
## Question 10
SELECT Year,
    Hires,
    Terminations,
    (Hires-Terminations) AS Net_change,
    ROUND(((Hires - Terminations) / hires * 100), 2) AS Net_change_percent
FROM(
    SELECT YEAR(hire_date) AS Year,
    COUNT(*) AS Hires,
    SUM(CASE WHEN termdate IS NOT NULL and termdate <= CURDATE() THEN 1 ELSE 0 END) AS Terminations
FROM Human_Resources
GROUP BY YEAR(hire_date)) AS subquery
ORDER BY Year ASC;
--------------------------
## Question 11
SELECT department, ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),0) as avg_tenure
FROM Human_Resources
WHERE termdate <= CURDATE() AND termdate IS NOT NULL
GROUP BY department
