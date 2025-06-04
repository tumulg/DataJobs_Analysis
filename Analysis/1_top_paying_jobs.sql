/* 
Question: What are the top paying Data Analyst jobs?
Points to focus on -
1. Identifying the top 10 highest paying Data Analyst roles that are available remotely.
2. Focusing on job postings with specified salaries (remove null).
3. Why? Highlight the top paying opportuinities for Data Analytics, offering insights into employement in Data Analyst Jobs.
*/

SELECT 
    jpf.job_id, cd.name AS company_name, jpf.job_title, 
    jpf.job_location, jpf.job_schedule_type, 
    jpf.salary_year_avg, jpf.job_posted_date
FROM 
    job_postings_fact jpf
LEFT JOIN 
    company_dim cd
ON 
    jpf.company_id = cd.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;