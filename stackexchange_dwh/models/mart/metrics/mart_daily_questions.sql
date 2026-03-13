SELECT
    DATE(creation_date) as date,
    COUNT(*) as question_count
FROM {{ ref('fact_posts') }}
WHERE answer_count IS NOT NULL
GROUP BY 1