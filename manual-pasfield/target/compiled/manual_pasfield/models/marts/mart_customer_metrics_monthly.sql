-- IMPORT CTEs
with customers as (
    select 
        *
    from `manual-pasfield`.`manual_test`.`prep_customer`
),

--LOGICAL CTEs

cohort_base as (
    -- customer's acquisition date, active period, churn date
    select
        customer_id,
        date_trunc(from_date, month) as acquisition_month,
        date_trunc(to_date, month) as churn_month,
        customer_country,
        taxonomy_business_category_group,
        ifnull(to_date, current_date()) as last_activity_date
    from customers
),

monthly_cohorts as (
    --  monthly cohorts for acquisition, retention, and churn
    select
        acquisition_month,
        count(distinct customer_id) as acquired_customers,
        customer_country,
        taxonomy_business_category_group
    from cohort_base
    group by acquisition_month, customer_country, taxonomy_business_category_group
),

churn_data as (
    -- monthly churn based on churn month
    select
        churn_month,
        count(distinct customer_id) as churned_customers
    from cohort_base
    where churn_month is not null
    group by churn_month
),

active_data as (
    -- retention by counting customers who remain active each month
    select
        date_trunc(monthly_date, month) as month,
        count(distinct customer_id) as retained_customers
    from customers,
    unnest(generate_date_array(date_trunc(from_date, month), date_trunc(to_date, month), interval 1 month)) as monthly_date
    group by month
)

-- FINAL
select
    acquisition_month as month,
    customer_country,
    taxonomy_business_category_group,
    acquired_customers,
    coalesce(retained_customers, 0) as retained_customers,
    coalesce(churned_customers, 0) as churned_customers,
    round(safe_divide(coalesce(retained_customers, 0), acquired_customers) * 100) as retention_rate,
    safe_divide(coalesce(churned_customers, 0), acquired_customers) * 100 as churn_rate
from monthly_cohorts
left join churn_data on acquisition_month = churn_month
left join active_data on acquisition_month = month
order by acquisition_month, customer_country, taxonomy_business_category_group