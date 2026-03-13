SELECT DISTINCT
    DATE(creation_date) AS date_day,
    YEAR(creation_date) AS year_number,
    MONTH(creation_date) AS month_number,
    DAY(creation_date) AS day_of_month,
    HOUR(creation_date) AS hour_number
FROM {{ ref('stg_posts') }}
WHERE creation_date IS NOT NULL
