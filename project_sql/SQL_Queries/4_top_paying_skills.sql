/*
Question: What are the best paying skills? What are the average salaries for each skills?
- Look at the average salary associated with each skill for Data Analyst positions
- Focus on roles with specified salaries.
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
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
    sk.skills
ORDER BY
    average_salary DESC
LIMIT 25

/*
Based on these results, we can identify a few key points:
1. Emphasis on Big Data Handling: Big database tools such as PySpark & Databricks showcases a demand
    for tools that can manage large amounts of a variety of data.

2. Integration of Software Developement: Many collaborative tools are found here such as Jenkins and
    Gitlab. These tools are found in a variety of industries such as software development or website
    development. Being able to analyze data and collaborate with others is a big selling point.

3. Cloud computing and Machine Learning: Cloud Platforms such as Kubernetes and machine larning libraries
    like TensorFlow show the importance of newer technologies and AI solutions in the workforce.
*/