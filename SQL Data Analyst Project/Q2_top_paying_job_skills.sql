-- RESEARCH QUESTION #2: What are the skills required for the top paying data analyst jobs


-- FInding all skills associated with the top 10 remote paying jobs
-- @block
WITH top_10_jobs AS (
    SELECT 
        cd.name AS company_name,
        jpf.job_title AS title,
        jpf.job_id,
        jpf.job_location AS location,
        jpf.salary_year_avg AS yearly_salary,
        jpf.job_schedule_type AS contract_type,
        jpf.job_posted_date::DATE AS date
    FROM 
        job_postings_fact jpf
    LEFT JOIN company_dim cd
        ON jpf.company_id = cd.company_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' AND 
        jpf.job_location = 'Anywhere' AND
        jpf.salary_year_avg IS NOT NULL
    ORDER BY
        jpf.salary_year_avg DESC
    LIMIT 10
)

SELECT *
FROM 
    top_10_jobs t10
LEFT JOIN skills_job_dim sjd
    ON t10.job_id = sjd.job_id
LEFT JOIN skills_dim sd 
    ON sd.skill_id = sjd.skill_id



-- Most wanted skills for top 10 paying remote jobs
-- @block
WITH top_10_jobs AS (
    SELECT 
        cd.name AS company_name,
        jpf.job_title AS title,
        jpf.job_id,
        jpf.job_location AS location,
        jpf.salary_year_avg AS yearly_salary,
        jpf.job_schedule_type AS contract_type,
        jpf.job_posted_date::DATE AS date
    FROM 
        job_postings_fact jpf
    LEFT JOIN company_dim cd
        ON jpf.company_id = cd.company_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' AND 
        jpf.job_location = 'Anywhere' AND
        jpf.salary_year_avg IS NOT NULL
    ORDER BY
        jpf.salary_year_avg DESC
    LIMIT 10
)

SELECT 
    count(*) AS num_jobs,
    sd.skills
FROM 
    top_10_jobs t10
LEFT JOIN skills_job_dim sjd
    ON t10.job_id = sjd.job_id
LEFT JOIN skills_dim sd 
    ON sd.skill_id = sjd.skill_id
GROUP BY
    sd.skills
ORDER BY
    num_jobs DESC