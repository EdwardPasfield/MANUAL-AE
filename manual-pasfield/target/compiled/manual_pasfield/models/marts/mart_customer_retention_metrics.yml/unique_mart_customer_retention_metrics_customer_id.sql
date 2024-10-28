
    
    

with dbt_test__target as (

  select customer_id as unique_field
  from `manual-pasfield`.`manual_test_mart`.`mart_customer_retention_metrics`
  where customer_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


