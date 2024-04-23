/*
Question: What are the most in-demand skills?
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings. See if there is a difference from remote jobs only.
    See if there is a change when not considering the top paying jobs.
- Why? Retrieves the top 5 skills with the highest dmand in the job market,
    providing insihgts in themost valuable jobs for job seekers.
*/

SELECT
    sk.skills,
    COUNT(sj.job_id) as demand_count
FROM job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN skills_dim sk ON sk.skill_id = sj.skill_id
WHERE
    job_title_short = 'Data Analyst'
    and job_location = 'Anywhere'
GROUP BY
    sk.skills
ORDER BY
    demand_count DESC
LIMIT 5


/*
Looking at the results of this query, there is some pattern changes here when considering all pay ranges.
SQL, Excel, Python, and Tableau remain in the top 5. However Power BI has replaced R as one of the top skills.
Excel also has taken 2nd place, surpassing Python in this ranking. R is also now missing from the top 5.

This showcases that while R is not as in demand, it can lead to a higher paid job. This does reinforce the
need for a split set of skills similar to query 2.
    - Know SQL for database management
    - Know Excel for data analysis
    - Know Python for statistical analyses.
    - Know a data visualization tool.

Based on the data, this makes up the core of a data analyst, and it will be key to have all these skills
during the analysts career.
*/