SELECT
    post_id,
    view_count,
    answer_count,
    answer_count / view_count AS answer_view_ratio
FROM {{ ref('fact_posts') }}
WHERE view_count > 100
ORDER BY answer_view_ratio DESC