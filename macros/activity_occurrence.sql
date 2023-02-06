{# Creates the two activity occurrence columns: activity_occurrence and activity_repeated_at  #}

{% macro activity_occurrence() %}
    row_number() over (
        partition by coalesce (
            {{ safe_cast("customer", type_string()) }},
            {{ safe_cast("anonymous_customer_id", type_string()) }},
            activity_id
            ) order by ts asc ) as activity_occurrence,
    lead(ts) over (
        partition by coalesce (
            {{ safe_cast("customer", type_string()) }},
            {{ safe_cast("anonymous_customer_id", type_string()) }}
        ) order by ts asc) as activity_repeated_at
{% endmacro %}