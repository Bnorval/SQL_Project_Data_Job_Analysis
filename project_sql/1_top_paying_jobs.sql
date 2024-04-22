/*
Question: What are the top paying jobs for Data Analyst roles?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focus on job postings with specified salaries (remove NULLs)
- Why? Highlight the top paying opportunities for Data Analysts, offering insights into employment 
opportunities and potential employers.
*/

SELECT 
    j.job_id,
    j.job_title,
    c.name as company_name,
    j.job_location,
    j.job_schedule_type,
    j.salary_year_avg,
    j.job_posted_date
FROM
    job_postings_fact j
LEFT JOIN company_dim c ON j.company_id = c.company_id
WHERE 
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
