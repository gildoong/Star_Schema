SELECT
    HOUR(creation_date) AS hour,
    COUNT(*) AS question_count
FROM {{ ref('fact_posts') }}
WHERE answer_count IS NOT NULL
GROUP BY 1
ORDER BY 1
