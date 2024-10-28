select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select cohort_month
from `manual-pasfield`.`manual_test_mart`.`mart_cohort_retention_analysis_monthly`
where cohort_month is null



      
    ) dbt_internal_test