with prep_customer as(
    select
        *
    from {{ ref('prep_customer') }}
),

merged_data as (
    -- some basic customer retention metrics just because this table will probably be usseful in the future
    select
        pc.customer_id,
        pc.subscription_id,
        pc.from_date,
        pc.to_date,
        pc.customer_country,
        pc.taxonomy_business_category_group,
        -- subscription length in days
        date_diff(pc.to_date, pc.from_date, day) as subscription_length_days,
        -- time since last activity in days
        date_diff(current_date(), pc.to_date, day) as time_since_last_activity_days
    from prep_customer pc
)

-- FINAL CTE
select *
from merged_data
