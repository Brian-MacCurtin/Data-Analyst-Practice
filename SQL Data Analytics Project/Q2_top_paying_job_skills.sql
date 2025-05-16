-- RESEARCH QUESTION #2: What are the skills required for the top paying data analyst jobs?


-- All skills associated with the top 10 highest paying remote data analyst jobs
-- @block
WITH top_10_jobs AS (
    SELECT 
        cd.name AS company_name,
        jpf.job_title AS title,
        jpf.job_id,
        jpf.salary_year_avg AS yearly_salary
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
    t10.*,
    sd.skills
FROM 
    top_10_jobs t10
INNER JOIN skills_job_dim sjd
    ON t10.job_id = sjd.job_id
INNER JOIN skills_dim sd 
    ON sd.skill_id = sjd.skill_id



-- Most frequently required skills for the top 10 paying remote data analyst jobs
-- @block
WITH top_10_jobs AS (
    SELECT 
        cd.name AS company_name,
        jpf.job_title AS title,
        jpf.job_id,
        jpf.salary_year_avg AS yearly_salary
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
    sd.skills AS skill,
    count(*) AS num_jobs
FROM 
    top_10_jobs t10
INNER JOIN skills_job_dim sjd
    ON t10.job_id = sjd.job_id
INNER JOIN skills_dim sd 
    ON sd.skill_id = sjd.skill_id
GROUP BY
    sd.skills
ORDER BY
    num_jobs DESC



-- All skills associated with the top 10 highest paying data analyst jobs in Philadelphia, PA
-- @block
WITH top_10_jobs AS (
    SELECT *
    FROM (
        SELECT DISTINCT ON (cd.name)
            cd.name AS company_name,
            jpf.job_title AS title,
            jpf.job_id,
            jpf.salary_year_avg AS yearly_salary
        FROM 
            job_postings_fact jpf
        LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
        WHERE 
            jpf.job_title_short = 'Data Analyst' AND 
            jpf.job_location = 'Philadelphia, PA' AND
            jpf.salary_year_avg IS NOT NULL
        ORDER BY 
            cd.name, jpf.salary_year_avg DESC
    ) sub
    ORDER BY yearly_salary DESC
    LIMIT 10
)

SELECT 
    t10.*,
    sd.skills
FROM 
    top_10_jobs t10
INNER JOIN skills_job_dim sjd
    ON t10.job_id = sjd.job_id
INNER JOIN skills_dim sd 
    ON sd.skill_id = sjd.skill_id



-- Most frequently required skills for the top 10 paying data analyst jobs in Philadelphia, PA
-- @block
WITH top_10_jobs AS (
    SELECT *
    FROM (
        SELECT DISTINCT ON (cd.name)
            jpf.job_id,
            cd.name AS company_name,
            jpf.job_title AS title,
            jpf.salary_year_avg AS yearly_salary
        FROM 
            job_postings_fact jpf
        LEFT JOIN company_dim cd ON jpf.company_id = cd.company_id
        WHERE 
            jpf.job_title_short = 'Data Analyst' AND 
            jpf.job_location = 'Philadelphia, PA' AND
            jpf.salary_year_avg IS NOT NULL
        ORDER BY 
            cd.name, jpf.salary_year_avg DESC
    ) sub
    ORDER BY yearly_salary DESC
    LIMIT 10
)

SELECT 
    sd.skills AS skill,
    count(*) AS num_jobs
FROM 
    top_10_jobs t10
INNER JOIN skills_job_dim sjd
    ON t10.job_id = sjd.job_id
INNER JOIN skills_dim sd 
    ON sd.skill_id = sjd.skill_id
GROUP BY
    sd.skills
ORDER BY
    num_jobs DESC
