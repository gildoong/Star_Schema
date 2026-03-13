SELECT
    u.user_id,
    u.display_name,
    COUNT(p.post_id) as post_count,
    SUM(p.score) as total_score
FROM {{ ref('fact_posts') }} p
JOIN {{ ref('dim_user') }} u
ON p.user_id = u.user_id
GROUP BY 1,2
ORDER BY post_count DESC