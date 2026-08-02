/* ==========================================================
   CITYREADS CAPSTONE PROJECT
   Layer : Source Layer

   Description:
   - Creates the CityReads database.
   - Creates all source tables.
   - Defines primary keys and foreign key relationships.
   - Imports raw CSV data into MySQL tables.
   - Verifies successful data loading.

   Tables:
   • books
   • customers
   • orders
   • loans
   • reviews
   ========================================================== */

/* Step 1 - Create Database */
CREATE DATABASE cityreads;

/* Step 2 - Select Database */
USE cityreads;

/* Step 3 - Create Source Tables */

CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    genre VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    published_on DATE
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    city VARCHAR(100),
    joined_on DATE,
    membership VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    order_date DATE,
    quantity INT,
    status VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    loan_date DATE,
    due_date DATE,
    return_date DATE,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);

CREATE TABLE reviews (
    review_id INT PRIMARY KEY,
    customer_id INT,
    book_id INT,
    rating INT,
    review_text TEXT,
    created_at DATETIME,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (book_id)
        REFERENCES books(book_id)
);

/* Step 4 - Verify Source Tables */
SHOW TABLES;

/* Step 5 - Recreate Reviews Table (Datetime Fix) */
DROP TABLE reviews;

CREATE TABLE reviews (
    review_id INT,
    customer_id INT,
    book_id INT,
    rating INT,
    review_text TEXT,
    created_at DATETIME
);

/* Step 6 - Verify Imported Data */
SELECT COUNT(*) FROM books;

SELECT COUNT(*) FROM customers;

SELECT COUNT(*) FROM orders;

SELECT COUNT(*) FROM loans;

SELECT COUNT(*) FROM reviews;