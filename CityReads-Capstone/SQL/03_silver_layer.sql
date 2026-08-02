/* ==========================================================
   CITYREADS CAPSTONE PROJECT
   Layer : Silver Layer

   Description:
   - Performs data cleansing.
   - Standardizes values.
   - Removes invalid records.
   - Creates derived columns.
   - Logs rejected rows.

   Silver Layer contains clean, analytics-ready data.
   ========================================================== */
   
/* Step 1 - Create Rejected Rows Audit Table */

CREATE TABLE silver_rejected_rows (

    id INT AUTO_INCREMENT PRIMARY KEY,

    source_table VARCHAR(50),

    record_id INT,

    rejection_reason VARCHAR(255),

    rejected_at DATETIME DEFAULT NOW()

);

/* Step 2 - Create Silver Books */

CREATE TABLE silver_books AS

SELECT *

FROM bronze_books

WHERE

price > 0

AND stock >= 0;


/* Step 3 - Log Invalid Books */

INSERT INTO silver_rejected_rows
(source_table,record_id,rejection_reason)
SELECT
'books',
book_id,
'Invalid price or stock'
FROM bronze_books
WHERE
price <=0
OR stock<0;


/* Step 4 - Create Silver Customers */

CREATE TABLE silver_customers AS

SELECT

customer_id,

TRIM(name) AS name,

TRIM(email) AS email,

TRIM(city) AS city,

joined_on,

UPPER(TRIM(membership)) AS membership,

ingested_at,

batch_id

FROM bronze_customers

WHERE

email IS NOT NULL

AND UPPER(TRIM(membership))

IN

('BASIC','PREMIUM','LIBRARY');


/* Step 5 - Log Invalid Customers */

INSERT INTO silver_rejected_rows

(source_table,record_id,rejection_reason)

SELECT

'customers',

customer_id,

'Invalid Email or Membership'

FROM bronze_customers

WHERE

email IS NULL

OR

UPPER(TRIM(membership))

NOT IN

('BASIC','PREMIUM','LIBRARY');


/* Step 6 - Create Silver Orders */

CREATE TABLE silver_orders AS

SELECT

o.order_id,

o.customer_id,

o.book_id,

o.order_date,

o.quantity,

UPPER(TRIM(o.status)) AS status,

b.price,

o.quantity*b.price AS order_value,

o.ingested_at,

o.batch_id

FROM bronze_orders o

JOIN silver_books b

ON

o.book_id=b.book_id

WHERE

quantity>0

AND

UPPER(TRIM(status))

IN

('PENDING',

'SHIPPED',

'DELIVERED',

'CANCELLED');


/* Step 7 - Log Invalid Orders */

INSERT INTO silver_rejected_rows

(source_table,record_id,rejection_reason)

SELECT

'orders',

order_id,

'Invalid Quantity or Status'

FROM bronze_orders

WHERE

quantity<=0

OR

UPPER(TRIM(status))

NOT IN

('PENDING',

'SHIPPED',

'DELIVERED',

'CANCELLED');


/* Step 8 - Create Silver Loans */

CREATE TABLE silver_loans AS

SELECT

*,

GREATEST(

DATEDIFF(

IFNULL(return_date,CURDATE()),

due_date),

0

) AS days_overdue

FROM bronze_loans

WHERE

due_date>loan_date;


/* Step 9 - Log Invalid Loans */

INSERT INTO silver_rejected_rows

(source_table,record_id,rejection_reason)

SELECT

'loans',

loan_id,

'Due Date before Loan Date'

FROM bronze_loans

WHERE

due_date<=loan_date;


/* Step 10 - Create Silver Reviews */

CREATE TABLE silver_reviews AS

SELECT *

FROM bronze_reviews

WHERE

rating

BETWEEN

1

AND

5;


/* Step 11 - Log Invalid Reviews */

INSERT INTO silver_rejected_rows

(source_table,record_id,rejection_reason)

SELECT

'reviews',

review_id,

'Invalid Rating'

FROM bronze_reviews

WHERE

rating

NOT BETWEEN

1

AND

5;


/* Step 12 - Verify Silver Layer */

SHOW TABLES;



DROP TABLE silver_customers;


CREATE TABLE silver_customers AS

SELECT
    customer_id,
    name,
    email,
    city,
    joined_on,
    UPPER(TRIM(membership)) AS membership,
    ingested_at,
    batch_id

FROM
(
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY customer_id
            ORDER BY ingested_at DESC
        ) AS rn

    FROM bronze_customers
) t

WHERE rn=1
AND email IS NOT NULL
AND UPPER(TRIM(membership))
IN ('BASIC','PREMIUM','LIBRARY');



DROP TABLE silver_books;


CREATE TABLE silver_books AS

SELECT
    book_id,
    title,
    author,
    genre,
    price,
    stock,
    published_on,
    ingested_at,
    batch_id

FROM
(
    SELECT
        *,
        ROW_NUMBER() OVER(
            PARTITION BY book_id
            ORDER BY ingested_at DESC
        ) rn

    FROM bronze_books
)t

WHERE rn=1
AND price>0
AND stock>=0;



DROP TABLE silver_orders;



CREATE TABLE silver_orders AS

SELECT

order_id,

customer_id,

book_id,

order_date,

quantity,

UPPER(TRIM(status)) status,

price,

quantity*price AS order_value,

ingested_at,

batch_id

FROM
(
SELECT

o.*,

b.price,

ROW_NUMBER() OVER(

PARTITION BY order_id

ORDER BY ingested_at DESC

) rn

FROM bronze_orders o

JOIN silver_books b

ON o.book_id=b.book_id

)x

WHERE rn=1

AND quantity>0

AND status IN

('PENDING',

'SHIPPED',

'DELIVERED',

'CANCELLED');




DROP TABLE silver_rejected_rows;



CREATE TABLE silver_rejected_rows(

id INT AUTO_INCREMENT PRIMARY KEY,

source_table VARCHAR(50),

record_id INT,

rejected_column VARCHAR(50),

invalid_value VARCHAR(255),

rejection_reason VARCHAR(255),

rejected_at DATETIME DEFAULT NOW()

);
