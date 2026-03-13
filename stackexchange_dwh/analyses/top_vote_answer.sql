SELECT
    post_id,
    score
FROM silver.answers
ORDER BY score DESC
LIMIT 20