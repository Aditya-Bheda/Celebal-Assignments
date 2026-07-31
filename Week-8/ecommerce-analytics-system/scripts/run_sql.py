import os
import sqlite3
import pandas as pd

DATABASE_PATH = "database/ecommerce.db"

SQL_FOLDER = "sql"

OUTPUT_FOLDER = "output/sample_reports"

os.makedirs(OUTPUT_FOLDER, exist_ok=True)


sql_file = input(
    "Enter SQL file name (without .sql): "
).strip()

sql_path = os.path.join(
    SQL_FOLDER,
    f"{sql_file}.sql"
)



if not os.path.exists(sql_path):

    print("SQL file not found!")

    exit()



connection = sqlite3.connect(DATABASE_PATH)

with open(sql_path, "r") as file:

    sql_script = file.read()


queries = [

    query.strip()

    for query in sql_script.split(";")

    if query.strip()

]

for i, query in enumerate(queries, start=1):

    print("=" * 60)

    print(f"Query {i}")

    print("=" * 60)

    result = pd.read_sql(query, connection)

    print(result)

    file_name = f"{sql_file}_query_{i}.csv"

    result.to_csv(

        os.path.join(
            OUTPUT_FOLDER,
            file_name
        ),

        index=False

    )

    print(f"\nSaved -> {file_name}\n")


connection.close()

print("=" * 60)

print("All queries executed successfully.")

print("=" * 60)


