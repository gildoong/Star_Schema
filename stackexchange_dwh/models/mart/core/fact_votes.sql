SELECT
    vote_id,
    post_id,
    vote_type_id,
    creation_date
FROM {{ ref('stg_votes') }}