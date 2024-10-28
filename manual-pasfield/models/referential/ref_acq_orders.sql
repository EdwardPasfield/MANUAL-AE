select
    *
from {{ source('application','acq_orders')}}