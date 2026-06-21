-- Q19: Display order details along with customer information

SELECT o.order_id ,
	   o.order_date,
       c.first_name,
       c.last_name,
       o.total_amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;

/*
	INNER JOIN returns only the records that have
	matching values in both tables.

	Here, each order is matched with its customer
	using customer_id.
*/
---------------------------------------------------------------------------------------

-- 20. Using a LEFT JOIN, list ALL customers and their orders

SELECT c.customer_id,
	   c.first_name,
	   c.last_name,
       o.order_id,
       o.order_date,
       o.status,
       o.total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

/*
This query uses a LEFT JOIN to display all customers
along with their orders.

All records from the customers table are returned.

If a customer has placed an order, the corresponding
order details are displayed.

If a customer has not placed any order, the order
columns will contain NULL values.

In the current dataset, every customer has at least
one order, so no NULL values appear in the result.
*/
---------------------------------------------------------------------------------------------

-- Q21: Display order details with product information

SELECT o.order_id,
	   p.product_name,
       oi.quantity,
       oi.unit_price,
       oi.discount_pct
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id

INNER JOIN products p
ON p.product_id = oi.product_id;

/*
	This query uses INNER JOINs across three tables:
	orders, order_items, and products.

	First, orders and order_items are joined using
	order_id to identify the items included in each order.

	Then, order_items and products are joined using
	product_id to retrieve product information.

	The result displays each order item along with
	its product name, quantity, unit price, and
	discount percentage.

	Only matching records from all three tables
	are returned because INNER JOIN is used.
*/       
-------------------------------------------------------------------------------------------

-- Q22: Difference between LEFT JOIN and RIGHT JOIN

/*
	• LEFT JOIN:
		Returns all records from the left table and
		matching records from the right table.
		If no match exists, NULL values are returned
		for the right table columns.

		Example:
		customers LEFT JOIN orders

		All customers will appear, even if they have
		not placed any orders.

	• RIGHT JOIN:
		Returns all records from the right table and
		matching records from the left table.
		If no match exists, NULL values are returned
		for the left table columns.

		Example:
		customers RIGHT JOIN orders

		All orders will appear. If no matching customer existed,
		the customer columns would contain NULL values.

	• FULL OUTER JOIN:
		Returns all matching and non-matching rows
		from both tables.

		A FULL OUTER JOIN would be useful when we
		want to see every customer and every order,
		including unmatched records from both tables.
*/
--------------------------------------------------------------------------------------------

-- Q23: Foreign Key Relationships

/*

	
    • Foreign Key Relationships

-- orders.customer_id      -> customers.customer_id

-- order_items.order_id    -> orders.order_id

-- order_items.product_id  -> products.product_id


    • What happens if customer_id = 999 is inserted
	  into the orders table?

		The INSERT statement fails because customer_id
		999 does not exist in the customers table.

		The FOREIGN KEY constraint prevents invalid
		references and maintains referential integrity
		between the orders and customers tables.
*/
------------------------------------------------------------------------------------------------
