functoin conversoin


| redshift | snowflake |
|----------|----------|
| SELECT JSON_EXTRACT_PATH_TEXT('{"f2":{"f3":1},"f4":{"f5":99,"f6":"star"}','f4', 'f6',true);

  | SELECT CASE WHEN CHECK_JSON('{"f2":{"f3":1},"f4":{"f5":99,"f6":"star"}}') is null
    then  JSON_EXTRACT_PATH_TEXT('{"f2":{"f3":1},"f4":{"f5":99,"f6":"star"}}', 'f4')
    else null
end as converted_from_rs_JSON_fxn;Content  |
| Content  | Content  |
