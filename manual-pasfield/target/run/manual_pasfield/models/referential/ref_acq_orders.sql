
  
    

    create or replace table `manual-pasfield`.`manual_test_ref`.`ref_acq_orders`
      
    
    

    OPTIONS()
    as (
      select
    *
from `manual-pasfield`.`manual`.`acq_orders`
    );
  