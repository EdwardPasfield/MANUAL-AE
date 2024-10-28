select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select customer_id
from `manual-pasfield`.`manual_test_mart`.`mart_customer_retention_metrics`
where customer_id is null



      
    ) dbt_internal_test