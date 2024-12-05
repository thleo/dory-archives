## config
### model block
```python
{{ 
  config(
    # General Model Configuration
    materialized='table',            -- Options: 'view', 'table', 'incremental', 'ephemeral'
    schema='my_schema',              -- Custom schema for the model
    alias='my_custom_table_name',    -- Custom table name in BigQuery
    database='my_database',          -- Specify the BigQuery project ID
    tags=['finance', 'etl'],         -- Tags for organizing and documenting models

    # Partitioning
    partition_by={
        "field": "event_date",       -- Column to partition by
        "data_type": "DATE"          -- Data type of the partition column (e.g., DATE, TIMESTAMP)
    },
    
    # Clustering
    cluster_by=["user_id", "region"], -- List of columns for clustering

    # Incremental Model Options
    unique_key='user_id',            -- Unique key for merging rows in incremental models
    incremental_strategy='merge',    -- Options: 'merge' or 'insert_overwrite'
    on_schema_change='sync_all_columns', -- Options: 'ignore', 'fail', 'sync_all_columns'

    # Query Optimization
    enabled=true,                    -- Whether the model is enabled for building
    full_refresh=false,              -- Force a full rebuild when running dbt
    persist_docs={                   -- Enable documentation persistence
        "relation": true,            -- Persist docs for the table
        "columns": true              -- Persist docs for the columns
    },
    
    # BigQuery-specific Options
    require_partition_filter=true,   -- Enforce use of partition filters
    query_tag='finance_pipeline',    -- Add a tag to the query for auditing/debugging

    # Logging and Labels
    labels={                         -- Add custom labels for cost tracking
        "env": "prod",
        "team": "analytics"
    },

    # Resource Configuration
    grants={                         -- Permissions for the table/view
        "select": ["group:data_scientists"]
    }
  ) 
}}
```