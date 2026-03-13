SELECT
    AVG(a.creation_date - q.creation_date) AS avg_response_time
FROM silver.questions q
JOIN silver.answers a
ON q.post_id = a.parent_post_id