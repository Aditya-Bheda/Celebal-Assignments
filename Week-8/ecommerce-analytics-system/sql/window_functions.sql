SELECT

    p.product_name,

    SUM(oi.quantity * oi.unit_price) AS revenue,

    RANK() OVER(

        ORDER BY SUM(oi.quantity * oi.unit_price) DESC

    ) AS revenue_rank

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.product_name;



SELECT

    p.product_name,

    SUM(oi.quantity * oi.unit_price) AS revenue,

    DENSE_RANK() OVER(

        ORDER BY SUM(oi.quantity * oi.unit_price) DESC

    ) AS revenue_rank

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.product_name;



SELECT *

FROM(

SELECT

    c.state,

    c.customer_id,

    c.first_name,

    c.last_name,

    SUM(
        oi.quantity * oi.unit_price
    ) AS total_spent,

    ROW_NUMBER() OVER(

        PARTITION BY c.state

        ORDER BY
        SUM(
            oi.quantity * oi.unit_price
        ) DESC

    ) AS row_num

FROM customers c

JOIN orders o

ON c.customer_id = o.customer_id

JOIN order_items oi

ON o.order_id = oi.order_id

GROUP BY

c.state,

c.customer_id,

c.first_name,

c.last_name

)

WHERE row_num = 1;




SELECT

    order_date,

    daily_revenue,

    SUM(daily_revenue)

    OVER(

        ORDER BY order_date

    ) AS cumulative_revenue

FROM(

SELECT

    o.order_date,

    SUM(
        oi.quantity * oi.unit_price
    ) AS daily_revenue

FROM orders o

JOIN order_items oi

ON o.order_id = oi.order_id

GROUP BY o.order_date

);




SELECT

    order_id,

    order_total,

    LAG(order_total)

    OVER(

        ORDER BY order_id

    ) AS previous_order

FROM(

SELECT

    order_id,

    SUM(
        quantity * unit_price
    ) AS order_total

FROM order_items

GROUP BY order_id

);




SELECT

    order_id,

    order_total,

    LEAD(order_total)

    OVER(

        ORDER BY order_id

    ) AS next_order

FROM(

SELECT

    order_id,

    SUM(
        quantity * unit_price
    ) AS order_total

FROM order_items

GROUP BY order_id

);



