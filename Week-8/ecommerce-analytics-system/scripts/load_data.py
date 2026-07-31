import os
import sqlite3

import pandas as pd

DATABASE_FOLDER = "database"
DATABASE_NAME = "ecommerce.db"

os.makedirs(DATABASE_FOLDER, exist_ok=True)

DATABASE_PATH = os.path.join(
    DATABASE_FOLDER,
    DATABASE_NAME
)

CLEANED_DATA_PATH = "data/cleaned"
SCHEMA_PATH = "sql/schema.sql"

connection = sqlite3.connect(DATABASE_PATH)

cursor = connection.cursor()

print("SQLite database connected.")

with open(SCHEMA_PATH, "r") as file:

    cursor.executescript(file.read())

connection.commit()

print("Database schema created successfully.")


customers_df = pd.read_csv(
    os.path.join(
        CLEANED_DATA_PATH,
        "clean_customers.csv"
    )
)

products_df = pd.read_csv(
    os.path.join(
        CLEANED_DATA_PATH,
        "clean_products.csv"
    )
)

orders_df = pd.read_csv(
    os.path.join(
        CLEANED_DATA_PATH,
        "clean_orders.csv"
    )
)

order_items_df = pd.read_csv(
    os.path.join(
        CLEANED_DATA_PATH,
        "clean_order_items.csv"
    )
)

print("Cleaned CSV files loaded.")


customers_df.to_sql(
    "customers",
    connection,
    if_exists="replace",
    index=False
)

products_df.to_sql(
    "products",
    connection,
    if_exists="replace",
    index=False
)

orders_df.to_sql(
    "orders",
    connection,
    if_exists="replace",
    index=False
)

order_items_df.to_sql(
    "order_items",
    connection,
    if_exists="replace",
    index=False
)

print("All tables loaded successfully.")



connection.commit()

connection.close()

print("-------------------------------------")
print("SQLite Database Created Successfully!")
print("Database saved as database/ecommerce.db")
print("-------------------------------------")


