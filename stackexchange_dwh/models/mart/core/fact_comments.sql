SELECT
    comment_id,
    post_id,
    user_id,
    creation_date,
    score
FROM {{ ref('stg_comments') }}