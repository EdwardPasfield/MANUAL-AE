-- IMPORT CTEs
with customers as (
    select 
        *
    from `manual-pasfield`.`manual_test`.`prep_customer`
),

-- LOGICAL CTEs
cohort_data as (
    select
        customer_id,
        date_trunc(from_date, month) as cohort_month,
        from_date,
        to_date,
        customer_country,
        taxonomy_business_category_group,
        date_diff(to_date, from_date, day) as subscription_length_days  -- length in days
    from customers
),

cohort_intervals as (
    select
        cohort_month,
        customer_country,
        taxonomy_business_category_group,
        count(distinct customer_id) as total_customers,
        -- customers still active at 1,3,6 months
        count(distinct case when date_diff(to_date, from_date, day) >= 30 then customer_id end) as retained_1_month,
        count(distinct case when date_diff(to_date, from_date, day) >= 90 then customer_id end) as retained_3_months,
        count(distinct case when date_diff(to_date, from_date, day) >= 180 then customer_id end) as retained_6_months
    from cohort_data
    group by cohort_month, customer_country, taxonomy_business_category_group
),

cohort_retention_rates as (
    -- retention rates for each cohort at 1, 3, and 6 months
    select
        cohort_month,
        customer_country,
        taxonomy_business_category_group,
        total_customers,
        retained_1_month,
        retained_3_months,
        retained_6_months,
        --  retention rates as percentages
        round((safe_divide(retained_1_month, total_customers) * 100), 2) as retention_rate_1_month,
        round((safe_divide(retained_3_months, total_customers) * 100), 2) as retention_rate_3_months,
        round((safe_divide(retained_6_months, total_customers) * 100), 2) as retention_rate_6_months
    from cohort_intervals
)

-- FINAL CTE
select *
from cohort_retention_rates
order by cohort_month, customer_country, taxonomy_business_category_group