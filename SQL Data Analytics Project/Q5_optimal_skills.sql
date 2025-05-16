-- RESEARCH QUESTION #5: What are the optimal skills to learn for a data analyst? What skills are in demand AND high paying?


-- Jobs that are both in the top 65 most demanded skills and top 100 highest paying skills
-- @block
WITH top_skills AS (
    SELECT 
        sd.skills AS skill,
        count(*) AS num_jobs    
    FROM
        job_postings_fact jpf
    INNER JOIN skills_job_dim sjd
        ON sjd.job_id = jpf.job_id
    INNER JOIN skills_dim sd
        ON sd.skill_id = sjd.skill_id
    WHERE 
        jpf.job_title_short = 'Data Analyst' AND
        sd.skills IS NOT Null
    GROUP BY
        sd.skills
    ORDER BY
        num_jobs DESC
    LIMIT 65
),

skill_salary AS (
    SELECT 
        sd.skills AS skill,
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
    ORDER BY
        average_salary DESC
    LIMIT 65
)

SELECT
    top_skills.skill,
    top_skills.num_jobs,
    skill_salary.average_salary
FROM
    top_skills
INNER JOIN skill_salary
    ON top_skills.skill = skill_salary.skill
ORDER BY
    top_skills.num_jobs DESC