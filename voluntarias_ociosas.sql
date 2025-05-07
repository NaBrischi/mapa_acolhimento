WITH voluntarias_ociosas AS (
    -- Seleciona voluntárias disponíveis que não têm matches
    SELECT 
        v.state AS uf,
        v.volunteer_id
    FROM 
        volunteers v
    WHERE 
        v.status = 'disponivel'
        AND NOT EXISTS (
            SELECT 1 
            FROM matches m 
            WHERE m.volunteer_id = v.volunteer_id
        )
),
total_ociosas AS (
    -- Calcula o total geral de voluntárias ociosas
    SELECT COUNT(*) AS total_geral
    FROM voluntarias_ociosas
)
SELECT 
    vo.uf,
    COUNT(vo.volunteer_id) AS total_ociosas_uf,
    ROUND(COUNT(vo.volunteer_id) * 100.0 / (SELECT total_geral FROM total_ociosas), 2) AS perc_ociosas_uf
FROM 
    voluntarias_ociosas vo
GROUP BY 
    vo.uf
ORDER BY 
    total_ociosas_uf DESC;
