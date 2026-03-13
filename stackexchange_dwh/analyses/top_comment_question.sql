SELECT
    post_id,
    comment_count
FROM gold.fact_posts
ORDER BY comment_count DESC
LIMIT 20