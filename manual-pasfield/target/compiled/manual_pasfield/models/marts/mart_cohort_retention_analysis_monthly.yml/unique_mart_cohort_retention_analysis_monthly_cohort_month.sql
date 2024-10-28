
    
    

with dbt_test__target as (

  select cohort_month as unique_field
  from `manual-pasfield`.`manual_test_mart`.`mart_cohort_retention_analysis_monthly`
  where cohort_month is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


