import os
import random
from datetime import datetime, timedelta

import numpy as np
import pandas as pd
from faker import Faker

fake = Faker("en_IN")

RAW_DATA_PATH = "data/raw"

os.makedirs(RAW_DATA_PATH, exist_ok=True)

NUM_CUSTOMERS = 500
NUM_PRODUCTS = 150
NUM_ORDERS = 5000
# NUM_ORDER_ITEMS = 12000


# -----------------------------
# Generate Customers
# -----------------------------

customers = []

for customer_id in range(1001, 1001 + NUM_CUSTOMERS):

    customers.append({

        "customer_id": customer_id,

        "first_name": fake.first_name(),

        "last_name": fake.last_name(),

        "email": fake.email(),

        "phone": str(random.randint(6000000000, 9999999999)),

        "gender": random.choice(["Male", "Female"]),

        "city": fake.city(),

        "state": fake.state(),

        "registration_date": fake.date_between(
            start_date="-3y",
            end_date="today"
        )

    })

customers_df = pd.DataFrame(customers)

customers_df.to_csv(
    os.path.join(RAW_DATA_PATH, "customers.csv"),
    index=False
)

print("customers.csv created successfully!")


# -----------------------------
# Generate Products
# -----------------------------

products_catalog = {
    "Electronics": [
        "Laptop", "Smartphone", "Tablet", "Smart Watch",
        "Bluetooth Speaker", "Headphones", "Power Bank",
        "Monitor", "Keyboard", "Mouse"
    ],

    "Fashion": [
        "T-Shirt", "Jeans", "Running Shoes", "Jacket",
        "Handbag", "Sunglasses", "Sneakers",
        "Kurta", "Watch", "Cap"
    ],

    "Home & Kitchen": [
        "Mixer Grinder", "Pressure Cooker", "Dining Set",
        "Water Bottle", "Vacuum Cleaner", "Gas Stove",
        "Rice Cooker", "Knife Set", "Microwave", "Air Fryer"
    ],

    "Books": [
        "Python Programming", "SQL Basics",
        "Data Engineering", "Machine Learning",
        "Atomic Habits", "Rich Dad Poor Dad",
        "The Alchemist", "Clean Code"
    ],

    "Sports": [
        "Cricket Bat", "Football", "Badminton Racket",
        "Yoga Mat", "Dumbbells", "Tennis Ball",
        "Cricket Gloves", "Helmet"
    ]
}


brands = [
    "Apple", "Samsung", "Sony", "Nike", "Adidas",
    "Puma", "Boat", "HP", "Dell", "Lenovo",
    "Godrej", "Philips", "Prestige", "LG",
    "Amazon Basics", "Penguin"
]


products = []

for product_id in range(1, NUM_PRODUCTS + 1):

    category = random.choice(list(products_catalog.keys()))

    product_name = random.choice(products_catalog[category])

    products.append({

        "product_id": product_id,

        "product_name": product_name,

        "category": category,

        "brand": random.choice(brands),

        "price": random.randint(200, 100000),

        "stock_quantity": random.randint(10, 500)

    })


products_df = pd.DataFrame(products)

products_df.to_csv(
    os.path.join(RAW_DATA_PATH, "products.csv"),
    index=False
)

print("products.csv created successfully!")


# -----------------------------
# Generate Orders
# -----------------------------

payment_methods = [
    "UPI",
    "Credit Card",
    "Debit Card",
    "Net Banking",
    "Cash on Delivery"
]

order_status = [
    "Delivered",
    "Pending",
    "Cancelled",
    "Returned"
]

orders = []

for order_id in range(5001, 5001 + NUM_ORDERS):

    orders.append({

        "order_id": order_id,

        "customer_id": random.randint(1001, 1000 + NUM_CUSTOMERS),

        "order_date": fake.date_between(
            start_date="-2y",
            end_date="today"
        ),

        "payment_method": random.choice(payment_methods),

        "order_status": random.choice(order_status)

    })


orders_df = pd.DataFrame(orders)

orders_df.to_csv(
    os.path.join(RAW_DATA_PATH, "orders.csv"),
    index=False
)

print("orders.csv created successfully!")


# -----------------------------
# Generate Order Items
# -----------------------------

order_items = []
order_item_id = 1

# Create 1 to 5 items for every order
for order_id in range(5001, 5001 + NUM_ORDERS):

    # Every order will contain 1-5 products
    number_of_items = random.randint(1, 5)

    # Prevent duplicate products in the same order
    selected_products = random.sample(
        range(1, NUM_PRODUCTS + 1),
        number_of_items
    )

    for product_id in selected_products:

        product_price = products_df.loc[
            products_df["product_id"] == product_id,
            "price"
        ].values[0]

        order_items.append({

            "order_item_id": order_item_id,

            "order_id": order_id,

            "product_id": product_id,

            "quantity": random.randint(1, 5),

            "unit_price": product_price

        })

        order_item_id += 1

order_items_df = pd.DataFrame(order_items)

order_items_df.to_csv(
    os.path.join(RAW_DATA_PATH, "order_items.csv"),
    index=False
)

print("order_items.csv created successfully!")