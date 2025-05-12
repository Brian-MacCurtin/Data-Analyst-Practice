-- RESEARCH QUESTION #1: What are the top paying jobs for a data analyst?

SELECT *
FROM job_postings_fact jpf
LEFT JOIN company_dim cd
    ON jpf.company_id = cd.jpf
WHERE jpf.job_title_short = 'Data Analyst'
LIMIT 100