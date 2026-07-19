# Week 6 - Apache Spark Assignment

## Objective
Understand Apache Spark architecture and perform efficient data processing using PySpark.

## Technologies Used
- Python
- PySpark
- Google Colab
- Apache Spark 4.0.3

## Tasks Performed
- Created SparkSession
- Read CSV file with inferSchema and header
- Displayed schema and data
- Selected required columns
- Filtered completed orders
- Renamed columns
- Cast data types
- Added new columns (final_price, total_amount)
- Handled null values
- Applied transformations and actions
- Performed groupBy aggregation
- Cached DataFrame
- Saved output in CSV and Parquet formats
- Read Parquet file and verified output
- Displayed summary statistics
- Checked number of partitions

## Execution Results
- Successfully processed the dataset using PySpark.
- Generated output in CSV format.
- Generated output in Parquet format.
- Verified schema and data after transformations.
- Aggregated category-wise statistics successfully.

## Performance & Architecture Insights
- Spark uses Lazy Evaluation, executing transformations only when an action is called.
- Driver creates jobs and coordinates execution across executors.
- Data is processed in parallel using partitions, improving scalability.
- Parquet is more efficient than CSV because it is columnar, compressed, and supports predicate pushdown.
- Cache improves performance when the same DataFrame is reused multiple times.
- Avoiding collect() on large datasets prevents excessive Driver memory usage.

## Conclusion
This assignment demonstrated the complete Spark data processing pipeline, including reading data, applying transformations, performing aggregations, optimizing execution, and writing results in multiple formats.