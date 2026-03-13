SELECT
    tag_name,
    COUNT(*) as question_count
FROM {{ ref('bridge_post_tags') }}
GROUP BY 1
ORDER BY question_count DESC