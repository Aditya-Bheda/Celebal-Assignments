SELECT

    c.customer_id,

    c.first_name,

    c.last_name,

    ROUND(
        SUM(oi.quantity * oi.unit_price),
        2
    ) AS total_spent

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY

    c.customer_id,
    c.first_name,
    c.last_name

ORDER BY total_spent DESC;



SELECT

    c.customer_id,

    c.first_name,

    c.last_name,

    ROUND(
        SUM(oi.quantity * oi.unit_price),
        2
    ) AS total_spent

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY

    c.customer_id,
    c.first_name,
    c.last_name

ORDER BY total_spent DESC

LIMIT 10;



SELECT

    c.customer_id,

    c.first_name,

    c.last_name,

    COUNT(o.order_id) AS total_orders

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

GROUP BY

    c.customer_id,
    c.first_name,
    c.last_name

ORDER BY total_orders DESC;




SELECT

    c.customer_id,

    c.first_name,

    c.last_name,

    ROUND(

        SUM(
            oi.quantity * oi.unit_price
        )

        /

        COUNT(DISTINCT o.order_id),

        2

    ) AS average_order_value

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY

    c.customer_id,
    c.first_name,
    c.last_name

ORDER BY average_order_value DESC;


SELECT

    customer_id,

    first_name,

    last_name,

    total_spent,

    CASE

        WHEN total_spent >= 500000

            THEN 'High Value'

        WHEN total_spent >= 200000

            THEN 'Medium Value'

        ELSE 'Low Value'

    END AS customer_segment

FROM(

SELECT

    c.customer_id,

    c.first_name,

    c.last_name,

    ROUND(

        SUM(
            oi.quantity * oi.unit_price
        ),

        2

    ) AS total_spent

FROM customers c

JOIN orders o
ON c.customer_id = o.customer_id

JOIN order_items oi
ON o.order_id = oi.order_id

GROUP BY

    c.customer_id,
    c.first_name,
    c.last_name

)

ORDER BY total_spent DESC;




