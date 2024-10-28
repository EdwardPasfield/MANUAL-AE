select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select from_date
from `manual-pasfield`.`manual_test_mart`.`mart_customer_retention_metrics`
where from_date is null



      
    ) dbt_internal_test