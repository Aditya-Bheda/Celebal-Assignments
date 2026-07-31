-- Enable Foreign Keys
PRAGMA foreign_keys = ON;

-- Customers Table
CREATE TABLE IF NOT EXISTS customers (

    customer_id INTEGER PRIMARY KEY,

    first_name TEXT NOT NULL,

    last_name TEXT NOT NULL,

    email TEXT,

    phone TEXT,

    gender TEXT,

    city TEXT,

    state TEXT,

    registration_date DATE

);

-- Products Table
CREATE TABLE IF NOT EXISTS products (

    product_id INTEGER PRIMARY KEY,

    product_name TEXT NOT NULL,

    category TEXT,

    brand TEXT,

    price REAL,

    stock_quantity INTEGER

);

-- Orders Table
CREATE TABLE IF NOT EXISTS orders (

    order_id INTEGER PRIMARY KEY,

    customer_id INTEGER,

    order_date DATE,

    payment_method TEXT,

    order_status TEXT,

    FOREIGN KEY(customer_id)
    REFERENCES customers(customer_id)

);

-- Order Items Table
CREATE TABLE IF NOT EXISTS order_items (

    order_item_id INTEGER PRIMARY KEY,

    order_id INTEGER,

    product_id INTEGER,

    quantity INTEGER,

    unit_price REAL,

    FOREIGN KEY(order_id)
    REFERENCES orders(order_id),

    FOREIGN KEY(product_id)
    REFERENCES products(product_id)

);