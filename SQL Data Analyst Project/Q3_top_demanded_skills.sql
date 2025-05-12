-- RESEARCH QUESTION #3: What are the most in-demand skills for a data analyst?

-- @block
SELECT 
    count(*) AS num_jobs,
    sd.skills
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
LIMIT 25
    