SELECT
    user_id,
    display_name,
    reputation,
    location,
    creation_date
FROM {{ ref('stg_users') }}