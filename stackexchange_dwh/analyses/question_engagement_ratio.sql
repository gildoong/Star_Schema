WITH answers AS (
    SELECT
        parent_post_id AS question_id,
        COUNT(*) AS answer_count
    FROM my_workspace.silver.posts
    WHERE post_type = 'answer'
      AND parent_post_id IS NOT NULL
    GROUP BY 1
),

comments AS (
    SELECT
        post_id AS question_id,
        COUNT(*) AS comment_count
    FROM my_workspace.silver.comments
    GROUP BY 1
),

question_engagement AS (
    SELECT
        q.post_id AS question_id,
        q.view_count,
        COALESCE(a.answer_count, 0) AS answer_count,
        COALESCE(c.comment_count, 0) AS comment_count,
        (COALESCE(a.answer_count, 0) + COALESCE(c.comment_count, 0)) * 1.0
            / NULLIF(q.view_count, 0) AS engagement_ratio
    FROM my_workspace.silver.posts q
    LEFT JOIN answers a
        ON q.post_id = a.question_id
    LEFT JOIN comments c
        ON q.post_id = c.question_id
    WHERE q.post_type = 'question'
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
