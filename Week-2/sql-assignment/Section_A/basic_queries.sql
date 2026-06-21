-- Q1: Display all customer records

SELECT *
FROM customers;
-------------------------------------------------------

-- Q2: Display customer names and city

SELECT first_name , last_name , city
FROM customers;
-------------------------------------------------------

-- Q3: Display unique product categories

SELECT DISTINCT category
FROM products;
-------------------------------------------------------

-- Q4: Primary Keys in the database schema

-- customers    -> customer_id
-- products     -> product_id
-- orders       -> order_id
-- order_items  -> item_id

-- • Why must a Primary Key be UNIQUE and NOT NULL?
/* A Primary Key uniquely identifies each record in a table . 
   Uniqueness prevents duplicate records, while NOT NULL
   ensures every row has a valid identifier.
*/
 ----------------------------------------------------------------------------------------------
 
 -- Q5: email column constraints
 
 -- email VARCHAR(100) UNIQUE NOT NULL...
 
 /* 
	• Constraints Applied:
    1. NOT NULL - Email cannot be empty
    2. UNIQUE - Duplicate emails are not allowed .
    
    • What would happen if a duplicate email is inserted?
    
    INSERT INTO customers VALUES
	(109,'Test','User','aarav.s@email.com','Mumbai','Maharashtra','2024-09-01',TRUE);
    
    The database returns an error because the email already exists in the table.
    The UNIQUE constraint prevents duplicate emails. If a duplicate email is inserted, 
    the database returns an error because each email must be unique
    
    ERROR:
    Duplicate entry for unique key 'email'
		
*/
--------------------------------------------------------------------------------------------

-- Q6: Inserting a product with unit_price = -50

-- This query is expected to fail because it is used
-- to demonstrate the CHECK constraint.

INSERT INTO products
VALUES (209,'Test Product','Electronics','TestBrand',-50,100);

-- The CHECK (unit_price > 0) constraint prevents this.

/*
When attempting to insert a product with unit_price = -50,
the query fails because the CHECK (unit_price > 0) constraint
is violated.

This constraint ensures that product prices cannot be zero or
negative, thereby maintaining valid and consistent data in the
database.
*/
----------------------------------------------------------------------------------------------
