
  
    

    create or replace table `manual-pasfield`.`manual_test_mart`.`mart_customer_retention_metrics`
        
  (
    customer_id string,
    subscription_id string,
    from_date date,
    to_date date,
    customer_country string,
    taxonomy_business_category_group string,
    subscription_length_days int64,
    time_since_last_activity_days int64
    
    )

      
    
    

    OPTIONS()
    as (
      
    select customer_id, subscription_id, from_date, to_date, customer_country, taxonomy_business_category_group, subscription_length_days, time_since_last_activity_days
    from (
        with prep_customer as(
    select
        *
    from `manual-pasfield`.`manual_test`.`prep_customer`
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
    ) as model_subq
    );
  