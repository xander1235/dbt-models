

  create  table "postgres".raw_data."pinterest_ads_ad_group_report__dbt_tmp"
  as (
    
with __dbt__cte__pinterest_ads_ad_group_report_ab1 as (

-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: "postgres".raw_data._airbyte_raw_pinterest_ads_ad_group_report
select
    jsonb_extract_path_text(_airbyte_data, 'value') as "value",
    cast(jsonb_extract_path_text(_airbyte_data, 'url') as string) as "url",
    cast(jsonb_extract_path_text(_airbyte_data, 'board_id') as string) as "board_id",
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from "postgres".raw_data._airbyte_raw_pinterest_ads_ad_group_report as table_alias
-- pinterest_ads_ad_group_report
where 1 = 1
),  __dbt__cte__pinterest_ads_ad_group_report_ab2 as (

-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: __dbt__cte__pinterest_ads_ad_group_report_ab1
select
    cast("value" as text) as "value",
    url,
    board_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at
from __dbt__cte__pinterest_ads_ad_group_report_ab1
-- pinterest_ads_ad_group_report
where 1 = 1
),  __dbt__cte__pinterest_ads_ad_group_report_ab3 as (

-- SQL model to build a hash column based on the values of this record
-- depends_on: __dbt__cte__pinterest_ads_ad_group_report_ab2
select
    md5(cast(coalesce(cast("value" as text), '') as text)) as _airbyte_pinterest_a__d_group_report_hashid,
    tmp.*
from __dbt__cte__pinterest_ads_ad_group_report_ab2 tmp
-- pinterest_ads_ad_group_report
where 1 = 1
)-- Final base SQL model
-- depends_on: __dbt__cte__pinterest_ads_ad_group_report_ab3
select
    "value",
    url,
    board_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    now() as _airbyte_normalized_at,
    _airbyte_pinterest_a__d_group_report_hashid
from __dbt__cte__pinterest_ads_ad_group_report_ab3
-- pinterest_ads_ad_group_report from "postgres".raw_data._airbyte_raw_pinterest_ads_ad_group_report
where 1 = 1
  );
