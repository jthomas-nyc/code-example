
  --The first CTE (for_unnesting) flattens the data by ANZSRC Fields of Research classification level 2, a nested array within the Grants table

  WITH for2_unnesting AS (
SELECT
grants.funding_usd,
for2.name AS for_name,
for2.code AS for_code,
CASE WHEN grants.start_year BETWEEN 2015 AND 2019 THEN 'Previous_Period' WHEN
grants.start_year BETWEEN 2020 AND 2024 THEN 'Current_Period' END AS period --  Group grants into two comparable 5-year periods.
FROM `dimensions-ai.data_analysis.grants` grants
CROSS JOIN UNNEST(grants.category_for.second_level.full) for2 --Unnest FOR2 categories to analyze funding by research field
WHERE grants.funding_usd> 0 AND for2.code IS NOT NULL ),

-- The next CTE aggregates funding by FOR2 and period.
aggregations AS (
SELECT for_code,
For_name,
SUM(CASE WHEN period = 'Previous_Period' THEN funding_usd ELSE 0 END) AS
funding_prev_5yr,
SUM(CASE WHEN period = 'Current_Period' THEN funding_usd ELSE 0 END)
AS funding_curr_5yr
FROM for2_unnesting WHERE period IS NOT NULL GROUP BY 1, 2 )

--The final query pulls the aggregated data from the previous CTE, but with an additional column
calculating the % change.
SELECT
for_code, for_name, funding_prev_5yr, funding_curr_5yr,
SAFE_DIVIDE((funding_curr_5yr - funding_prev_5yr), funding_prev_5yr) * 100 AS 
period_growth_pct --  Avoid division by zero for infrequent or newly created FORs
FROM aggregations
WHERE funding_prev_5yr > 0
ORDER BY period_growth_pct DESC; -- Ordered to highlight fastest-growing research fields

