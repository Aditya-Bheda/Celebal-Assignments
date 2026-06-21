-- Q13: Count the total number of orders in the orders table

SELECT COUNT(*) AS total_orders
FROM orders;
-----------------------------------------------------------------------------------------------

-- Q14: Find total revenue from delivered orders

SELECT SUM(total_amount) AS total_revenue
FROM orders
WHERE status = 'Delivered';
-----------------------------------------------------------------------------------------------

-- Q15: Calculate average unit_price by category

SELECT category ,
	   AVG(unit_price) AS avg_unit_price
FROM products
GROUP BY category;
-----------------------------------------------------------------------------------------------

-- Q16: Count orders and total revenue for each order status

SELECT status,
	   COUNT(*) AS total_count ,
       SUM(total_amount) AS total_revenue
FROM orders
GROUP BY status
ORDER BY total_revenue DESC;
-----------------------------------------------------------------------------------------------

-- Q17: Find the maximum and minimum product price in each category

SELECT category,
	   MAX(unit_price) AS max_price ,
       MIN(unit_price) AS min_price
FROM products
GROUP BY category;

/*
MAX(unit_price) returns the highest product price
within each category.

MIN(unit_price) returns the lowest product price
within each category.
*/
-----------------------------------------------------------------------------------------------

-- Q18: Categories having average unit_price greater than 2000

SELECT category,
	   AVG(unit_price) AS avg_price
FROM products
GROUP BY category
HAVING avg_price > 2000; 

/*
HAVING is used to filter grouped data.

WHERE filters rows before GROUP BY,
whereas HAVING filters groups after
GROUP BY has been applied.

Here, only categories with an average
unit_price greater than 2000 are returned.
*/      
-----------------------------------------------------------------------------------------------
