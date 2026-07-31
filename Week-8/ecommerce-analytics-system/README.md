# 🛒 E-Commerce Order Analytics System

A complete end-to-end **E-Commerce Order Analytics System** built using **Python, Pandas, SQLite, and SQL**. This project demonstrates the complete data engineering workflow, starting from realistic data generation to data cleaning, database loading, SQL analytics, and report generation.

---

# 📌 Project Objective

The objective of this project is to design and develop an end-to-end analytics pipeline for an e-commerce business.

The project covers the complete lifecycle of data engineering:

- Generate realistic datasets using Python
- Introduce real-world data quality issues
- Clean and validate the datasets
- Load cleaned data into a SQLite database
- Perform SQL analytics using Joins, Aggregations, Window Functions, and Cohort Analysis
- Generate business reports automatically
- Provide an interactive CLI for executing reports

---

# 🏗️ Project Architecture

```
                 Generate Data
                       │
                       ▼
               Raw CSV Files
                       │
                       ▼
          Inject Data Quality Issues
                       │
                       ▼
              Data Cleaning (Pandas)
                       │
                       ▼
             Cleaned CSV Files
                       │
                       ▼
              SQLite Database
                       │
                       ▼
             SQL Analytics Queries
                       │
                       ▼
              CSV Business Reports
                       │
                       ▼
          Command Line Report System
```

---

# 📂 Project Structure

```
ecommerce-analytics-system/
│
├── data/
│   ├── raw/
│   │   ├── customers.csv
│   │   ├── products.csv
│   │   ├── orders.csv
│   │   └── order_items.csv
│   │
│   └── cleaned/
│       ├── clean_customers.csv
│       ├── clean_products.csv
│       ├── clean_orders.csv
│       └── clean_order_items.csv
│
├── database/
│   └── ecommerce.db
│
├── scripts/
│   ├── generate_data.py
│   ├── inject_errors.py
│   ├── clean_data.py
│   ├── load_data.py
│   ├── run_sql.py
│   └── report_cli.py
│
├── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   ├── cohort_analysis.sql
│   └── customer_segmentation.sql
│
├── output/
│   └── sample_reports/
│
└── README.md
```

---

# 🛠️ Technologies Used

- Python
- Pandas
- Faker
- SQLite
- SQL
- VS Code

---

# 📊 Dataset Information

The project contains four relational datasets.

## Customers

Contains customer information.

Columns:

- customer_id
- first_name
- last_name
- email
- phone
- gender
- city
- state
- registration_date

---

## Products

Contains product details.

Columns:

- product_id
- product_name
- category
- brand
- price
- stock_quantity

---

## Orders

Contains order information.

Columns:

- order_id
- customer_id
- order_date
- payment_method
- order_status

---

## Order Items

Contains product-level details for every order.

Columns:

- order_item_id
- order_id
- product_id
- quantity
- unit_price

---

# ⚙️ Project Workflow

## Step 1 – Generate Realistic Data

Python was used to generate realistic e-commerce datasets.

Features:

- Random customer generation
- Product catalog generation
- Multiple orders per customer
- Multiple products per order

Generated Files:

- customers.csv
- products.csv
- orders.csv
- order_items.csv

---

## Step 2 – Inject Data Quality Issues

To simulate real-world datasets, intentional inconsistencies were introduced.

Injected Issues:

- Missing values
- Duplicate records
- Invalid customer IDs
- Invalid product IDs
- Invalid order IDs
- Future order dates

---

## Step 3 – Data Cleaning

Pandas was used to clean the datasets.

Cleaning Operations:

- Remove duplicate records
- Handle missing values
- Fill missing phone numbers
- Fill missing email addresses
- Fill missing brands
- Fill missing prices
- Remove invalid customer IDs
- Remove invalid order IDs
- Remove invalid product IDs
- Remove future dates
- Validate referential integrity

The cleaned datasets are stored inside:

```
data/cleaned/
```

---

## Step 4 – SQLite Database

The cleaned datasets are loaded into SQLite.

Database includes:

- Primary Keys
- Foreign Keys
- Relational Schema

Database File:

```
database/ecommerce.db
```

---

# 📈 SQL Analytics

The project includes multiple SQL analysis modules.

## Aggregation Queries

- Total Customers
- Total Orders
- Total Products
- Revenue by Category
- Revenue by Brand
- Top Selling Products
- Average Order Value
- Orders by Payment Method

---

## Window Functions

Implemented using:

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LEAD()
- LAG()
- SUM() OVER()

Business Use Cases:

- Product Ranking
- Running Revenue
- Previous Order Comparison
- Next Order Comparison
- Top Customer Per State

---

## Cohort Analysis

Performed:

- First Purchase Month
- Monthly Active Customers
- Cohort Size
- Monthly Revenue
- Customer Lifetime Value

---

## Customer Segmentation

Customers are classified into:

- High Value Customers
- Medium Value Customers
- Low Value Customers

Reports include:

- Top Customers
- Average Order Value
- Total Spending
- Order Frequency

---

# 📑 Generated Reports

All reports are automatically generated inside:

```
output/sample_reports/
```

Examples:

- Revenue by Category
- Revenue by Brand
- Window Function Reports
- Cohort Analysis
- Customer Segmentation

---

# 💻 Command Line Interface

The project includes an interactive CLI.

```
=========================================
     E-Commerce Analytics Dashboard
=========================================

1. Aggregation Reports
2. Window Function Reports
3. Cohort Analysis
4. Customer Segmentation
5. Exit
```

The CLI automatically executes SQL queries and exports the results as CSV reports.

---

# 🚀 How to Run

## Clone Repository

```bash
git clone <repository-url>
```

---

## Create Virtual Environment

```bash
python -m venv venv
```

Activate

Windows

```bash
venv\Scripts\activate
```

---

## Install Dependencies

```bash
pip install pandas faker
```

---

## Generate Raw Data

```bash
python scripts/generate_data.py
```

---

## Inject Errors

```bash
python scripts/inject_errors.py
```

---

## Clean Data

```bash
python scripts/clean_data.py
```

---

## Load SQLite Database

```bash
python scripts/load_data.py
```

---

## Run SQL Queries

```bash
python scripts/run_sql.py
```

Choose one of the available SQL modules.

---

## Run CLI Dashboard

```bash
python scripts/report_cli.py
```

---

# 📚 Learning Outcomes

Through this project, the following concepts were implemented:

- Data Generation using Python
- Data Cleaning with Pandas
- Data Validation
- Referential Integrity
- SQLite Database Design
- SQL Joins
- SQL Aggregations
- Window Functions
- Cohort Analysis
- Customer Segmentation
- Report Generation
- Command Line Interface Development

---

# 🔮 Future Enhancements

Possible improvements include:

- Interactive Dashboard using Streamlit or Power BI
- Automated ETL Pipeline
- REST API Integration
- Scheduled Data Refresh
- Cloud Database Integration
- Apache Spark Implementation
- Azure Databricks Pipeline

---
