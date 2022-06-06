/* 
schema names macro
*/

{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if target.name == 'dev'  -%}

        {{ default_schema }}

    {%- else -%}

        {%- if custom_schema_name is none -%}

            {{ default_schema }}

        {%- else -%}

            {{ custom_schema_name | trim }}

        {%- endif -%}

    {%- endif -%}



{%- endmacro %}


/*
reference: https://github.com/dbt-labs/dbt-core/blob/8442fb66a591c4f5353f8baaaaf62f846c5f5171/core/dbt/include/global_project/macros/get_custom_name/get_custom_schema.sql
*/
