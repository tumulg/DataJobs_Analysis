# NOT COMPLETED YET.

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

### 2️⃣ Skills Required for Top Paying Jobs

After identifying the top-paying roles, I was curious about the specific skill sets they demand. So, I used the job IDs from the top 10 jobs and linked them to the skills table through a bridge table. This allowed me to list the exact skills those high-paying positions required. It was insightful to see technologies like SQL, Python, and Tableau show up frequently — validating their relevance in high-stakes roles.

### 3️⃣ Most In-Demand Skills

Next, I shifted focus from salary to popularity. I wanted to know which skills are simply most in demand, especially for remote Data Analyst roles. By joining the job postings with the skills data and counting how often each skill appeared, I could rank them based on frequency. The outcome provided a snapshot of what the industry currently values the most, helping paint a picture of baseline expectations for job seekers.

### 4️⃣ Top Skills Based on Salary

At this point, I wanted to flip the perspective: instead of what’s most common, I asked what skills actually *pay* the most. By linking skill data with salary information and calculating the average salary per skill, I could identify which tools and platforms bring in the biggest paychecks. This was especially useful for spotting niche, specialized skills like PySpark, GCP, or Kubernetes that command high salaries even if they’re less common.

### 5️⃣ Most Optimal Skills to Learn

Finally, I brought everything together by looking for overlap between demand and compensation. I wrote a query that identified skills with both high frequency and high average salary, filtering out those that didn’t meet a minimum demand threshold. This helped me surface the most optimal skills — the ones worth investing in from both a job security and financial return standpoint. It balanced practicality with ambition, making the insights more actionable for career planning.

---

## ✅ Conclusion

This project blends data analysis with career strategy, offering insights not just into the current job market but also into how aspiring data analysts can upskill themselves for better opportunities. It was a fantastic way to apply SQL skills to a practical, career-relevant dataset while also creating value for others looking to enter or grow in the data field.

---
