select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select to_date
from `manual-pasfield`.`manual_test_mart`.`mart_customer_retention_metrics`
where to_date is null



      
    ) dbt_internal_test