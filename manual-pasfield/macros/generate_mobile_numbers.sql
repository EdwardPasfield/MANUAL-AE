
{% macro generate_mobile_numbers() %}
    -- Generates a random UK mobile phone number in the format 07XXX XXXXXX

    concat(
        '07',
        cast(floor(100 + rand() * 900) as string),    -- 3-digit prefix (100-999)
        ' ',
        cast(floor(100000 + rand() * 900000) as string) -- 6-digit number (100000-999999)
    )
{% endmacro %}
