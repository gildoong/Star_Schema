WITH questions AS (
SELECT user_id, COUNT(*) AS question_count
FROM silver.questions
GROUP BY 1
),

answers AS (
SELECT user_id, COUNT(*) AS answer_count
FROM silver.answers
GROUP BY 1
)

SELECT
    q.user_id,
    question_count,
    COALESCE(answer_count,0) AS answer_count,
    answer_count / question_count AS answer_ratio
FROM questions q
LEFT JOIN answers a
ON q.user_id = a.user_id
ORDER BY answer_ratio DESC
LIMIT 20