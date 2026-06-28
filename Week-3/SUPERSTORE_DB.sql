CREATE DATABASE superstore_db;
USE superstore_db;

CREATE TABLE superstore_raw (
    row_id INT,
    order_id VARCHAR(30),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(30),

    customer_id VARCHAR(30),
    customer_name VARCHAR(100),
    segment VARCHAR(30),

    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(30),

    product_id VARCHAR(30),
    category VARCHAR(30),
    sub_category VARCHAR(30),
    product_name VARCHAR(255),

    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);

-- SELECT COUNT(*) FROM superstore_raw;

CREATE TABLE customers (
    customer_id VARCHAR(30) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(30)
);

INSERT INTO customers
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM superstore_raw;

CREATE TABLE products (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    product_id VARCHAR(30),
    product_name VARCHAR(255),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

INSERT INTO products (product_id, product_name, category, sub_category)
SELECT
    product_id,
    MAX(product_name),
    MAX(category),
    MAX(sub_category)
FROM superstore_raw
GROUP BY product_id;


CREATE TABLE orders
(
    row_id INT PRIMARY KEY,

    order_id VARCHAR(30),

    order_date DATE,

    ship_date DATE,

    ship_mode VARCHAR(30),

    customer_id VARCHAR(30),

    product_key INT,

    sales DECIMAL(10,2),

    quantity INT,

    discount DECIMAL(5,2),

    profit DECIMAL(10,2),

    FOREIGN KEY(customer_id)
    REFERENCES customers(customer_id),

    FOREIGN KEY(product_key)
    REFERENCES products(product_key)
);


INSERT INTO orders
(
    row_id,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    product_key,
    sales,
    quantity,
    discount,
    profit
)

SELECT

s.row_id,

s.order_id,

STR_TO_DATE(s.order_date,'%c/%e/%Y'),

STR_TO_DATE(s.ship_date,'%c/%e/%Y'),

s.ship_mode,

s.customer_id,

p.product_key,

s.sales,

s.quantity,

s.discount,

s.profit

FROM superstore_raw s

JOIN products p
ON s.product_id=p.product_id;

SELECT COUNT(*) FROM superstore_raw;
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM products;
SELECT COUNT(*) FROM orders;

-- Creating indexes to improve query performance

CREATE INDEX idx_customer
ON orders(customer_id);

CREATE INDEX idx_product
ON orders(product_key);

CREATE INDEX idx_order
ON orders(order_id);
----------------------------------------------------------------------------------------------

-- 1. Find all orders where sales are greater than the average sales. (Subquery)

SELECT *
FROM orders
WHERE sales >
(
	SELECT AVG(sales)
    FROM orders
);
-----------------------------------------------------------------------------------------------

-- 2. Find the highest sales order for each customer. (Subquery)  

SELECT *
FROM orders o
WHERE sales = 
(
	SELECT MAX(sales)
    FROM orders
    WHERE customer_id = o.customer_id
);
-----------------------------------------------------------------------------------------------

-- 3. Calculate total sales for each customer. (CTE)  

WITH customer_sales AS
(
	SELECT customer_id,
    SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_sales;

-- this query also achieved using subquery concept

/*

SELECT *
FROM (
		SELECT customer_id,
        SUM(sales) AS total_sales
        FROM orders
        GROUP BY customer_id
) AS customer_sales;

*/
----------------------------------------------------------------------------------------

-- 4. Find customers whose total sales are above average. (CTE + Subquery)  

WITH customer_sales AS
(
	SELECT customer_id,
		   SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_sales
WHERE total_sales >
(
	SELECT AVG(sales)
    FROM orders
);
-------------------------------------------------------------------------------------------------

-- 5. Rank all customers based on total sales. (Window Function)  

WITH customer_sales AS
(
	SELECT customer_id,
		   SUM(sales) AS total_sales
	FROM orders
    GROUP BY customer_id
)
SELECT *,
	   RANK() OVER(ORDER BY total_sales DESC) AS customer_rank
FROM customer_sales;
-------------------------------------------------------------------------------------------------

-- 6. Assign row numbers to each order within a customer. (Window Function + PARTITION BY)  

SELECT customer_id,
	   order_id,
       sales,
       ROW_NUMBER() OVER(PARTITION BY customer_id  ORDER BY order_date) AS row_no
FROM orders;
--------------------------------------------------------------------------------------------------

-- 7. Display top 3 customers based on total sales. (Window Function)  

WITH customer_sales AS
(
	SELECT customer_id,
		   SUM(sales) AS total_sales
	FROM orders
    GROUP BY customer_id
)
SELECT *
FROM
(
	SELECT *,
    RANK() OVER(ORDER BY total_sales DESC) AS customer_rank
    FROM customer_sales
) t
WHERE customer_rank <= 3;
-----------------------------------------------------------------------------------------------

/*
 
Step 3: Final Combined Query 

Write one final query that shows: 

Customer Name  
Total Sales  
Rank  
(Use JOIN + CTE + Window Function together)

 */
 
WITH customer_sales AS
(
	SELECT customer_id,
    SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name,
	   cs.total_sales,
       RANK() OVER(ORDER BY cs.total_sales DESC) AS customer_rank
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id;
------------------------------------------------------------------------------------------------

-- Mini Project: Customer Sales Insights 

-- 1. Who are the top 5 customers?  

-- WITH customer_sales AS
-- (
-- 	SELECT customer_id,
-- 		   SUM(sales) AS total_sales
--            FROM orders
--            GROUP BY customer_id
-- )
-- SELECT *
-- FROM (
-- 		SELECT *,
--         RANK() OVER(ORDER BY total_sales DESC) AS customer_rank
--         FROM customer_sales
-- ) x
-- WHERE customer_rank <=5;

WITH customer_sales AS
(
	SELECT customer_id,
		   SUM(sales) AS total_sales
           FROM orders
           GROUP BY customer_id
)
SELECT c.customer_name,
	   cs.total_sales
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
ORDER BY total_sales DESC
LIMIT 5;
-----------------------------------------------------------------------------------------------

-- 2. Who are the bottom 5 customers?  

WITH customer_sales AS
(
	SELECT customer_id,
		   SUM(sales) AS total_sale
	FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name,
	   cs.total_sale
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
ORDER BY total_sale
LIMIT 5;
----------------------------------------------------------------------------------------------

-- 3. Which customers made only one order?  

SELECT c.customer_name,
	   o.customer_id,
       COUNT(o.order_id) AS total_order
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY
	   o.customer_id,
       c.customer_name
HAVING total_order = 1;
------------------------------------------------------------------------------------------------

-- 4. Which customers have above-average sales?  

WITH customer_sales AS
(
	SELECT customer_id,
    SUM(sales) AS total_sale
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name,
	   cs.total_sale
FROM customer_sales cs
JOIN customers c
ON cs.customer_id = c.customer_id
WHERE total_sale >
(
	SELECT AVG(total_sale)
    FROM customer_sales
);
-------------------------------------------------------------------------------------------------

-- 5. What is the highest order value per customer? 

SELECT c.customer_name,
	   o.customer_id,
       MAX(o.sales) AS highest_order_value
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY 
		o.customer_id,
        c.customer_name
ORDER BY highest_order_value DESC;
--------------------------------------------------------------------------------------------------

/*==========================================
            KEY INSIGHTS
==========================================

1. The top 5 customers contributed the highest total sales.
2. Some customers placed only one order.
3. Several customers generated above-average total sales.
4. Window Functions (RANK, ROW_NUMBER) simplified customer ranking and order analysis.
5. CTEs made customer-level aggregations more readable and reusable.
6. JOINs combined customer details with sales metrics to generate business insights.

==========================================*/