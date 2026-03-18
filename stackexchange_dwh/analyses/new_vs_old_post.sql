SELECT
CASE
WHEN reputation < 100 THEN 'new_user'
WHEN reputation < 1000 THEN 'mid_user'
ELSE 'high_reputation'
END AS user_group,
COUNT(p.post_id) AS post_count,
AVG(p.score) AS avg_score
FROM gold.fact_posts p
JOIN gold.dim_user u
ON p.user_id = u.user_id
GROUP BY 1
ORDER BY post_count DESC
