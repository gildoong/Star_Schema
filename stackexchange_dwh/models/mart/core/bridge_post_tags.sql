SELECT
    post_id,
    tag_name
FROM {{ ref('stg_post_tags') }}