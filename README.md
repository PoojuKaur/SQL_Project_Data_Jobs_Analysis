# 📊 Data Analyst Job Market Analysis (SQL Project)

## 📌 Introduction

Dive into the data job market! This project focuses on **data analyst roles**, exploring:

* 💰 Top-paying jobs
* 🔥 In-demand skills
* 📈 Skills that lead to higher salaries


---

## ❓ Questions Answered

* What are the top-paying data analyst jobs?
* What skills are required for these jobs?
* What skills are most in demand?
* Which skills are associated with higher salaries?
* What are the most optimal skills to learn?

---

## 🛠️ Tools Used

* **SQL** – main tool for analysis
* **PostgreSQL** – database system
* **Visual Studio Code** – writing and running queries
* **Git & GitHub** – version control and project sharing

---

## 📂 Project Structure

To view quries open sql_analysis folder
---

## 📊 The Analysis

### 1. 💰 Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered remote jobs with salary data.

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim 
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

📊 **Insights:**

* Salaries range from **$184,000 to $650,000**
* High-paying roles exist across multiple companies
* Job titles vary from Analyst to Director level

---

### 2. 🧠 Skills for Top Paying Jobs

This query shows which skills are required for top-paying roles.

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere' 
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim 
    ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

📊 **Insights:**

* SQL appears most frequently
* Python and Tableau are also highly required
* Other useful skills: R, Excel, Snowflake

---

### 3. 🔥 Most In-Demand Skills

This query finds the most requested skills in job postings.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;
```

📊 **Insights:**

* SQL and Excel are the most important basic skills
* Python is highly demanded
* Tableau and Power BI are key for visualization

---

### 4. 💵 Skills Based on Salary

This query shows which skills are linked to higher salaries.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE 
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 10;
```

📊 **Insights:**

* Big data tools (PySpark, Couchbase) pay more
* Machine learning tools increase salary
* Cloud tools also offer high pay

---

### 5. 🎯 Most Optimal Skills to Learn

This combines demand and salary to find the best skills.

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE 
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 10;
```

📊 **Insights:**

* Best skills include:

  * SQL
  * Python
  * Snowflake
  * AWS / Azure
  * BigQuery
* These skills have both **high demand and high salary**

---

## 📚 What I Learned

* Writing complex SQL queries
* Using JOIN, GROUP BY, and aggregate functions
* Turning data into meaningful insights
* Understanding real-world job market trends

---

## ✅ Conclusion

* Data analyst roles offer **very high salary potential**
* **SQL is the most important skill**
* Combining SQL with Python and visualization tools is powerful
* Cloud and big data skills increase earning potential

---

## 🚀 Final Thoughts

This project helped me improve my SQL skills and better understand the job market.


## ⭐ Author

**Poojinder Kaur**
BSc Computer Science Student | Aspiring Data Analyst

