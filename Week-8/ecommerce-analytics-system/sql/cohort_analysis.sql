SELECT

    customer_id,

    MIN(order_date) AS first_purchase_date,

    strftime('%Y-%m', MIN(order_date)) AS cohort_month

FROM orders

GROUP BY customer_id;



SELECT

    strftime('%Y-%m', order_date) AS order_month,

    COUNT(DISTINCT customer_id) AS active_customers

FROM orders

GROUP BY order_month

ORDER BY order_month;



SELECT

    cohort_month,

    COUNT(*) AS cohort_size

FROM(

SELECT

    customer_id,

    strftime('%Y-%m', MIN(order_date)) AS cohort_month

FROM orders

GROUP BY customer_id

)

GROUP BY cohort_month

ORDER BY cohort_month;



SELECT

    c.customer_id,

    c.first_name,

    c.last_name,

    ROUND(

        SUM(
            oi.quantity * oi.unit_price
        ),

        2

    ) AS lifetime_value

FROM customers c

JOIN orders o

ON c.customer_id = o.customer_id

JOIN order_items oi

ON o.order_id = oi.order_id

GROUP BY

c.customer_id,

c.first_name,

c.last_name

ORDER BY lifetime_value DESC;



SELECT

    strftime('%Y-%m', o.order_date) AS month,

    ROUND(

        SUM(
            oi.quantity * oi.unit_price
        ),

        2

    ) AS revenue

FROM orders o

JOIN order_items oi

ON o.order_id = oi.order_id

GROUP BY month

ORDER BY month;




