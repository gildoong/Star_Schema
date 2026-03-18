SELECT
    pt.tag_name,
    COUNT(DISTINCT p.post_id) AS question_count,
    AVG(p.view_count) AS avg_views,
    AVG(p.score) AS avg_score
FROM gold.fact_posts p
JOIN gold.bridge_post_tags pt
    ON p.post_id = pt.post_id
WHERE p.answer_count IS NOT NULL
GROUP BY pt.tag_name
ORDER BY avg_views DESC, question_count DESC
