# Maintenance and Permissions SQL Script

This document contains the SQL script for maintenance and permissions, originally found in `maintenance+perms.sql`.

## Section 1: Checking Previous Queries

The following query retrieves information about queries, errors, and users from the PostgreSQL system catalog views.

```sql
SELECT
    usename,
    errcode,
    error,
    query,
    querytxt,
    starttime,
    endtime,
    date_diff('s', starttime, endtime) AS query_runtime
FROM
    pg_catalog.stl_query q
    LEFT JOIN pg_catalog.stl_error e ON q.pid = e.pid
    LEFT JOIN pg_catalog.pg_user_info pui ON e.userid = pui.usesysid
WHERE
    1 = 1
    -- Uncomment the following line and specify a query ID to filter by a specific query
    -- AND query = '198142947'
    AND errcode = 95
    AND querytxt LIKE '%user_id":300%'
    AND starttime > '2023-03-01'
;
```

## Diagnostic Queries

This section contains several diagnostic queries used for system analysis and troubleshooting.

Query 1: Retrieve Last 5 Queries
```sql
SELECT *
FROM sys_query_history
LIMIT 5;
```
Query 2: Retrieve Error Details for a Specific Query
```sql
SELECT *
FROM sys_load_error_detail
WHERE query_id = '198142947'
LIMIT 50;
```
Query 3: Retrieve All Errors
```sql
SELECT *
FROM pg_catalog.stl_error;
```
Query 4: Retrieve Specific Query and Associated Errors
```sql
SELECT *
FROM pg_catalog.stl_query q
LEFT JOIN pg_catalog.stl_error e ON q.pid = e.pid
WHERE query = '198142947'
LIMIT 5;
```
Query 5: Retrieve User Info for Admin Users
```sql
SELECT *
FROM pg_catalog.pg_user_info pui
WHERE useconfig LIKE '%admin%';
```

## GRANTS
```sql
-- for new tables
-- delivery_business_production_extracts.group_table
ALTER DEFAULT PRIVILEGES IN SCHEMA app_references GRANT
SELECT
    ON tables TO GROUP data_eng_group;
```
```sql
GRANT USAGE ON SCHEMA delivery_business_production_extract TO GROUP data_eng_group;
```
```sql
-- GRANT dbt user
GRANT USAGE ON SCHEMA digital_business_production_reference TO dbt;```

```sql
grant
select
on all tables in schema digital_business_production_reference to dbt;
```

```sql
ALTER DEFAULT PRIVILEGES IN SCHEMA digital_business_production_reference GRANT
SELECT
    ON tables TO dbt;
```

## GET DDL
This query will allow you to grab the DDL for a set of tables in the specified schema.
It returns a single column with DDL SQL.
```sql
-- note: User generated schema's are not in pg_table_def search path by default
-- SET SEARCH_PATH TO android; -- this will allow you to see the schema in the search path

SELECT ddl
FROM admin.v_generate_tbl_ddl
JOIN pg_table_def ON (
    admin.v_generate_tbl_ddl.schemaname = pg_table_def.schemaname AND
    admin.v_generate_tbl_ddl.tablename = pg_table_def.tablename
)
WHERE admin.v_generate_tbl_ddl.schemaname = 'android'
GROUP BY admin.v_generate_tbl_ddl.tablename, ddl, "seq"
ORDER BY admin.v_generate_tbl_ddl.tablename ASC, "seq" ASC;
```