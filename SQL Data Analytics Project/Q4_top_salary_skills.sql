-- RESEARCH QUESTION #4: What are the top skills based on salary for a data analyst?


-- Highest paying data analyst skills
--@block
SELECT 
    sd.skills,
    ROUND(AVG(jpf.salary_year_avg), 2) AS average_salary
FROM
    job_postings_fact jpf
INNER JOIN skills_job_dim sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_title_short = 'Data Analyst' AND
    jpf.salary_year_avg IS NOT Null
GROUP BY
    sd.skills
ORDER BY average_salary DESC
LIMIT 25



-- Top data analyst skills required for different salary ranges
-- @block
WITH job_salary_ranges AS (
    SELECT 
        job_id,
        CASE 
            WHEN salary_year_avg < 50000 THEN '<50k'
            WHEN salary_year_avg < 65000 THEN '50-65k'
            WHEN salary_year_avg < 80000 THEN '65-80k'
            WHEN salary_year_avg < 95000 THEN '80-95k'
            WHEN salary_year_avg < 120000 THEN '95-120k'
            WHEN salary_year_avg < 135000 THEN '120-135k'
            WHEN salary_year_avg < 150000 THEN '135-150k'
            ELSE '>150k'
        END AS salary_range
    FROM 
        job_postings_fact
    WHERE 
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
),
skill_counts AS (
    SELECT 
        jsr.salary_range,
        sd.skills,
        COUNT(*) AS skill_count,
        ROW_NUMBER() OVER (PARTITION BY jsr.salary_range ORDER BY COUNT(*) DESC) AS rank
    FROM 
        job_salary_ranges jsr
    JOIN skills_job_dim sjd 
            ON jsr.job_id = sjd.job_id
    JOIN skills_dim sd 
        ON sjd.skill_id = sd.skill_id
    GROUP BY 
        jsr.salary_range, sd.skills
)

SELECT 
    salary_range,
    skills,
    skill_count, 
    rank
FROM 
    skill_counts
WHERE 
    rank <= 10
ORDER BY 
    salary_range, rank



-- The average salary associated with the most demanded data analyst skills 
-- @block
WITH top_skills AS (
    SELECT 
        count(*) AS num_jobs,
        sd.skills,
        ROUND(AVG(jpf.salary_year_avg), 2) AS average_salary
    FROM
        job_postings_fact jpf
    INNER JOIN skills_job_dim sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim sd
        ON sjd.skill_id = sd.skill_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' AND
        jpf.salary_year_avg IS NOT Null
    GROUP BY
        sd.skills
    ORDER BY num_jobs DESC
    LIMIT 25 
)

SELECT
    ts.skills,
    ts.average_salary
FROM
    top_skills ts