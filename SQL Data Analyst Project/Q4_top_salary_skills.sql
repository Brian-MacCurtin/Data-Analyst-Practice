-- RESEARCH QUESTION #4: What are the top skills based on salary for a data analyst?

-- @block
WITH data_analyst_jobs AS (
    SELECT *, 
    CASE 
        WHEN salary_year_avg < 50000 Then '<50k'
        WHEN salary_year_avg >= 50000 AND salary_year_avg < 65000 Then '50-65k'
        WHEN salary_year_avg >= 65000 AND salary_year_avg < 80000 Then '65-80k'
        WHEN salary_year_avg >= 80000 AND salary_year_avg < 95000 Then '80-95k'
        WHEN salary_year_avg >= 95000 AND salary_year_avg < 120000 Then '95-120k'
        WHEN salary_year_avg >= 120000 AND salary_year_avg < 135000 Then '120-135k'
        WHEN salary_year_avg >= 135000 AND salary_year_avg < 150000 Then '135-150k'
        WHEN salary_year_avg >= 150000 Then '>150k'
    END AS salary_range
    FROM
        job_postings_fact 
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT Null
)




SELECT 
    daj.salary_range 
FROM (
    SELECT 
        count(*) AS num_jobs,
        sd.skills
    FROM
        data_analyst_jobs daj
    LEFT JOIN skills_job_dim sjd
        ON sjd.job_id = daj.job_id
    LEFT JOIN skills_dim sd
        ON sd.skill_id = sjd.skill_id
    WHERE 
        sd.skills IS NOT Null
    GROUP BY
        sd.skills
    ORDER BY 
        num_jobs DESC
    LIMIT 10
)




-- previous code
-- @block
WITH data_analyst_jobs AS (
    SELECT *, 
    CASE 
        WHEN salary_year_avg < 50000 Then '<50k'
        WHEN salary_year_avg >= 50000 AND salary_year_avg < 65000 Then '50-65k'
        WHEN salary_year_avg >= 65000 AND salary_year_avg < 80000 Then '65-80k'
        WHEN salary_year_avg >= 80000 AND salary_year_avg < 95000 Then '80-95k'
        WHEN salary_year_avg >= 95000 AND salary_year_avg < 120000 Then '95-120k'
        WHEN salary_year_avg >= 120000 AND salary_year_avg < 135000 Then '120-135k'
        WHEN salary_year_avg >= 135000 AND salary_year_avg < 150000 Then '135-150k'
        WHEN salary_year_avg >= 150000 Then '>150k'
    END AS salary_range
    FROM
        job_postings_fact 
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT Null
)


SELECT 
    daj.salary_range,
    count(*) AS num_jobs,
    sd.skills
FROM
    data_analyst_jobs daj
LEFT JOIN skills_job_dim sjd
    ON sjd.job_id = daj.job_id
LEFT JOIN skills_dim sd
    ON sd.skill_id = sjd.skill_id
WHERE 
    sd.skills IS NOT Null
GROUP BY
    sd.skills, daj.salary_range
ORDER BY 
    daj.salary_range DESC


-- What is the average salary associated with the top data analyst skills required
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


-- What are the highest paying data analyst skills
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
