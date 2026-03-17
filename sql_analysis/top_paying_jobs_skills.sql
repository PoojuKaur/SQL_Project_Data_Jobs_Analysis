/*
Question: What skills are required for the top-paying data analyst jobs?
- ⁠Use the top 10 highest-paying Data Analyst jobs from first query
- ⁠Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills,
helping job seekers understand which skill to develope that align with top salaries
*/

 WITH top_paying_jobs AS (
    SELECT
        jp.job_id,
        jp.Job_title,  
        jp.salary_year_avg, 
        jp.job_posted_date, 
        c.name AS company_name
    FROM 
        job_postings_fact jp
    LEFT JOIN company_dim c ON jp.company_id = c.company_id
    WHERE
        jp.job_title_short ILIKE 'Data Analyst'
        AND jp.salary_year_avg IS NOT NULL
    ORDER BY
        jp.salary_year_avg DESC
    LIMIT 10
)

SELECT
    t.job_id,
    t.Job_title,
    t.salary_year_avg,
    t.job_posted_date,
    t.company_name,
    s.skills
FROM 
    top_paying_jobs t
LEFT JOIN skills_job_dim sj ON t.job_id = sj.job_id
LEFT JOIN skills_dim s ON sj.skill_id = s.skill_id
ORDER BY
    t.salary_year_avg DESC;