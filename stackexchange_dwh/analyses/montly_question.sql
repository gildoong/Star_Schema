SELECT
    YEAR(creation_date) AS year,
    MONTH(creation_date) AS month,
    COUNT(*) AS question_count
FROM gold.fact_posts
WHERE answer_count IS NOT NULL
GROUP BY 1,2
ORDER BY 1,2