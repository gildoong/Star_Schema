SELECT
    t.tag_name,
    COUNT(*) AS question_count,
    SUM(CASE WHEN q.accepted_answer_id IS NOT NULL THEN 1 ELSE 0 END) AS accepted_count,
    SUM(CASE WHEN q.accepted_answer_id IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*) AS accepted_ratio
FROM silver.questions q
JOIN silver.post_tags t
ON q.post_id = t.post_id
GROUP BY 1
HAVING question_count > 100
ORDER BY accepted_ratio DESC
LIMIT 20