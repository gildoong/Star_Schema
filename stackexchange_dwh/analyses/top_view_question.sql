SELECT
    post_id,
    view_count,
    score
FROM gold.fact_posts
ORDER BY view_count DESC
LIMIT 20