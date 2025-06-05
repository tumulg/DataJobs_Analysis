# Data Jobs Analysis 2023 (PostgreSQL Project)

## 📌 Introduction

This project analyzes thousands of job postings for **Data Analyst** roles in 2023 to uncover key industry trends, such as top-paying roles, most in-demand skills, and which tools or technologies command higher salaries. All queries are written in **PostgreSQL**, and the analysis is based on structured datasets sourced from real job postings.

> 🚫 **Note**: Due to the large size of the datasets, they are not included in this repository. The SQL files to create and load the database are available.

---

## 🧠 Background

The database includes four core tables:
- `job_postings_fact`: All job listings with title, salary, location, and other job attributes
- `company_dim`: Company details including name and links
- `skills_dim`: Distinct skills with types
- `skills_job_dim`: Mapping table between jobs and skills

The data was loaded using the following SQL files:
- `1_create_database.sql`: Creates the PostgreSQL database
- `2_create_tables.sql`: Builds all tables with constraints
- `3_modify_tables.sql`: Loads data from CSV files via pgAdmin4

The data industry is evolving rapidly. New tools emerge, old ones adapt, and the demand for particular skills fluctuates with market needs. To stay competitive as a Data Analyst, it’s crucial to understand:
- Which job titles pay the most?
- What are the most frequently required skills?
- Which tools lead to higher salaries?
- How can one prioritize skill development strategically?

This project answers these questions by examining real job market data through SQL.

---

## 🛠️ Tools I Used

- **PostgreSQL (SQL)** – Used to write and execute advanced queries for analyzing job market trends from structured data.
- **pgAdmin 4** – Served as the database management tool for creating the schema and loading large CSV datasets.
- **Visual Studio Code (VSCode)** – Used for writing, organizing, and managing SQL scripts and version-controlled files.
- **Git & GitHub** – Enabled version control and collaborative sharing of SQL scripts and project documentation.

---

## 📊 The Analysis

This project dives into the 2023 Data Analyst job market using SQL queries on a cleaned PostgreSQL database. I explored salary trends, skill demand, and optimal career strategies by breaking down the data into targeted questions.

Here's how I approached each question:

### 1️⃣ Top Paying Data Analyst Jobs

To begin, I wanted to identify the highest paying Data Analyst roles that are available remotely. The idea was simple — filter the dataset to only include jobs where the title is ‘Data Analyst’, the location is marked ‘Anywhere’, and the salary is explicitly stated. I joined this with the company details to enrich the results, sorted by annual salary, and narrowed it down to the top 10. This gave a clear picture of which companies are offering the best compensation for remote analysts.

```sql
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
```
| Company Name               | Job Title                            | Avg Yearly Salary (USD) |
|---------------------------|------------------------------------|------------------------|
| Mantys                    | Data Analyst                       | 650,000                |
| Meta                      | Director of Analytics              | 336,500                |
| AT&T                      | Associate Director- Data Insights  | 255,829.5              |
| Pinterest Job Advertisements| Data Analyst, Marketing           | 232,423                |
| Uclahealthcareers         | Data Analyst (Hybrid/Remote)       | 217,000                |
| SmartAsset                | Principal Data Analyst (Remote)    | 205,000                |
| Inclusively               | Director, Data Analyst - HYBRID    | 189,309                |
| Motional                  | Principal Data Analyst, AV Performance Analysis | 189,000         |
| SmartAsset                | Principal Data Analyst             | 186,000                |
| Get It Recruit - Information Technology | ERM Data Analyst        | 184,000                |

#### 💡 Insights:
- **Mantys** leads with a top-paying Data Analyst role offering an average annual salary of **₹650,000**, which is significantly higher than others in the list.
- Leadership titles such as **Director of Analytics** (Meta) and **Associate Director - Data Insights** (AT&T) are among the highest-paid, reflecting the salary bump at senior levels.
- Nearly all roles are **remote or hybrid** and **full-time**, indicating a strong demand for flexible, high-paying data analyst positions.

### 2️⃣ Skills Required for Top Paying Jobs

After identifying the top-paying roles, I was curious about the specific skill sets they demand. So, I used the job IDs from the top 10 jobs and linked them to the skills table through a bridge table. This allowed me to list the exact skills those high-paying positions required. It was insightful to see technologies like SQL, Python, and Tableau show up frequently — validating their relevance in high-stakes roles.

```sql
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
    tpj.*, sd.skills
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
```
#### 💡 Insights:
- **Core Technical Skills:** SQL, Python, and R are the most commonly required skills, emphasizing strong data querying, programming, and statistical analysis capabilities.
- **Cloud & Big Data Technologies:** AWS, Azure, Databricks, and Snowflake frequently appear, indicating a shift toward cloud-based and scalable data platforms.
- **Visualization & Collaboration Tools:** Tableau, Power BI, and tools like Git, Jenkins, and Atlassian are important for effective data storytelling and teamwork in cross-functional environments.

### 3️⃣ Most In-Demand Skills

Next, I shifted focus from salary to popularity. I wanted to know which skills are simply most in demand, especially for remote Data Analyst roles. By joining the job postings with the skills data and counting how often each skill appeared, I could rank them based on frequency. The outcome provided a snapshot of what the industry currently values the most, helping paint a picture of baseline expectations for job seekers.

```sql
SELECT 
    sd.skills, COUNT(sjd.skill_id) AS demand_count
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
```
| Skill    | Demand Count |
|----------|--------------|
| SQL      | 7,291        |
| Excel    | 4,611        |
| Python   | 4,330        |
| Tableau  | 3,745        |
| Power BI | 2,609        |

#### 💡 Insights:
- **SQL** is the most demanded skill, appearing in over 7,200 job listings, making it essential for data roles.
- **Excel** and **Python** are also highly valued, reflecting the need for strong data manipulation and programming abilities.
- Visualization tools like **Tableau** and **Power BI** remain important, emphasizing the value of data storytelling.

### 4️⃣ Top Skills Based on Salary

At this point, I wanted to flip the perspective: instead of what’s most common, I asked what skills actually *pay* the most. By linking skill data with salary information and calculating the average salary per skill, I could identify which tools and platforms bring in the biggest paychecks. This was especially useful for spotting niche, specialized skills like PySpark, GCP, or Kubernetes that command high salaries even if they’re less common.

```sql
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
```
| Skill         | Avg Yearly Salary |
|---------------|-------------------|
| pyspark       | 208,172           |
| bitbucket     | 189,155           |
| couchbase     | 160,515           |
| watson        | 160,515           |
| datarobot     | 155,486           |
| gitlab        | 154,500           |
| swift         | 153,750           |
| jupyter       | 152,777           |
| pandas        | 151,821           |
| elasticsearch | 145,000           |
| golang        | 145,000           |
| numpy         | 143,513           |
| databricks    | 141,907           |
| linux         | 136,508           |
| kubernetes    | 132,500           |
| atlassian     | 131,162           |
| twilio        | 127,000           |
| airflow       | 126,103           |
| scikit-learn  | 125,781           |
| jenkins       | 125,436           |
| notion        | 125,000           |
| scala         | 124,903           |
| postgresql    | 123,879           |
| gcp           | 122,500           |
| microstrategy | 121,619           |

#### 💡 Insights:
- **Highest paid skills:** PySpark ($208,172), Bitbucket ($189,155), and Couchbase ($160,515) top the list, highlighting the value of big data, version control, and NoSQL expertise.  
- **Core data science tools** like Jupyter ($152,777), Pandas ($151,821), Scikit-learn ($125,781), and NumPy ($143,513) offer strong salaries, reflecting their critical role in data science workflows.  
- **Cloud and DevOps skills** such as Kubernetes ($132,500), Linux ($136,508), Jenkins ($125,436), and GCP ($122,500) are well-compensated, underscoring the demand for infrastructure and automation knowledge.

### 5️⃣ Most Optimal Skills to Learn

Finally, I brought everything together by looking for overlap between demand and compensation. I wrote a query that identified skills with both high frequency and high average salary, filtering out those that didn’t meet a minimum demand threshold. This helped me surface the most optimal skills — the ones worth investing in from both a job security and financial return standpoint. It balanced practicality with ambition, making the insights more actionable for career planning.

```sql
WITH skills_indemand AS (
    SELECT 
        sd.skill_id, sd.skills,
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
    si.skill_id, si.skills,
    si.demand_count, avg_s.avg_yearly_salary
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
```
> **Note**:  There is also a **simpler version of this query** available in the same SQL file, which achieves similar results with fewer steps. You can refer to it for a more concise approach.

| Skill       | Demand Count | Avg Yearly Salary |
|-------------|---------------|-------------------|
| sql         | 398           | 97,237            |
| excel       | 256           | 87,288            |
| python      | 236           | 101,397           |
| tableau     | 230           | 99,288            |
| r           | 148           | 100,499           |
| power bi    | 110           | 97,431            |
| sas         | 63            | 98,902            |
| powerpoint  | 58            | 88,701            |
| looker      | 49            | 103,795           |
| word        | 48            | 82,576            |
| snowflake   | 37            | 112,948           |
| oracle      | 37            | 104,534           |
| sql server  | 35            | 97,786            |
| azure       | 34            | 111,225           |
| aws         | 32            | 108,317           |
| sheets      | 32            | 86,088            |
| flow        | 28            | 97,200            |
| go          | 27            | 115,320           |
| spss        | 24            | 92,170            |
| vba         | 24            | 88,783            |
| hadoop      | 22            | 113,193           |
| jira        | 20            | 104,918           |
| javascript  | 20            | 97,587            |
| sharepoint  | 18            | 81,634            |

#### 💡 Insights:
- **SQL, Python, Tableau,** and **Power BI** top the list with strong demand and solid salary prospects, making them essential skills for data professionals.
- Specialized skills such as **Snowflake, Azure, AWS, Go,** and **Hadoop** command higher salaries but have relatively lower demand, indicating niche opportunities.
- A combination of foundational skills (data querying, programming, visualization) and cloud or big data technologies provides the best path for maximizing job opportunities and earning potential.
---

## ✅ Conclusion
#### 💡Overall Insights:
**1. Top Paying Data Analyst Jobs:**  
Senior-level roles like Director/Associate Director offer the highest salaries and are mostly remote or hybrid, reflecting strong demand for flexible leadership positions.

**2. Skills Required for Top Paying Jobs:**  
High-paying roles commonly require SQL, Python, and R, with cloud tools like AWS/Azure and collaboration platforms like Tableau and Git also in demand.

**3. Most In-Demand Skills:**  
SQL leads job listings, followed by Excel and Python, while Tableau and Power BI continue to be vital for data storytelling.

**4. Top Skills Based on Salary:**  
PySpark, Bitbucket, and Pandas top the salary charts, reflecting high value in big data, version control, and core data science libraries.

**5. Most Optimal Skills to Learn:**  
Combining high-demand tools like SQL, Python, and Tableau with niche technologies like Snowflake and AWS maximizes earning and career growth potential.

#### Closing Thoughts: 
This project blends data analysis with career strategy, offering insights not just into the current job market but also into how aspiring data analysts can upskill themselves for better opportunities. It was a fantastic way to apply SQL skills to a practical, career-relevant dataset while also creating value for others looking to enter or grow in the data field.

---
