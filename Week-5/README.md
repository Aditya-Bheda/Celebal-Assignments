# Week 5 - Apache Spark Data Cleaning and Transformation

## Objective

The objective of this assignment is to understand Apache Spark fundamentals and perform data cleaning, transformation, filtering, and aggregation using PySpark DataFrames.

## Technologies Used

- Python
- PySpark
- Apache Spark
- Jupyter Notebook
- Pandas

## Dataset

The dataset contains 300,000 records related to sales and user transactions.

Main columns include:

- user_id
- transaction_date
- region
- product_category
- sale_amount
- status
- city
- age
- subscription
- raw_timestamp
- email
- username
- price
- store_id
- quantity

## Data Processing Steps

1. Created a SparkSession.
2. Loaded the CSV dataset into a Spark DataFrame.
3. Inspected the DataFrame schema and columns.
4. Removed duplicate records.
5. Handled null and empty values.
6. Removed inconsistent timestamp values.
7. Applied filtering conditions.
8. Renamed columns and changed data types.
9. Performed aggregate operations using count, sum, avg, min, and max.
10. Grouped data using groupBy().
11. Calculated total revenue for each store.
12. Saved the final aggregated results as a CSV file.

## Spark Concepts Covered

- SparkSession
- Spark DataFrames
- DataFrame Immutability
- Data Cleaning
- Null Handling
- Duplicate Removal
- Filtering
- Schema Modification
- Aggregation
- GroupBy
- Wide Transformations
- Shuffle Operations

## Project Structure

spark-assignment/
│── Data/
│   └── ecommerce_dataset.csv
│── Notebook/
│   └── spark_basics.ipynb
│── Output/
│   └── store_revenue_results.csv
│── README.md

## Key Insights

Spark DataFrames are immutable and transformations return new DataFrames. GroupBy operations may cause shuffle because data is redistributed across partitions. Data cleaning before aggregation improves the quality and accuracy of analytical results.

## Conclusion

This assignment demonstrates a complete PySpark data processing pipeline involving data loading, cleaning, filtering, transformation, aggregation, and result generation.