SELECT
    u.user_id,
    u.display_name,
    COUNT(p.post_id) AS question_count
FROM gold.fact_posts p
JOIN gold.dim_users u
    ON p.user_id = u.user_id
WHERE p.answer_count IS NOT NULL
GROUP BY 1,2
ORDER BY question_count DESC
LIMIT 20