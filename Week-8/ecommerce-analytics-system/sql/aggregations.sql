SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_products
FROM products;

SELECT COUNT(*) AS total_orders
FROM orders;


SELECT

    p.category,

    ROUND(
        SUM(oi.quantity * oi.unit_price),
        2
    ) AS revenue

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.category

ORDER BY revenue DESC;



SELECT

    p.product_name,

    SUM(oi.quantity) AS total_quantity_sold

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.product_name

ORDER BY total_quantity_sold DESC

LIMIT 10;



SELECT

    p.brand,

    ROUND(
        SUM(
            oi.quantity * oi.unit_price
        ),
        2
    ) AS revenue

FROM order_items oi

JOIN products p
ON oi.product_id = p.product_id

GROUP BY p.brand

ORDER BY revenue DESC;



SELECT

    ROUND(
        AVG(order_total),
        2
    ) AS average_order_value

FROM (

    SELECT

        order_id,

        SUM(
            quantity * unit_price
        ) AS order_total

    FROM order_items

    GROUP BY order_id

);



SELECT

    payment_method,

    COUNT(*) AS total_orders

FROM orders

GROUP BY payment_method

ORDER BY total_orders DESC;



