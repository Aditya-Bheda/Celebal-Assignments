/* ==========================================================
   CITYREADS CAPSTONE PROJECT
   Layer : Bronze Layer

   Description:
   - Creates pipeline metadata table.
   - Creates Bronze tables.
   - Performs initial raw data ingestion.
   - Adds ingestion timestamp and batch ID.
   - Updates pipeline metadata after successful loading.

   Bronze Layer stores raw, unmodified data.
   ========================================================== */

/* Step 1 - Create Pipeline Metadata Table */      

CREATE TABLE pipeline_metadata (

    table_name VARCHAR(100) PRIMARY KEY,

    last_loaded_at DATETIME DEFAULT '2000-01-01 00:00:00',

    rows_loaded INT DEFAULT 0,

    status VARCHAR(20) DEFAULT 'PENDING'

);

/* Step 2 - Initialize Pipeline Metadata */

INSERT INTO pipeline_metadata(table_name)

VALUES

('books'),

('customers'),

('orders'),

('loans'),

('reviews');


SELECT * FROM pipeline_metadata;


/* Step 3 - Create Bronze Tables */

CREATE TABLE bronze_books AS
SELECT
    *,
    NOW() AS ingested_at,
    'BATCH_001' AS batch_id
FROM books
WHERE 1 = 0;


CREATE TABLE bronze_customers AS
SELECT
    *,
    NOW() AS ingested_at,
    'BATCH_001' AS batch_id
FROM customers
WHERE 1 = 0;


CREATE TABLE bronze_orders AS
SELECT
    *,
    NOW() AS ingested_at,
    'BATCH_001' AS batch_id
FROM orders
WHERE 1 = 0;


CREATE TABLE bronze_loans AS
SELECT
    *,
    NOW() AS ingested_at,
    'BATCH_001' AS batch_id
FROM loans
WHERE 1 = 0;



CREATE TABLE bronze_reviews AS
SELECT
    *,
    NOW() AS ingested_at,
    'BATCH_001' AS batch_id
FROM reviews
WHERE 1 = 0;


/* Step 4 - Verify Bronze Tables */
SHOW TABLES;


/* Step 5 - Initial Bronze Data Load */

INSERT INTO bronze_books
SELECT
    *,
    NOW() AS ingested_at,
    'BATCH_001' AS batch_id
FROM books;

SELECT COUNT(*) FROM bronze_books;


/* Step 6 - Update Pipeline Metadata */

UPDATE pipeline_metadata
SET
    rows_loaded = (SELECT COUNT(*) FROM bronze_books),
    last_loaded_at = NOW(),
    status = 'SUCCESS'
WHERE table_name = 'books';



INSERT INTO bronze_customers
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM customers;

UPDATE pipeline_metadata
SET
    rows_loaded = (SELECT COUNT(*) FROM bronze_customers),
    last_loaded_at = NOW(),
    status = 'SUCCESS'
WHERE table_name = 'customers';


INSERT INTO bronze_orders
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM orders;

UPDATE pipeline_metadata
SET
    rows_loaded = (SELECT COUNT(*) FROM bronze_orders),
    last_loaded_at = NOW(),
    status = 'SUCCESS'
WHERE table_name = 'orders';


INSERT INTO bronze_loans
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM loans;

UPDATE pipeline_metadata
SET
    rows_loaded = (SELECT COUNT(*) FROM bronze_loans),
    last_loaded_at = NOW(),
    status = 'SUCCESS'
WHERE table_name = 'loans';


INSERT INTO bronze_reviews
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM reviews;

UPDATE pipeline_metadata
SET
    rows_loaded = (SELECT COUNT(*) FROM bronze_reviews),
    last_loaded_at = NOW(),
    status = 'SUCCESS'
WHERE table_name = 'reviews';


/* Step 7 - Verify Bronze Layer */

SELECT * FROM pipeline_metadata;


TRUNCATE TABLE bronze_books;
TRUNCATE TABLE bronze_customers;
TRUNCATE TABLE bronze_orders;
TRUNCATE TABLE bronze_loans;
TRUNCATE TABLE bronze_reviews;	

-- UPDATE pipeline_metadata
-- SET
--     rows_loaded = 0,
--     status = 'PENDING',
--     last_loaded_at = '2000-01-01 00:00:00';
--     
--     


INSERT INTO bronze_books
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM books
WHERE NOT EXISTS
(
    SELECT 1
    FROM bronze_books
);



INSERT INTO bronze_customers
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM customers
WHERE NOT EXISTS
(
    SELECT 1
    FROM bronze_customers
);



INSERT INTO bronze_orders
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM orders
WHERE NOT EXISTS
(
    SELECT 1
    FROM bronze_orders
);



INSERT INTO bronze_loans
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM loans
WHERE NOT EXISTS
(
    SELECT 1
    FROM bronze_loans
);



INSERT INTO bronze_reviews
SELECT
    *,
    NOW(),
    'BATCH_001'
FROM reviews
WHERE NOT EXISTS
(
    SELECT 1
    FROM bronze_reviews
);
