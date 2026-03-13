SELECT
    post_id,
    user_id,
    creation_date,
    score,
    view_count,
    answer_count,
    comment_count
FROM {{ ref('stg_posts') }}