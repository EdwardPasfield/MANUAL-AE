
    
    

with all_values as (

    select
        customer_country as value_field,
        count(*) as n_records

    from `manual-pasfield`.`manual_test_mart`.`mart_customer_retention_metrics`
    group by customer_country

)

select *
from all_values
where value_field not in (
    'US','CA','GB','DE','FR','AU'
)


