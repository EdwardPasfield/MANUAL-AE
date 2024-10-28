

with all_values as (

    select
        customer_country as value_field

    from `manual-pasfield`.`manual_test_mart`.`mart_customer_retention_metrics`
    

),
set_values as (

    select
        cast('US' as string) as value_field
    union all
    select
        cast('CA' as string) as value_field
    union all
    select
        cast('GB' as string) as value_field
    union all
    select
        cast('DE' as string) as value_field
    union all
    select
        cast('FR' as string) as value_field
    union all
    select
        cast('AU' as string) as value_field
    union all
    select
        cast('UK' as string) as value_field
    union all
    select
        cast('BR' as string) as value_field
    
    
),
validation_errors as (
    -- values from the model that are not in the set
    select
        v.value_field
    from
        all_values v
        left join
        set_values s on v.value_field = s.value_field
    where
        s.value_field is null

)

select *
from validation_errors

