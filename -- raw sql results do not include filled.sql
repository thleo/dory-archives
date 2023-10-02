-- raw sql results do not include filled-in values for 'cases.is_archived' and 'cases.added_quarter'


SELECT * FROM (
SELECT *, DENSE_RANK() OVER (ORDER BY z___min_rank) as z___pivot_row_rank, RANK() OVER (PARTITION BY z__pivot_col_rank ORDER BY z___min_rank) as z__pivot_col_ordering, CASE WHEN z___min_rank = z___rank THEN 1 ELSE 0 END AS z__is_highest_ranked_cell FROM (
SELECT *, MIN(z___rank) OVER (PARTITION BY "cases.added_quarter") as z___min_rank FROM (
SELECT *, RANK() OVER (ORDER BY "cases.added_quarter" ASC, z__pivot_col_rank) AS z___rank FROM (
SELECT *, DENSE_RANK() OVER (ORDER BY "cases.is_archived" NULLS LAST) AS z__pivot_col_rank FROM (
SELECT
    (CASE WHEN cases.is_archived  THEN 'Yes' ELSE 'No' END) AS "cases.is_archived",
        (TO_CHAR(DATE_TRUNC('month', DATE_TRUNC('quarter', CONVERT_TIMEZONE('UTC', 'America/New_York', cases.added_at ))), 'YYYY-MM')) AS "cases.added_quarter",
    COUNT(DISTINCT CASE WHEN (cases.case_type <> 'questions' OR cases.case_type IS NULL) THEN cases.case_id ELSE NULL END) AS "cases.count"
FROM marts_digital.person  AS accounts
LEFT JOIN marts_digital.person_day  AS subscription_tiers_daily ON subscription_tiers_daily.account_id = accounts.account_id
LEFT JOIN marts_digital.clinical_time_per_subs  AS clinical_time_per_subs ON accounts.account_id=clinical_time_per_subs.account_id
LEFT JOIN marts_digital.cases  AS cases ON cases.account_id  = accounts.account_id and cases.account_id=clinical_time_per_subs.account_id and
          (TO_CHAR(DATE_TRUNC('month', CONVERT_TIMEZONE('UTC', 'America/New_York', cases.added_at )), 'YYYY-MM')) = (TO_CHAR(DATE_TRUNC('month', clinical_time_per_subs.subscription_month ), 'YYYY-MM'))
WHERE (accounts.company_care_mode ) <> 'undecided' AND ((subscription_tiers_daily.business_line) <> 'DTE' OR (subscription_tiers_daily.business_line) IS NULL) AND ((subscription_tiers_daily.subscription_type ) <> 'Free' AND (subscription_tiers_daily.subscription_type ) <> 'Free - Transactional' OR (subscription_tiers_daily.subscription_type ) IS NULL)
GROUP BY
    1,
    2) ww
) bb WHERE z__pivot_col_rank <= 16384
) aa
) xx
) zz
 WHERE (z__pivot_col_rank <= 50 OR z__is_highest_ranked_cell = 1) AND (z___pivot_row_rank <= 500) ORDER BY z___pivot_row_rank

-- sql for creating the total and/or determining pivot columns
SELECT
    (CASE WHEN cases.is_archived  THEN 'Yes' ELSE 'No' END) AS "cases.is_archived",
    COUNT(DISTINCT CASE WHEN (cases.case_type <> 'questions' OR cases.case_type IS NULL) THEN cases.case_id ELSE NULL END) AS "cases.count"
FROM marts_digital.person  AS accounts
LEFT JOIN marts_digital.person_day  AS subscription_tiers_daily ON subscription_tiers_daily.account_id = accounts.account_id
LEFT JOIN marts_digital.clinical_time_per_subs  AS clinical_time_per_subs ON accounts.account_id=clinical_time_per_subs.account_id
LEFT JOIN marts_digital.cases  AS cases ON cases.account_id  = accounts.account_id and cases.account_id=clinical_time_per_subs.account_id and
          (TO_CHAR(DATE_TRUNC('month', CONVERT_TIMEZONE('UTC', 'America/New_York', cases.added_at )), 'YYYY-MM')) = (TO_CHAR(DATE_TRUNC('month', clinical_time_per_subs.subscription_month ), 'YYYY-MM'))
WHERE (accounts.company_care_mode ) <> 'undecided' AND ((subscription_tiers_daily.business_line) <> 'DTE' OR (subscription_tiers_daily.business_line) IS NULL) AND ((subscription_tiers_daily.subscription_type ) <> 'Free' AND (subscription_tiers_daily.subscription_type ) <> 'Free - Transactional' OR (subscription_tiers_daily.subscription_type ) IS NULL)
GROUP BY
    1
ORDER BY
    1
LIMIT 50