import os
import sqlite3
import pandas as pd

DATABASE_PATH = "database/ecommerce.db"
SQL_FOLDER = "sql"
OUTPUT_FOLDER = "output/sample_reports"

os.makedirs(OUTPUT_FOLDER, exist_ok=True)


def execute_sql_file(file_name):

    sql_path = os.path.join(SQL_FOLDER, file_name)

    if not os.path.exists(sql_path):
        print("SQL file not found.")
        return

    connection = sqlite3.connect(DATABASE_PATH)

    with open(sql_path, "r") as file:
        sql_script = file.read()

    queries = [
        query.strip()
        for query in sql_script.split(";")
        if query.strip()
    ]

    for i, query in enumerate(queries, start=1):

        print("\n" + "=" * 70)
        print(f"Query {i}")
        print("=" * 70)

        result = pd.read_sql(query, connection)

        print(result)

        output_file = f"{os.path.splitext(file_name)[0]}_query_{i}.csv"

        result.to_csv(
            os.path.join(OUTPUT_FOLDER, output_file),
            index=False
        )

        print(f"\nReport Saved : {output_file}")

    connection.close()

    print("\nCompleted Successfully!\n")


while True:

    print("=" * 50)
    print("      E-Commerce Analytics Dashboard")
    print("=" * 50)

    print("1. Aggregation Reports")
    print("2. Window Function Reports")
    print("3. Cohort Analysis")
    print("4. Customer Segmentation")
    print("5. Exit")

    choice = input("\nEnter your choice : ")

    if choice == "1":
        execute_sql_file("aggregations.sql")

    elif choice == "2":
        execute_sql_file("window_functions.sql")

    elif choice == "3":
        execute_sql_file("cohort_analysis.sql")

    elif choice == "4":
        execute_sql_file("customer_segmentation.sql")

    elif choice == "5":
        print("\nThank you for using the system!")
        break

    else:
        print("\nInvalid Choice! Try Again.\n")