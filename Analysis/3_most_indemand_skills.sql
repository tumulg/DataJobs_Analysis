/* 
Question: What are the most in-demand skills for data analysis?
Points to focus on -
1. Join job postings to inner join both skills tables
2. Identify the top 5 skills indemand skills for a data analyst
3. Focus on all job postings
4. Why? Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.
*/

SELECT 
    sd.skills,
    COUNT(sjd.skill_id) AS demand_count
FROM 
    job_postings_fact jpf
INNER JOIN 
    skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim sd ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_work_from_home = TRUE
GROUP BY 
    sd.skills
ORDER BY
    demand_count DESC
LIMIT 5;