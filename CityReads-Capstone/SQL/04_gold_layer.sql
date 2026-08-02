/* ==========================================================
   CITYREADS CAPSTONE PROJECT
   Layer : Gold Layer

   Description:
   - Creates business KPI views.
   - Calculates executive metrics.
   - Implements PASS / FAIL verdicts.
   - Creates dashboard views.
   - Creates pipeline health audit.

   Gold Layer is designed for reporting and business analytics.
   ========================================================== */


-- KPI 1 – Monthly Revenue Growth

CREATE OR REPLACE VIEW gold_monthly_revenue AS
WITH revenue_cte AS
(
    SELECT
        DATE_FORMAT(order_date,'%Y-%m') AS month,
        SUM(order_value) AS revenue
    FROM silver_orders
    WHERE status='DELIVERED'
    GROUP BY DATE_FORMAT(order_date,'%Y-%m')
)
SELECT
month,
revenue,
LAG(revenue) OVER(ORDER BY month) AS previous_month_revenue,
ROUND(
((revenue-LAG(revenue) OVER(ORDER BY month))
/
LAG(revenue) OVER(ORDER BY month))*100
,2)
AS growth_percentage,
CASE
WHEN
(
(revenue-LAG(revenue) OVER(ORDER BY month))
/
LAG(revenue) OVER(ORDER BY month)
)>0
THEN 'PASS'
ELSE 'FAIL'
END AS verdict
FROM revenue_cte;

SELECT * FROM gold_monthly_revenue;
-----------------------------------------------------------------------------------------------

-- KPI 2 – Customer Retention Rate

CREATE OR REPLACE VIEW gold_customer_retention AS
SELECT
COUNT(*) AS retained_customers,
ROUND(
COUNT(*)*100/
(SELECT COUNT(*) FROM silver_customers)
,2)
AS retention_rate,
CASE
WHEN
ROUND(
COUNT(*)*100/
(SELECT COUNT(*) FROM silver_customers)
,2)>=40
THEN 'PASS'
ELSE 'FAIL'
END AS verdict
FROM
(
SELECT customer_id
FROM silver_orders
GROUP BY customer_id
HAVING COUNT(order_id)>1
)t;

SELECT * FROM gold_customer_retention;
---------------------------------------------------------------------------------------

-- KPI 3 – Book Sell-Through Rate

CREATE OR REPLACE VIEW gold_book_sellthrough AS
SELECT
COUNT(DISTINCT book_id) books_sold,
(SELECT COUNT(*) FROM silver_books) total_books,
ROUND(
COUNT(DISTINCT book_id)*100/
(SELECT COUNT(*) FROM silver_books)
,2)
AS sell_through_rate,
CASE
WHEN
ROUND(
COUNT(DISTINCT book_id)*100/
(SELECT COUNT(*) FROM silver_books)
,2)>=70
THEN 'PASS'
ELSE 'FAIL'
END AS verdict
FROM silver_orders
WHERE status='DELIVERED';


SELECT * FROM gold_book_sellthrough;
-----------------------------------------------------------------------------------------

-- KPI 4 – Library Return Compliance

CREATE OR REPLACE VIEW gold_return_compliance AS
SELECT
COUNT(*) total_returns,
SUM(
CASE
WHEN days_overdue<=0
THEN 1
ELSE 0
END
)
AS returned_on_time,
ROUND(
SUM(
CASE
WHEN days_overdue<=0
THEN 1
ELSE 0
END
)
*100/
COUNT(*)
,2)
AS compliance_rate,
CASE
WHEN
ROUND(
SUM(
CASE
WHEN days_overdue<=0
THEN 1
ELSE 0
END
)
*100/
COUNT(*)
,2)>=90
THEN 'PASS'
ELSE 'FAIL'
END
AS verdict
FROM silver_loans;

SELECT * FROM gold_return_compliance;
----------------------------------------------------------------------------------------------

-- KPI 5 – Review Coverage

CREATE OR REPLACE VIEW gold_review_coverage AS
SELECT
COUNT(DISTINCT r.review_id) reviews,
COUNT(DISTINCT o.order_id) delivered_orders,
ROUND(
COUNT(DISTINCT r.review_id)
*100/
COUNT(DISTINCT o.order_id)
,2)
AS review_coverage,
CASE
WHEN
ROUND(
COUNT(DISTINCT r.review_id)
*100/
COUNT(DISTINCT o.order_id)
,2)>=60
THEN 'PASS'
ELSE 'FAIL'
END
AS verdict
FROM silver_orders o
LEFT JOIN silver_reviews r
ON
o.customer_id=r.customer_id
AND
o.book_id=r.book_id
WHERE o.status='DELIVERED';

SELECT * FROM gold_review_coverage;
--------------------------------------------------------------------------------------------------
/* Create Dashboard */
CREATE OR REPLACE VIEW gold_dashboard AS
SELECT
'Monthly Revenue Growth' AS KPI,
CONCAT(ROUND(AVG(growth_percentage),2),'%') AS KPI_VALUE,
'>0%' AS TARGET,
CASE
WHEN AVG(growth_percentage)>0
THEN 'PASS'
ELSE 'FAIL'
END AS VERDICT,
CASE
WHEN AVG(growth_percentage)>0
THEN '🟢 GREEN'
ELSE '🔴 RED'
END AS STATUS_COLOR
FROM gold_monthly_revenue
UNION ALL
SELECT
'Customer Retention',
CONCAT(retention_rate,'%'),
'40%',
verdict,
CASE
WHEN verdict='PASS'
THEN '🟢 GREEN'
ELSE '🔴 RED'
END
FROM gold_customer_retention
UNION ALL
SELECT
'Book Sell Through',
CONCAT(sell_through_rate,'%'),
'70%',
verdict,
CASE
WHEN verdict='PASS'
THEN '🟢 GREEN'
ELSE '🔴 RED'
END
FROM gold_book_sellthrough
UNION ALL
SELECT
'Return Compliance',
CONCAT(compliance_rate,'%'),
'90%',
verdict,
CASE
WHEN verdict='PASS'
THEN '🟢 GREEN'
ELSE '🔴 RED'
END
FROM gold_return_compliance
UNION ALL
SELECT
'Review Coverage',
CONCAT(review_coverage,'%'),
'60%',
verdict,
CASE
WHEN verdict='PASS'
THEN '🟢 GREEN'
ELSE '🔴 RED'
END
FROM gold_review_coverage; 

/* Executive Dashboard */

 SELECT * FROM gold_dashboard;
 -------------------------------------------------------------------------------------
 
--  Pipeline health...

CREATE OR REPLACE VIEW pipeline_health_audit AS

SELECT

'books' AS table_name,

(SELECT COUNT(*) FROM books) AS source_rows,

(SELECT COUNT(*) FROM bronze_books) AS bronze_rows,

(SELECT COUNT(*) FROM silver_books) AS silver_rows,

(SELECT COUNT(*)
FROM silver_rejected_rows
WHERE source_table='books') rejected_rows

UNION ALL

SELECT

'customers',

(SELECT COUNT(*) FROM customers),

(SELECT COUNT(*) FROM bronze_customers),

(SELECT COUNT(*) FROM silver_customers),

(SELECT COUNT(*)
FROM silver_rejected_rows
WHERE source_table='customers')

UNION ALL

SELECT

'orders',

(SELECT COUNT(*) FROM orders),

(SELECT COUNT(*) FROM bronze_orders),

(SELECT COUNT(*) FROM silver_orders),

(SELECT COUNT(*)
FROM silver_rejected_rows
WHERE source_table='orders')

UNION ALL

SELECT

'loans',

(SELECT COUNT(*) FROM loans),

(SELECT COUNT(*) FROM bronze_loans),

(SELECT COUNT(*) FROM silver_loans),

(SELECT COUNT(*)
FROM silver_rejected_rows
WHERE source_table='loans')

UNION ALL

SELECT

'reviews',

(SELECT COUNT(*) FROM reviews),

(SELECT COUNT(*) FROM bronze_reviews),

(SELECT COUNT(*) FROM silver_reviews),

(SELECT COUNT(*)
FROM silver_rejected_rows
WHERE source_table='reviews');


SELECT * FROM pipeline_health_audit;
---------------------------------------------------------------------------------------------------
