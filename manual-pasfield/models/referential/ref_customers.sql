select
    *
from {{ source('application','customers')}}