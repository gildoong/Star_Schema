WITH answers AS (
    SELECT
        parent_post_id AS question_id,
        COUNT(*) AS answer_count
    FROM my_workspace.silver.posts
    WHERE post_type = 'answer'
      AND parent_post_id IS NOT NULL
    GROUP BY 1
),

votes AS (
    SELECT
        post_id AS question_id,
        COUNT(*) AS vote_count,
        AVG(vote_type_id) AS avg_vote_type_id
    FROM my_workspace.silver.votes
    GROUP BY 1
)

SELECT
    q.post_id AS question_id,
    COALESCE(a.answer_count, 0) AS answer_count,
    COALESCE(v.vote_count, 0) AS vote_count,
    v.avg_vote_type_id,
    q.score AS question_score
FROM my_workspace.silver.posts q
LEFT JOIN answers a
    ON q.post_id = a.question_id
LEFT JOIN votes v
    ON q.post_id = v.question_id
WHERE q.post_type = 'question'
ORDER BY vote_count DESC, answer_count DESC, question_score DESC
