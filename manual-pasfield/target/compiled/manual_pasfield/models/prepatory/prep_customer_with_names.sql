-- models/prepatory/prep_customer_with_names.sql

with cohort_base as (
    -- First CTE: Define customer data with cohort information
    select
        customer_id,
        date_trunc(from_date, month) as acquisition_month,
        date_trunc(to_date, month) as churn_month,
        ifnull(to_date, current_date()) as last_activity_date
    from `manual-pasfield`.`manual_test`.`prep_customer`
),

random_names as (
    -- Second CTE: Assign random names from the seed data
    select
        customer_id,
        first_value(first_name) over (partition by customer_id order by rand()) as first_name,
        first_value(last_name) over (partition by customer_id order by rand()) as last_name
    from cohort_base
    join `manual-pasfield`.`manual_test`.`customer_names` on true
)

-- Final SELECT to join all CTEs and get the desired fields
select
    cohort_base.customer_id,
    acquisition_month,
    churn_month,
    last_activity_date,
    random_names.first_name,
    random_names.last_name
from cohort_base
left join random_names on cohort_base.customer_id = random_names.customer_id
order by acquisition_month