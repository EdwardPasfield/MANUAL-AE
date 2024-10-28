select
    *
from {{ source('application','activity')}}