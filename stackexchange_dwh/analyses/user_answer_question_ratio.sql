WITH questions AS (
    SELECT
        user_id,
        COUNT(*) AS question_count
    FROM gold.fact_posts
    WHERE answer_count IS NOT NULL
    GROUP BY 1
),

answers AS (
    SELECT
        user_id,
        COUNT(*) AS answer_count
    FROM gold.fact_posts
    WHERE answer_count IS NULL
    GROUP BY 1
)

SELECT
    q.user_id,
    question_count,
    COALESCE(answer_count,0) AS answer_count,
    COALESCE(answer_count, 0) * 1.0 / NULLIF(question_count, 0) AS answer_ratio
FROM questions q
LEFT JOIN answers a
ON q.user_id = a.user_id
ORDER BY answer_ratio DESC
LIMIT 20
