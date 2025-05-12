-- RESEARCH QUESTION #3: What are the most in-demand skills for a data analyst?

-- @block

WITH data_analyst_jobs AS (
    SELECT * 
    FROM
        job_postings_fact 
    WHERE
        job_title_short = 'Data Analyst'
)

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
    