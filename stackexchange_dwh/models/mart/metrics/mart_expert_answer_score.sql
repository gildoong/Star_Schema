SELECT
    AVG(a.score) AS avg_answer_score
FROM {{ ref('stg_posts') }} a
JOIN {{ ref('dim_user') }} u
ON a.user_id = u.user_id
WHERE a.post_type = 'answer'
AND u.reputation > 1000