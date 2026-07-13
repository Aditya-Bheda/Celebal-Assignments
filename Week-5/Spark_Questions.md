Q1: What are the key limitations of traditional MapReduce that make Spark a preferred choice for modern big data processing?

Answer:

Traditional MapReduce performs frequent disk read and write operations, which makes processing slower. It is also difficult to use for iterative processing and requires more code. Apache Spark uses in-memory processing, provides DataFrame APIs, and supports faster and easier big data processing.


Q2: Explain how Spark uses In-Memory Computing to speed up iterative machine learning algorithms compared to disk-based systems.

Answer:

Spark stores intermediate data in memory instead of repeatedly reading and writing data to disk. Iterative machine learning algorithms reuse the same dataset multiple times. Keeping data in memory reduces disk I/O and improves processing speed.



Q3: Write a code snippet to remove all duplicate rows from a DataFrame based on a specific set of columns: user_id and transaction_date.

Answer:

df_clean = df.dropDuplicates(["user_id", "transaction_date"])

df_clean.show()

The dropDuplicates() function removes duplicate records based on the specified columns.



Q4: Given a DataFrame df_sales, write a query to filter for rows where the region is 'West' and then group by product_category to find the average sale_amount.

Answer:

from pyspark.sql.functions import avg

result = df_sales.filter(
    df_sales["region"] == "West"
).groupBy("product_category").agg(
    avg("sale_amount").alias("average_sale_amount")
)

result.show()

This filters West region records and calculates the average sale amount for each product category.



Q5: What is the difference between .na.drop() and .na.fill()? Provide a code example of filling null values in a status column with the string 'Unknown'.

Answer:

.na.drop() removes rows containing null values, whereas .na.fill() replaces null values with a specified value.

df = df.na.fill({"status": "Unknown"})

This replaces null values in the status column with "Unknown".



Q6: Write a query to find the total count of records for each city in a DataFrame, but only for cities where the count is greater than 100.

Answer:

from pyspark.sql.functions import count

city_count = df.groupBy("city").agg(
    count("*").alias("total_records")
).filter(
    col("total_records") > 100
)

city_count.show()

The DataFrame is grouped by city and only cities having more than 100 records are displayed.



Q7: How does the immutability of Spark DataFrames affect how you perform data cleaning steps like dropping columns or renaming them?

Answer:

Spark DataFrames are immutable, which means the original DataFrame cannot be modified directly. Operations such as dropping or renaming columns create a new DataFrame.

df_new = df.drop("quantity")

df_new = df_new.withColumnRenamed(
    "sale_amount",
    "sales"
)

Therefore, the result of a transformation should be assigned to a DataFrame.



Q8: Write a Spark command to filter a dataset for rows where the age is between 18 and 30 inclusive and the subscription is 'Premium'.

Answer:

premium_users = df.filter(
    (col("age").between(18, 30)) &
    (col("subscription") == "Premium")
)

premium_users.show()

The between() function filters users aged between 18 and 30 inclusive.



Q9: When cleaning a dataset, why is it often better to handle null values before performing mathematical aggregations like sum() or avg()?

Answer:

Null values can affect data quality and may lead to incomplete or misleading aggregation results. Handling null values before aggregation provides more consistent and reliable calculations.

For example:

df = df.na.fill({"price": 0})

The cleaned data can then be safely used for aggregation.



Q10: Write the code to revise a column named raw_timestamp by casting it to a TimestampType and renaming it to event_time.

Answer:

from pyspark.sql.types import TimestampType

df = df.withColumn(
    "raw_timestamp",
    col("raw_timestamp").cast(TimestampType())
)

df = df.withColumnRenamed(
    "raw_timestamp",
    "event_time"
)

The column is first converted to TimestampType and then renamed to event_time.



Q11: Explain the "Shuffle" process that occurs during a grouping operation. Why is it considered a wide transformation?

Answer:

Shuffle is the process of redistributing data across Spark partitions. During a groupBy() operation, records with the same key may exist in different partitions and must be moved to the same partition.

It is considered a wide transformation because data from multiple input partitions may be transferred to multiple output partitions. Shuffle can increase network and disk operations.




Q12: Write a code snippet that identifies and removes rows where the email column contains null values OR the username is an empty string.

Answer:

df_clean = df.filter(
    col("email").isNotNull() &
    (col("username") != "")
)

df_clean.show()

This removes records where the email is null or the username is empty.




Q13: How do you use the .agg() function to calculate multiple statistics at once, such as the min, max, and mean of the price column?

Answer:

from pyspark.sql.functions import min, max, avg

df.agg(
    min("price").alias("minimum_price"),
    max("price").alias("maximum_price"),
    avg("price").alias("average_price")
).show()

The .agg() function allows multiple aggregate calculations to be performed together.




Q14: In the context of cleaning a dataset, what is the risk of using inferSchema=True when your source data contains messy or inconsistent date formats?

Answer:

When inferSchema=True is used, Spark automatically determines column data types based on the input data. Inconsistent date formats may cause Spark to infer the column as a string instead of a date or timestamp.

This can create schema issues and incorrect processing. Defining an explicit schema is safer for inconsistent datasets.




Q15: Write a final processing pipeline that:
Filters out duplicates.
Fills null prices with 0.
Groups by store_id to calculate total revenue.

Answer:

from pyspark.sql.functions import sum

final_result = df.dropDuplicates() \
    .na.fill({"price": 0}) \
    .groupBy("store_id") \
    .agg(
        sum("price").alias("total_revenue")
    )

final_result.show()

This pipeline removes duplicate records, replaces null prices with 0, groups records by store_id, and calculates the total revenue for each store.

