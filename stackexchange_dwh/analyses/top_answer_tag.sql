SELECT
    tag_name,
    COUNT(*) AS question_count
FROM gold.bridge_post_tags
GROUP BY 1
ORDER BY question_count DESC
LIMIT 20