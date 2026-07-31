import os
from datetime import datetime

import pandas as pd

RAW_DATA_PATH = "data/raw"
CLEANED_DATA_PATH = "data/cleaned"

os.makedirs(CLEANED_DATA_PATH, exist_ok=True)

customers_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "customers.csv"))

products_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "products.csv"))

orders_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "orders.csv"))

order_items_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "order_items.csv"))

print("Raw datasets loaded successfully.\n")


print("Cleaning Customers...")

before = len(customers_df)

customers_df.drop_duplicates(inplace=True)

duplicates_removed = before - len(customers_df)

customers_df["email"] = customers_df["email"].fillna("unknown@example.com")

customers_df["phone"] = customers_df["phone"].fillna("0000000000")

print(f"Removed {duplicates_removed} duplicate records.")
print("Filled missing email values.")
print("Filled missing phone numbers.\n")



print("Cleaning Products...")

before = len(products_df)

products_df.drop_duplicates(inplace=True)

duplicates_removed = before - len(products_df)

products_df["brand"] = products_df["brand"].fillna("Unknown Brand")

products_df["price"] = products_df["price"].fillna(
    products_df["price"].median()
)

print(f"Removed {duplicates_removed} duplicate records.")
print("Filled missing brands.")
print("Filled missing prices.\n")


# ==========================================================
# Clean Orders
# ==========================================================

print("Cleaning Orders...")

before = len(orders_df)

# Remove duplicate records
orders_df.drop_duplicates(inplace=True)

duplicates_removed = before - len(orders_df)

# Remove invalid customer IDs
orders_df = orders_df[
    orders_df["customer_id"].isin(customers_df["customer_id"])
]

# Convert to datetime
orders_df["order_date"] = pd.to_datetime(orders_df["order_date"])

# Remove future dates
today = pd.Timestamp.today()

orders_df = orders_df[
    orders_df["order_date"] <= today
]

print(f"Removed {duplicates_removed} duplicate records.")
print("Removed invalid customer IDs.")
print("Removed future order dates.\n")



# ==========================================================
# Clean Order Items
# ==========================================================

print("Cleaning Order Items...")

before = len(order_items_df)

# Remove duplicate rows
order_items_df.drop_duplicates(inplace=True)

duplicates_removed = before - len(order_items_df)

# Remove invalid Order IDs
order_items_df = order_items_df[
    order_items_df["order_id"].isin(orders_df["order_id"])
]

# Remove invalid Product IDs
order_items_df = order_items_df[
    order_items_df["product_id"].isin(products_df["product_id"])
]

# Fill missing quantity
order_items_df["quantity"] = order_items_df["quantity"].fillna(1)

# Convert quantity to integer
order_items_df["quantity"] = order_items_df["quantity"].astype(int)

print(f"Removed {duplicates_removed} duplicate records.")
print("Removed invalid order IDs.")
print("Removed invalid product IDs.")
print("Filled missing quantity.\n")



# ==========================================================
# Save Cleaned Data
# ==========================================================

customers_df.to_csv(
    os.path.join(CLEANED_DATA_PATH, "clean_customers.csv"),
    index=False
)

products_df.to_csv(
    os.path.join(CLEANED_DATA_PATH, "clean_products.csv"),
    index=False
)

orders_df.to_csv(
    os.path.join(CLEANED_DATA_PATH, "clean_orders.csv"),
    index=False
)

order_items_df.to_csv(
    os.path.join(CLEANED_DATA_PATH, "clean_order_items.csv"),
    index=False
)

print("===========================================")
print("Data cleaning completed successfully!")
print("Cleaned files saved to data/cleaned/")
print("===========================================")


