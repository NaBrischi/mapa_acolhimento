WITH dados_anuais AS (
    SELECT
        YEAR(created_at) AS ano,
        COUNT(match_id) AS total_matches
    FROM matches
    GROUP BY YEAR(created_at)
)
SELECT 
    da.ano,
    da.total_matches,
    SUM(da.total_matches) OVER (ORDER BY da.ano) AS acumulado,
    ROUND(SUM(da.total_matches) OVER (ORDER BY da.ano) * 100.0 / 10000, 2) AS percentual_da_meta
FROM dados_anuais da
ORDER BY da.ano;