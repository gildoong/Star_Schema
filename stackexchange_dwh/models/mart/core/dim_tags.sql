SELECT
    tag_name,
    tag_count
FROM {{ ref('stg_tags') }}