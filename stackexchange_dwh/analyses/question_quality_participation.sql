WITH votes AS (
    SELECT
        post_id AS question_id,
        COUNT(*) AS vote_count,
        AVG(vote_type_id) AS avg_vote_type_id
    FROM gold.fact_votes
    GROUP BY 1
)

SELECT
    q.post_id AS question_id,
    COALESCE(q.answer_count, 0) AS answer_count,
    COALESCE(v.vote_count, 0) AS vote_count,
    v.avg_vote_type_id,
    q.score AS question_score
FROM gold.fact_posts q
LEFT JOIN votes v
    ON q.post_id = v.question_id
WHERE q.answer_count IS NOT NULL
ORDER BY vote_count DESC, answer_count DESC, question_score DESC
