/*
Question: What skills are required for the top-paying data analyst jobs?
Points to focus on -
1. Analyze based on Top 10 highest paying Data Analyst roles
2. Add specific skills required for these roles
3. Why? It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs as (
    SELECT 
        jpf.job_id, cd.name AS company_name, 
        jpf.job_title, jpf.salary_year_avg
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
    LIMIT 10
)

SELECT 
    tpj.*,
    sd.skills
FROM 
    top_paying_jobs tpj
INNER JOIN
    skills_job_dim sjd
ON
    tpj.job_id = sjd.job_id
INNER JOIN 
    skills_dim sd 
ON
    sjd.skill_id = sd.skill_id
ORDER BY
    tpj.salary_year_avg DESC;

/*
Here is the breakdown of the most demanding skills for data analyst in 2023, based on job postings:
1. SQL is leading with a bold count of 8.
2. Python follows closely at 7.
3. Tableau is also highly sought after, with a count of 6.
4. Other skills such as R, Snowflake, Pandas and Excel show varying degrees of demand.
*/