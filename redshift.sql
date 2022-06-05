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
