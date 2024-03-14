-- Create a new schema named "dev_dleong" with the authorization set to dleong.
create schema "dev_dleong" authorization dleong;

-- Grant the usage privilege on the plpythonu language to the data_eng_group group.
grant usage on language plpythonu to group data_eng_group;

-- Delete records from the my_schema.csv_files_data table where the file_name is 'generic_file.xlsx'.
DELETE FROM
    my_schema.csv_files_data
WHERE
    file_name = 'generic_file.xlsx';


-- This query retrieves information about queries that encountered an error during execution.
-- It includes details such as the username, error code, error message, query text, start time, end time, and query runtime.
-- The query filters the results based on the error code, query text, start time, and other conditions.

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

-- Diagnotistic Queries
SELECT *
FROM sys_query_history
LIMIT 5;

SELECT *
FROM sys_load_error_detail
WHERE query_id = '198142947'
LIMIT 50;

SELECT *
FROM pg_catalog.stl_error;

SELECT *
FROM pg_catalog.stl_query q
LEFT JOIN pg_catalog.stl_error e ON q.pid = e.pid
WHERE query = '198142947'
LIMIT 5;

SELECT *
FROM pg_catalog.pg_user_info pui
WHERE useconfig LIKE '%admin%';
