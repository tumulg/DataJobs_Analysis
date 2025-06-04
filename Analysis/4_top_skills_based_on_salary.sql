/*
Question: What are the to skills based on salary?
Points to focus on -
1. Look at the average salary associated with each skill for Data Analyst positions
2. Focuses on roles with specified salaries, regardless of location
3. Why? It reveals how different skills impact salary levels for Data Analysts and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    sd.skills, ROUND(AVG(jpf.salary_year_avg), 0) AS avg_yearly_salary
FROM 
    job_postings_fact jpf
INNER JOIN 
    skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT NULL AND
    jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
ORDER BY 
    avg_yearly_salary DESC
LIMIT 25;

/*
Key Trends Behind the Highest-Paying Data Analyst Skills in 2023:
1. Big data, cloud platforms, and ML tools (e.g. PySpark, Databricks, GCP, DataRobot) are the top-paying skills, reflecting strong demand for advanced analytics and scalable data engineering.
2. DevOps and programming skills (e.g. Bitbucket, GitLab, Golang, Kubernetes) fetch high salaries, showing that data analysts with software engineering or automation capabilities are highly valued.
3. Niche or specialized tools (e.g. Couchbase, Watson, MicroStrategy) are linked to premium salaries, likely due to a mix of lower supply and targeted business use cases. 
*/