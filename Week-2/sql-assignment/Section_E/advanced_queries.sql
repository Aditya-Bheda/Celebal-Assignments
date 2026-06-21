-- Q24: Classify products into price tiers

SELECT product_name,
	   unit_price,
       CASE 
			WHEN unit_price < 1000 THEN 'Budget'
            WHEN  unit_price BETWEEN 1000 AND 3000 THEN 'Mid-Range'
            ELSE 'Premium'
       END AS Price_tier 
FROM products;

/*
CASE is used to apply conditional logic.

Products are classified as:

Budget    -> unit_price < 1000

Mid-Range -> unit_price BETWEEN 1000 AND 3000

Premium   -> unit_price > 3000
*/
-------------------------------------------------------------------------------------------

-- Q25: Count Delivered vs Not Delivered orders

SELECT 
	SUM(
		CASE
			WHEN status = 'Delivered' THEN 1
            ELSE 0
        END) AS delivered_orders,
    SUM(CASE
			WHEN status != 'Delivered' THEN 1
            ELSE 0
	  END) AS not_delivered_orders
FROM orders;

/*
CASE is used inside SUM() to count records.

If status = 'Delivered',
CASE returns 1, otherwise 0.

The SUM() function then adds all 1s to
calculate the total number of delivered
and not delivered orders.
*/
----------------------------------------------------------------------------------------------

/*
Q26: ACID Properties

A - Atomicity

A transaction is treated as a single unit.
Either all operations succeed or none do.

Example:
During a bank transfer, if money is deducted
from one account but the credit operation fails,
the entire transaction is rolled back.

------------------------------------------------

C - Consistency

A transaction must take the database from one
valid state to another valid state.

Example:
After a bank transfer, the total amount of
money in the system remains unchanged.

------------------------------------------------

I - Isolation

Multiple transactions can execute concurrently
without interfering with each other.

Example:
Two users transferring money simultaneously
should not affect each other's transaction.

------------------------------------------------

D - Durability

Once a transaction is committed, the changes
remain permanent even if the system crashes.

Example:
After a successful bank transfer and COMMIT,
the updated balances remain saved even after
a power failure.
*/
----------------------------------------------------------------------------------------------

-- Q27: SQL Transaction Example

START TRANSACTION;

-- 1.Insert new record

INSERT INTO orders VALUES (
	1011,102,CURDATE(),'Pending',1598.00);

-- Step 2: Insert two order items

INSERT INTO order_items VALUES(
	5016,1011,202,1,799.00,0);

INSERT INTO order_items VALUES(
	5017,1011,208,1,799.00,0);

-- Step 3: Update product stock

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 202;

UPDATE products
SET stock_qty = stock_qty - 1
WHERE product_id = 208;

-- If all statements execute successfully

COMMIT;

-- If any statement fails, execute:
-- ROLLBACK;


/*
This transaction performs multiple operations
as a single unit of work.

Step 1:
A new order is inserted into the orders table.

Step 2:
Two order items are inserted into the
order_items table.

Step 3:
The stock quantity of the purchased products
is reduced in the products table.

COMMIT:
If all operations are completed successfully,
COMMIT permanently saves the changes.

ROLLBACK:
If any operation fails (for example, an invalid
product_id, insufficient stock, or a constraint
violation), ROLLBACK cancels the entire
transaction and restores the database to its
previous state.

This ensures data consistency and demonstrates
the Atomicity property of ACID, where either
all operations succeed or none of them are
applied.
*/
----------------------------------------------------------------------------------------------
