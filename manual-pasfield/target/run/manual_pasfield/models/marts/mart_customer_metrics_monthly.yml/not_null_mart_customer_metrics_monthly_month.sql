select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select month
from `manual-pasfield`.`manual_test_mart`.`mart_customer_metrics_monthly`
where month is null



      
    ) dbt_internal_test