import os
import random
from datetime import datetime, timedelta

import pandas as pd

# -----------------------------
# File Paths
# -----------------------------

RAW_DATA_PATH = "data/raw"

# -----------------------------
# Read CSV Files
# -----------------------------

customers_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "customers.csv"))
products_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "products.csv"))
orders_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "orders.csv"))
order_items_df = pd.read_csv(os.path.join(RAW_DATA_PATH, "order_items.csv"))

print("All CSV files loaded successfully.\n")

# ==========================================================
# 1. CUSTOMERS
# ==========================================================

# Add NULL emails
null_email_indices = random.sample(list(customers_df.index), 10)
customers_df.loc[null_email_indices, "email"] = None

# Add NULL phone numbers
null_phone_indices = random.sample(list(customers_df.index), 10)
customers_df.loc[null_phone_indices, "phone"] = None

# Duplicate 5 customers
duplicate_customers = customers_df.sample(5, random_state=42)
customers_df = pd.concat(
    [customers_df, duplicate_customers],
    ignore_index=True
)

print("Customers:")
print("✓ Added 10 NULL emails")
print("✓ Added 10 NULL phone numbers")
print("✓ Added 5 duplicate records\n")

# ==========================================================
# 2. PRODUCTS
# ==========================================================

# Add NULL brands
null_brand_indices = random.sample(list(products_df.index), 5)
products_df.loc[null_brand_indices, "brand"] = None

# Add NULL prices
null_price_indices = random.sample(list(products_df.index), 5)
products_df.loc[null_price_indices, "price"] = None

# Duplicate 5 products
duplicate_products = products_df.sample(5, random_state=42)
products_df = pd.concat(
    [products_df, duplicate_products],
    ignore_index=True
)

print("Products:")
print("✓ Added 5 NULL brands")
print("✓ Added 5 NULL prices")
print("✓ Added 5 duplicate records\n")

# ==========================================================
# 3. ORDERS
# ==========================================================

# Invalid Customer IDs
invalid_customer_indices = random.sample(list(orders_df.index), 20)
orders_df.loc[invalid_customer_indices, "customer_id"] = 9999

# Future Dates
future_date = (
    datetime.today() + timedelta(days=90)
).strftime("%Y-%m-%d")

future_date_indices = random.sample(list(orders_df.index), 20)
orders_df.loc[future_date_indices, "order_date"] = future_date

# Duplicate Orders
duplicate_orders = orders_df.sample(10, random_state=42)
orders_df = pd.concat(
    [orders_df, duplicate_orders],
    ignore_index=True
)

print("Orders:")
print("✓ Added 20 invalid customer IDs")
print("✓ Added 20 future dates")
print("✓ Added 10 duplicate records\n")

# ==========================================================
# 4. ORDER ITEMS
# ==========================================================

# Invalid Product IDs
invalid_product_indices = random.sample(list(order_items_df.index), 20)
order_items_df.loc[invalid_product_indices, "product_id"] = 9999

# Invalid Order IDs
invalid_order_indices = random.sample(list(order_items_df.index), 20)
order_items_df.loc[invalid_order_indices, "order_id"] = 99999

# NULL Quantity
null_quantity_indices = random.sample(list(order_items_df.index), 20)
order_items_df.loc[null_quantity_indices, "quantity"] = None

# Duplicate Order Items
duplicate_items = order_items_df.sample(10, random_state=42)
order_items_df = pd.concat(
    [order_items_df, duplicate_items],
    ignore_index=True
)

print("Order Items:")
print("✓ Added 20 invalid product IDs")
print("✓ Added 20 invalid order IDs")
print("✓ Added 20 NULL quantities")
print("✓ Added 10 duplicate records\n")

# ==========================================================
# Save Updated CSV Files
# ==========================================================

customers_df.to_csv(
    os.path.join(RAW_DATA_PATH, "customers.csv"),
    index=False
)

products_df.to_csv(
    os.path.join(RAW_DATA_PATH, "products.csv"),
    index=False
)

orders_df.to_csv(
    os.path.join(RAW_DATA_PATH, "orders.csv"),
    index=False
)

order_items_df.to_csv(
    os.path.join(RAW_DATA_PATH, "order_items.csv"),
    index=False
)

print("========================================")
print("Data inconsistencies injected successfully!")
print("Updated CSV files saved to data/raw/")
print("========================================")

