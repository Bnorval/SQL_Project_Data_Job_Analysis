# Introduction
The goal of this project is to understand the Data Analyst job market. Specifically, looking at what are the top-paying jobs, in-demand skills, and where high demand meets high salary. In addition, I focused mostly on remote roles as that is the sector I am invested in.

Interested in the queries themselves? You can find them here: [SQL Qeueries Project Folder](https://github.com/Bnorval/SQL_Project_Data_Job_Analysis/tree/main/project_sql/SQL_Queries)
# Background
With a strong desire to learn more about the data analyst industry and job market, this project was made to streamline what skills are valuable. This is broken down into top-paid skills, in-demand skills, and both if applicable. This allows me and other users to streamline the learning process and narrow the scope for advancing in their Data Analyst career.

The data is provided by [Luke Barousse's SQL for Data Analytics Course](https://www.lukebarousse.com/sql). Luke is a talented Data Analyst who has put together a tool to gather data centered around a multitude of data based jobs. The CSV data files used for this analysis can be found on his website.

### The questions I wanted to answer through my SQL queries:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools
For my insights on the data analyst job market, I utilized multiple key tools:
- **SQL**: The main basis of my analysis utilized SQL to query from the database and highlight key information to answer my questions.
- **PostgreSQL**: The chosen database management system.
- **Visual Studio Code**: My bread and butter for writing and executing SQL queries.
- **Git & GitHub**: Essential for documentation and ease of sharing for both my analysis and the queries that went into them.
# The Analysis
Each query for this project aimed at gaining insight on specific aspects of the data analyst job market. This is how I took on each question.

### 1. Top Paying Data Analyst Jobs
To identify the highest paying roles, I filtered down based on average salary. It is also filtered to remote jobs since that is my area of interest. This will narrow it down to the top 10 jobs utilizng the LIMIT option.

```sql
SELECT 
    j.job_id,
    j.job_title,
    c.name AS company_name,
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
```
<br>

#### Results:
| Title                                    | Company                                  | Salary     |
|------------------------------------------|------------------------------------------|------------|
| Data Analyst                             | Mantys                                   | $650,000   |
| Director of Analytics                    | Meta                                     | $336,500   |
| Associate Director- Data Insights        | AT&T                                     | $255,830   |
| Data Analyst, Marketing                  | Pinterest Job Advertisements             | $232,423   |
| Data Analyst (Hybrid/Remote)             | Uclahealthcareers                        | $217,000   |
| Principal Data Analyst (Remote)          | SmartAsset                               | $205,000   |
| Director, Data Analyst - HYBRID          | Inclusively                              | $189,309   |
| Principal Data Analyst, AV Performance Analysis | Motional                          | $189,000   |
| Principal Data Analyst                   | SmartAsset                               | $186,000   |
| ERM Data Analyst                         | Get It Recruit - Information Technology | $184,000   |

*Table showcasing the results of the top 10 data analyst roles*
#### Learnings:
- **Salary Range:** Filtering down to only the top 10, there is a large salary gap from the highest to the lowest paid. The top caps out at $650,000 and the lowest goes all the way down to $184,000 - a nearly $400,000 pay gap. This indicates a significant salary potential in the field.
- **Job Titles:** There is a couple different job titles among the top paying roles. Based on the data, you will either need to be a head analyst on the team, or become a director of the team to acquire a high salary.
- **Employers:** The employers for these roles are mostly made up of tech companies, showing that they are the leaders of this industry. Also among the employers is two healthcare companies indicating another strong option for data analyst roles.

### 2. Skills for Top Paying Jobs
Now that we have identified what are the top paying roles, we need to break it down what skills are being required for these roles. To do this, I joined the job postings with the skill data which provides the valuable insights we need.

```sql
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
```

After breaking down and analysing the results, a few key skills stand out. SQL had the highest freuquency
being required in 80% of the job postings. Python came in 2nd with 70% of the job postings, and Tableau
came in 3rd with 60% of the job postings. Other skills such as R and Excel also have a good number of 
listings, however the top three skills are clearly dominant over the rest.

This showcases a clear set of skills to focus on:
- SQL for database knowledge and querying
- Python for additional querying and statistical analyses
- Tableau for visualizng this data

![Top Paying Skills](project_sql/assets/Top_Paying_Skills.png)

*Bar graph visualizing the count of skills for the top 10 paying jobs for Data Analysts. This was narrowed down to at least 3 job postings per skill for visual clarity.*

### 3. In-Demand Skills for Data Analysts
This query helped identify the top skills being asked for remote data analysts. This time, its across all job postings to get a better understanding of the industry as a whole.

```sql
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
```
#### Results
| Skills    | Demand Count |
|-----------|--------------|
| SQL       | 7,291         |
| Excel     | 4,611         |
| Python    | 4,330         |
| Tableau   | 3,745         |
| Power BI  | 2,609         |

*Table showcasing the results of the top 5 skills query.*
<br>


Looking at the results of this query, there is some pattern changes when considering all pay ranges.
SQL, Excel, Python, and Tableau remain in the top 5. However, Power BI has replaced R as one of the top skills.
Excel also has taken 2nd place, surpassing Python in this ranking. R is also now missing from the top 5.
This showcases that while R is not as in demand, it can lead to a higher paying job. The key takeaway is that there is a need for a split set of skills:
- SQL for database management
- Excel for data analysis
- Python for statistical analyses.
- Tableau or Power BI as a data visualization tool.

Based on the data, this list makes up the core of a data analyst. It will be important to have all these skills
for an analysts career.

### 4. Skills Based on Salary
With this query, we are going to find out what is the average salary associated with each skill to see how it effects our list.

```sql
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
LIMIT 10
```
<br>

#### Results:

| Skills         | Average Salary |
|----------------|----------------|
| pyspark        | 208,172        |
| bitbucket      | 189,155        |
| watson         | 160,515        |
| couchbase      | 160,515        |
| datarobot      | 155,486        |
| gitlab         | 154,500        |
| swift          | 153,750        |
| jupyter        | 152,777        |
| pandas         | 151,821        |
| elasticsearch | 145,000        |

*Table showcasing the results of the top 10 highest paid skills.*

<br>
Based on these results, we can identify a few key points:
- **Emphasis on Big Data Handling:** Big database tools such as PySpark & Databricks showcases a demand
for tools that can manage large amounts of a variety of data.

- **Integration of Software Developement:** Many collaborative tools are found here such as Jenkins and
Gitlab. These tools are found in a variety of industries such as software development or website
development. Being able to analyze data and collaborate with others is a big selling point.

- **Cloud computing and Machine Learning:** Cloud Platforms such as Kubernetes and machine larning libraries
like TensorFlow show the importance of newer technologies and AI solutions in the workforce.

### 5. Most Optimal Skills to Learn
Utilizing all the knowledge we gained from the past queries, we need to pinpoint the most optimal skills.
We will be defining optimal skills as those that are both high in demand and high in average salary.

To best showcase this, I am going to take the results of my query, rankd the data, and visualize it in Excel. First, let's make our SQL query to get the data we need.

```sql
SELECT 
    sk.skill_id,
    sk.skills,
    COUNT(sj.job_id) AS demand_count,
    ROUND(AVG(j.salary_year_avg), 0) AS average_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim sj ON j.job_id = sj.job_id
INNER JOIN skills_dim sk ON sj.skill_id = sk.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    and job_location = 'Anywhere'
GROUP BY
    sk.skill_id
HAVING
    COUNT(sj.job_id) > 10
ORDER BY
    demand_count DESC,
    average_salary DESC
LIMIT 25;
```
<br>
Now that we have our results, lets rank the data - 1st through 25th - for both demand and salary. We can use that to get to our Total Rank. This will be one method of determining our optimal skills.

| Skills     | Demand Rank | Salary Rank | Total Rank |
|------------|-------------|-------------|------------|
| python     | 3           | 10          | 13         |
| snowflake  | 11          | 3           | 14         |
| tableau    | 4           | 12          | 16         |
| r          | 5           | 11          | 16         |
| sql        | 1           | 17          | 18         |
| looker     | 9           | 9           | 18         |
| azure      | 14          | 4           | 18         |
| oracle     | 11          | 8           | 19         |
| go         | 18          | 1           | 19         |
| sas        | 7           | 13          | 20         |
| aws        | 15          | 5           | 20         |
| power bi   | 6           | 16          | 22         |
| hadoop     | 21          | 2           | 23         |
| excel      | 2           | 22          | 24         |
| sql server | 13          | 14          | 27         |
| powerpoint | 8           | 21          | 29         |
| jira       | 22          | 7           | 29         |
| java       | 25          | 6           | 31         |
| word       | 10          | 24          | 34         |
| flow       | 17          | 18          | 35         |
| javascript | 22          | 15          | 37         |
| sheets     | 15          | 23          | 38         |
| spss       | 19          | 19          | 38         |
| vba        | 19          | 20          | 39         |
| sharepoint | 24          | 25          | 49         |

<br>

Now that we have our organized table and optimal skills by Total Rank, let's visualize it into a stacked bar chart to get easier insights.

![Most_Optimal_Skills](project_sql/assets/Most_Optimal_Skills.png)

*This visualization is a stacked bar graph breaking down the demand ranks and salary ranks among the top 25 skills. The lowest total ranked skills are the most optimal skills.*

After analyzing the results of this query in Excel, there is no clear winner in the most optimal skills.
However I am able to identify some helpful insights and a list of skills that generally meet our criteria.

- **SQL & Excel:** These two skills were by far the highest demanded skills. However they were also some
of the lowest paying jobs on average, with SQL being 17th out of 25, and Excel being 22nd. However,
due to the sheer demand and likelihood that you are going to use these skills in any kind of job, I still find them necessary to learn.

- **Snowflake:** This skill stands out as one of the clear winners in this list. It is among the highest top paid skills, and it also had a good demand rank. Learning snowflake could lead to a great job for the analyst career path.

- **The Salary Winners | Demand Winners:** *Python, Tableau, and R* - These skills have a very
high demand while also having a respectable level of pay. It also highlights an interesting data point - the salaries on average are very close to each other. Tableau at 11th place in salary
had an average salary of $99,288. While SQL at 17th place in salary had an average of $97,237.
There is only a $2,000 difference in salary but was ranked 6 places apart, showing that many of these
skills are going to pay similarly to each other outside of the very top and bottom.

- **The Salary Winners | Demand Losers:** *GO, Hadoop, and JIRA* - These skills were some of the highest paying jobs out there, but the demand is not quite there. This leads these skills to be specialized and 
only sought after by a smaller portion of companies. However, this could allow an analyst to carve
a niche in their skillset and separate themselves from the rest.

With the optimal skills being the most important part of my analysis, I want to do one more visualization. The ranked data is a great way to get a concise list of the best potentail skills, however it does not do a great job showasing the gap between the highest and lowest demand or salary. Lets place this data onto a scatter plot and see how it looks.

![Salary_Demand_Scatter](project_sql/assets/Salary_vs_Demand_Scatter.png)

With the scatter plot, it really showcases how much higher the demand is for skills like SQL, Excel, and Python. It also highlights that no skill truly has both a high demand and a high salary - some sacrifice is going to be made. This is a great resource for an analyst to figure what balance of demand and salary they are looking for in their next skill to hone.

# Conclusion
From this analysis, several patterns revealed themselves.
1. The core of the data analyst should be made up of multiple skills: Database querying (SQL), data analysis tools (R, Python, Excel), and data visualization (Tableau or Power BI).
2. Outside of these core skills, an analyst can carve out a niche for themselves by picking up a high paying but lower demanded skill such as GO or Hadoop.
3. The pay range for a data analyst can be quite varied, averaging in $90,000 - $110,000 range but being able to pay up to $650,000.
4. In order to become a very high paid analyst, you must be prepared to be the best in your role or be ready to take on the skills needed to become a director.