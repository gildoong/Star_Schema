WITH answer_time AS (

SELECT
    q.post_id,
    t.tag_name,
    MIN(a.creation_date - q.creation_date) AS answer_time
FROM {{ ref('stg_posts') }} q
JOIN {{ ref('stg_posts') }} a
ON q.post_id = a.parent_post_id
JOIN {{ ref('stg_post_tags') }} t
ON q.post_id = t.post_id
WHERE q.post_type = 'question'
AND a.post_type = 'answer'
GROUP BY 1,2

)

SELECT
    tag_name,
    AVG(answer_time) AS avg_answer_time
FROM answer_time
GROUP BY 1
ORDER BY avg_answer_time