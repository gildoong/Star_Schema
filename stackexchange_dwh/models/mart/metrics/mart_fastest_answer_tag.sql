WITH first_answers AS (

    SELECT
        q.post_id,
        t.tag_name,
        MIN(TIMESTAMPDIFF(SECOND, q.creation_date, a.creation_date)) AS response_seconds
    FROM {{ ref('stg_posts') }} q
    JOIN {{ ref('stg_posts') }} a
        ON q.post_id = a.parent_post_id
    JOIN {{ ref('stg_post_tags') }} t
        ON q.post_id = t.post_id
    WHERE q.post_type = 'question'
      AND a.post_type = 'answer'
    GROUP BY 1, 2

)

SELECT
    tag_name,
    AVG(response_seconds) AS avg_response_time
FROM first_answers
GROUP BY 1
ORDER BY avg_response_time
