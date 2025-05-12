-- RESEARCH QUESTION #1: What are the top paying jobs for a data analyst?


-- Top 10 remote jobs based on salary
-- @block
SELECT 
    cd.name AS company_name,
    jpf.job_title AS title,
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


-- Top 10 jobs in Philadelphia, PA based on salary
-- @block
SELECT 
    cd.name AS company_name,
    jpf.job_title AS title,
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
    jpf.job_location = 'Philadelphia, PA' AND
    jpf.salary_year_avg IS NOT NULL
ORDER BY
    jpf.salary_year_avg DESC
LIMIT 10