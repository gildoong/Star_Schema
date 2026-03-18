WITH question_engagement AS (
    SELECT
        post_id AS question_id,
        view_count,
        answer_count,
        comment_count,
        (COALESCE(answer_count, 0) + COALESCE(comment_count, 0)) * 1.0
            / NULLIF(view_count, 0) AS engagement_ratio
    FROM gold.fact_posts
    WHERE answer_count IS NOT NULL
)

SELECT
    question_id,
    view_count,
    answer_count,
    comment_count,
    engagement_ratio,
    RANK() OVER (ORDER BY engagement_ratio DESC) AS engagement_rank
FROM question_engagement
ORDER BY engagement_rank, view_count DESC
