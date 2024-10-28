-- IMPORT CTES
with customers as 
(
select 
    *
from `manual-pasfield`.`manual_test_ref`.`ref_customers`
),

acq_orders as (
select
    *
from `manual-pasfield`.`manual_test_ref`.`ref_acq_orders`
),

activity as (
    select
        *
    from `manual-pasfield`.`manual_test_ref`.`ref_activity`
),

random_names_and_numbers as (
    -- Just showing the use of seeds and macros. 
    select
        customer_id,
        first_value(first_name) over (partition by customer_id order by rand()) as first_name,
        first_value(last_name) over (partition by customer_id order by rand()) as last_name,
        
    -- Generates a random UK mobile phone number in the format 07XXX XXXXXX

    concat(
        '07',
        cast(floor(100 + rand() * 900) as string),    -- 3-digit prefix (100-999)
        ' ',
        cast(floor(100000 + rand() * 900000) as string) -- 6-digit number (100000-999999)
    )
 as mobile_number
    from customers
    join `manual-pasfield`.`manual_test`.`customer_names` on true
),

-- LOGICAL CTE

final as (
    select
    distinct
        cast(customers.customer_id as string) as customer_id,
        random_names_and_numbers.first_name,
        random_names_and_numbers.last_name,
        random_names_and_numbers.mobile_number,
        -- Could be fixed with a mapping seed if I had more time :) 
        -- Little bit of data cleansing
        case 
            when customers.customer_country = "United Kingdom" then "UK"
            when customers.customer_country = "Brazil" then "BR"
        end as customer_country,
        acq_orders.taxonomy_business_category_group,
        cast(activity.subscription_id as string) as subscription_id,
        activity.from_date,
        activity.to_date,
        case when activity.to_date > cast(timestamp(datetime(current_timestamp(), 'UTC')) as date) then true else false end as has_active_subscripton,
    from customers
    inner join acq_orders on customers.customer_id = acq_orders.customer_id
    inner join activity on customers.customer_id = activity.customer_id
    left join random_names_and_numbers on customers.customer_id = random_names_and_numbers.customer_id
    
)

-- FINAL CTE
select * from final