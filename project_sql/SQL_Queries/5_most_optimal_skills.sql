/*
Question: What are the the most optimal skills to learn as a Data Analyst?
- We will be defining optimal skills as being in High Demand AND High Paying
- Focus on remote roles with specified salaries.
- Why? This query will target skills that with both provide job security (high demand) and financial
    benefits (high salaries), showcasing a potentially optimal route for becoming or advancing as
    a data analyst.
*/


WITH skills_demand AS (
    SELECT
        sk.skill_id,
        sk.skills,
        COUNT(sj.job_id) as demand_count
    FROM job_postings_fact j
    INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim sk ON sk.skill_id = sj.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        and job_location = 'Anywhere'
        and salary_year_avg IS NOT NULL
    GROUP BY
        sk.skill_id, sk.skills
),

average_salary AS (
    SELECT
        sk.skill_id,
        sk.skills,
        ROUND(AVG(salary_year_avg), 0) as average_salary
    FROM job_postings_fact j
    INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
    INNER JOIN skills_dim sk ON sk.skill_id = sj.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        and job_location = 'Anywhere'
        and salary_year_avg IS NOT NULL
    GROUP BY
        sk.skill_id, sk.skills
)

SELECT
    sd.skill_id,
    sd.skills,
    demand_count,
    average_salary
FROM
    skills_demand sd
INNER JOIN average_salary asal ON sd.skill_id = asal.skill_id
WHERE 
    demand_count > 10
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT 25


/*
After analyzing the results of this query in Excel, there is no clear winner in the most optimal skills.
However I am able to identify some helpful insights and a list of skills that generally meet our criteria.

1. SQL & Excel: This two skills were by far the highest demanded skills. However they were also some
    of the lowest paying jobs on average, with SQL being 17th out of 25, and Excel being 22nd. However,
    due to the sheer demand and likelihood that you are going to use these skills in any kind of analysis
    or coding scenario, I still find them necessary to learn.

2. The Salary Winners | Demand Winners: Python, Tableau, and R. These skills were 3rd, 4th, and 5th
    in demand respectively, and were also 9th, 11th, and 10th in highest pay. These skills have a very
    high demand while also having a respectable level of pay. This did showcase an interesting note 
    about the data, the salaries on average are very close to each other. Tableau at 11th place in Salary
    had an average salary of $99,288. While SQL at 17th place in salary had an average of $97,237.
    There is only a $2,000 difference in salary but was ranked 6 places apart, showing that many of these
    skills are going to pay well and close to each other outside of the very top and bottom.

3. The Salary Winners | Demand Losers: GO, Hadoop, and JIRA. These skills were some of the highest paying
    jobs out there, but the demand is not quite there. This leads these skills to be specialized and 
    only sought after by a smaller portion of companies. However this could allow an analyst to carve
    a niche in their skillset and separate themselves from the rest.
*/
