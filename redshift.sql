/*
note:
the administrative actions assume you are in an admin permed acc
*/

-- create a user
create user user
  with password 'afasdfasdfasdfasdfasdf'
  createdb syslog access unrestricted
;

-- grant perms for a dev
grant all on schema.table to username;
grant select on all tables in schema SCHEMANAME to USERNAME;
grant usage on schema SCHEMANAME to myUserName;

-- fix passwords
ALTER USER username password ‘password’;

-- audit perms
SELECT
    u.usename,
    s.schemaname,
    has_schema_privilege(u.usename,s.schemaname,'create') AS user_has_select_permission,
    has_schema_privilege(u.usename,s.schemaname,'usage') AS user_has_usage_permission
FROM
    pg_user u
CROSS JOIN
    (SELECT DISTINCT schemaname FROM pg_tables) s
WHERE
    u.usename = 'myUserName'
    AND s.schemaname = 'mySchemaName'
;

--drop your schemas that have dependencies on each other
drop schema clean, core cascade ;

/*--------------------------------------------------------
Query Tuning
--------------------------------------------------------*/
-- T7 longest running queries [top 50]
select trim(database) as db, count(query) as n_qry, 
    max(substring (qrytext,1,80)) as qrytext, 
    min(run_minutes) as "min" , 
    max(run_minutes) as "max", 
    avg(run_minutes) as "avg", sum(run_minutes) as total,  
    max(query) as max_query_id, 
    max(starttime)::date as last_run, 
    sum(alerts) as alerts, aborted
from (
    select userid, label, stl_query.query, 
        trim(database) as database, 
        trim(querytxt) as qrytext, 
        md5(trim(querytxt)) as qry_md5, 
        starttime, endtime, 
        (datediff(seconds, starttime,endtime)::numeric(12,2))/60 as run_minutes,     
        alrt.num_events as alerts, aborted 
    from stl_query 
    left outer join 
        (
            select 
                query, 1 as num_events 
            from stl_alert_event_log 
            group by query ) as alrt 
    on alrt.query = stl_query.query
    where userid <> 1 and starttime >=  dateadd(day, -7, current_date)
    ) 
group by database, label, qry_md5, aborted
order by total desc limit 50;
