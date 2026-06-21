-- Q7: Retrieve all orders with status = 'Delivered'

SELECT * 
FROM orders
WHERE status = 'Delivered';
-----------------------------------------------------------------------------------------

-- Q8: Find Electronics products with unit_price > 2000

SELECT *
FROM products
WHERE category = 'Electronics' AND unit_price > 2000; 
-----------------------------------------------------------------------------------------

-- Q9: Customers who joined in 2024 and belong to Maharashtra

SELECT *
FROM customers
WHERE state = 'Maharashtra' AND join_date BETWEEN '2024-01-01' AND '2024-12-31';
-----------------------------------------------------------------------------------------

-- Q10: Orders between 2024-08-10 and 2024-08-25 excluding cancelled orders

SELECT * 
FROM orders
WHERE status != 'Cancelled' AND order_date BETWEEN '2024-08-10' AND '2024-08-25';
-----------------------------------------------------------------------------------------

-- Q11: Sample query that benefits from idx_orders_date

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-08-01' AND '2024-08-31';

/*
  • What does idx_orders_date do?

	The idx_orders_date index is created on the order_date column.
	It helps MySQL locate rows faster when filtering or sorting
	based on order_date.

	Without the index, MySQL may scan every row in the table.
	With the index, MySQL can directly find matching records,
	which improves query performance.
*/
-----------------------------------------------------------------------------------------

-- Q12: Query that may not effectively use an index

SELECT *
FROM customers
WHERE YEAR(join_date) = 2024;

/*
   • Will the index be used?

	There is currently no index on join_date in the customers table.

	However, if an index existed on join_date, applying the
	YEAR() function would prevent MySQL from efficiently using it.

	This is because MySQL must calculate YEAR(join_date)
	for every row before filtering.
*/

-- Index-friendly (SARGable) query

SELECT * 
FROM customers
WHERE join_date >= '2024-01-01' AND join_date< '2025-01-01';

/*
	• Why is this better?

		This query compares the actual column values directly
		instead of applying a function to the column.

		If an index existed on join_date, MySQL could use it
		more efficiently, making the query faster on large datasets.
*/
---------------------------------------------------------------------------------------------
