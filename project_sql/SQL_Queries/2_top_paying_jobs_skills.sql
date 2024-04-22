/*
Question: What are the skills required for Data Analyst roles?
- Identify the top 10 highest-paying Data Analyst jobs from Query 1 - 1_top_paying_jobs.sql
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certian skills,
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_10_jobs AS (

    SELECT 
        j.job_id,
        j.job_title,
        c.name as company_name,
        j.salary_year_avg
    FROM
        job_postings_fact j
    LEFT JOIN company_dim c ON j.company_id = c.company_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    t.*,
    sk.skills
FROM top_10_jobs t
INNER JOIN skills_job_dim sj ON t.job_id = sj.job_id
INNER JOIN skills_dim sk ON sk.skill_id = sj.skill_id
ORDER BY
    salary_year_avg DESC


/*
After breaking down and analysing the results, a few key skills stand out. SQL had the highest freuquency
being required in 80% of the job postings. Python came in 2nd with 70% of the job postings, and Tableau
came in 3rd with 60% of the job postings. Other skills such as R and Excel also have a good number of 
listings, however the top three skills are clearly dominant over the rest.

This showcases a clear set of skills to focus on
    - SQL for database knowledge and querying
    - Python for additional querying and statistical analyses
    - Tableau for visualizng this data
/*