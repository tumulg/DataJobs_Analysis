/*
Question: What are the most optimal skills to learn(Most in-demand and high-paying skills)?
Points to focus on -
1. Identify skills in high demand and associated with high average salaries for Data Analyst roles
2. Concentrates on remote positionsa with specified salaries
3. Why? Target skills that offer job security(high demand) and financial benefit(high salary), offering strategic insights for career development in data analysis.
*/

WITH skills_indemand AS (
    SELECT 
        sd.skill_id,
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
        jpf.salary_year_avg IS NOT NULL AND
        jpf.job_work_from_home = TRUE
    GROUP BY 
        sd.skill_id
),
avg_salary AS (
    SELECT
        sd.skills, sd.skill_id,
        ROUND(AVG(jpf.salary_year_avg), 0) AS avg_yearly_salary
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
        sd.skill_id
)
SELECT
    si.skill_id,
    si.skills,
    si.demand_count,
    avg_s.avg_yearly_salary
FROM 
    skills_indemand si
INNER JOIN 
    avg_salary avg_s on si.skill_id = avg_s.skill_id
WHERE 
    si.demand_count >= 10
ORDER BY 
    si.demand_count DESC, 
    avg_s.avg_yearly_salary DESC
LIMIT 25;

-- Simplier query
SELECT
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg), 0) AS avg_yearly_salary
FROM 
    job_postings_fact jpf
INNER JOIN
    skills_job_dim sjd ON jpf.job_id = sjd.job_id
INNER JOIN
    skills_dim sd ON sd.skill_id = sjd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst' AND
    jpf.job_work_from_home = TRUE AND
    jpf.salary_year_avg IS NOT NULL
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.job_id) >= 10
ORDER BY 
    demand_count DESC,
    avg_yearly_salary DESC
LIMIT 25;

/*
Summary of Optimal Skills for Remote Data Analysts
1. SQL, Python, and Excel remain essential and in high demand, forming the foundation of nearly every data analyst job, with solid salaries to match.

2. Cloud and engineering-oriented tools like Snowflake, AWS, Azure, and Go offer exceptional salary potential, signaling a shift toward hybrid analyst-engineer roles.

3. Business intelligence and visualization platforms such as Tableau, Power BI, and Looker are not only widely required but also well-compensated, reflecting the importance of turning data into actionable insights.
*/