# 📚 CityReads – Online Bookstore & Library Management Data Pipeline


---

# 📖 Project Overview

This capstone project was developed as part of the **Celebal Technologies Summer Internship Program**.

The objective is to design and implement a **production-style data pipeline** for the fictional online bookstore **CityReads** using the **Medallion Architecture (Bronze → Silver → Gold)**.

The pipeline ingests raw CSV files, performs incremental-style ingestion, applies data quality validations, cleans and transforms data, generates business-ready KPI views, and provides an executive reporting layer.

---

# 🎯 Project Objectives

The project demonstrates an end-to-end SQL-based Data Engineering workflow by implementing:

- Source Layer using MySQL
- Bronze Layer for raw data ingestion
- Silver Layer for data cleaning and validation
- Gold Layer for business analytics
- Pipeline Metadata Management
- Pipeline Health Audit
- Executive KPI Views
- Medallion Architecture
- SQL Views for Reporting

---

# 🏗 Medallion Architecture

```
                Raw CSV Files
                      │
                      ▼
              Source Layer (MySQL)
                      │
                      ▼
               Bronze Layer
         (Raw + Batch Information)
                      │
                      ▼
               Silver Layer
        (Clean & Validated Data)
                      │
                      ▼
                 Gold Layer
         (Business KPI Views)
                      │
                      ▼
           Dashboard / Reporting
```

---

# 📂 Project Structure

```
CityReads-Capstone/

│
├── Dataset/
│      books.csv
│      customers.csv
│      orders.csv
│      loans.csv
│      reviews.csv
│
├── SQL/
│      01_source_layer.sql
│      02_bronze_layer.sql
│      03_silver_layer.sql
│      04_gold_layer.sql
│
├── Documentation/
│      ER_Diagram.png
│      Pipeline_Architecture.png 
│
├── Screenshots/
│
├── README.md

```

---

# 🗄 Dataset

The dataset contains five relational tables.

| Table | Description |
|---------|-------------|
| Books | Book information |
| Customers | Customer details |
| Orders | Book purchase history |
| Loans | Library loan transactions |
| Reviews | Customer reviews |

---

# ⚙ Technologies Used

- MySQL Workbench
- SQL
- Medallion Architecture
- Window Functions
- Views
- Aggregate Functions
- CASE Expressions

---

# 🟤 Source Layer

The Source Layer stores raw data exactly as received from CSV files.

### Tables

- Books
- Customers
- Orders
- Loans
- Reviews

Main Tasks

- Database creation
- Table creation
- CSV import
- Primary Keys
- Foreign Keys
- Data verification

---

# 🟫 Bronze Layer

The Bronze Layer stores raw ingested data without transformations.

### Features

- Raw Data Storage
- Batch Tracking
- Ingestion Timestamp
- Pipeline Metadata
- Initial Incremental Load Simulation

### Bronze Tables

- bronze_books
- bronze_customers
- bronze_orders
- bronze_loans
- bronze_reviews

---

## Pipeline Metadata

Pipeline metadata stores information about every ingestion process.

Fields

- Table Name
- Last Loaded Timestamp
- Rows Loaded
- Status

---

# ⚪ Silver Layer

The Silver Layer performs all data cleansing operations.

## Data Quality Rules

### Books

- Price must be greater than zero
- Stock cannot be negative

### Customers

- Email cannot be NULL
- Membership values standardized

### Orders

- Quantity must be greater than zero
- Status standardized

### Loans

- Due Date must be after Loan Date
- Days Overdue calculated

### Reviews

- Rating must be between 1 and 5

---

## Silver Layer Features

- Data Cleaning
- Standardization
- Derived Columns
- Validation Rules
- Rejected Row Logging
- Window Functions (ROW_NUMBER)

---

# 🥇 Gold Layer

The Gold Layer contains business-ready SQL views.

---

## KPI 1

### Monthly Revenue Growth

Measures monthly revenue generated from delivered orders.

---

## KPI 2

### Customer Retention Rate

Percentage of customers who placed more than one order.

---

## KPI 3

### Book Sell Through Rate

Percentage of books sold compared to total available books.

---

## KPI 4

### Library Return Compliance

Percentage of books returned on or before the due date.

---

## KPI 5

### Review Coverage

Percentage of delivered orders that received customer reviews.

---

# 🚦 PASS / FAIL Evaluation

Each KPI is compared against predefined business targets.

| KPI | Target |
|------|---------|
| Revenue Growth | Positive Growth |
| Customer Retention | ≥ 40% |
| Sell Through Rate | ≥ 70% |
| Return Compliance | ≥ 90% |
| Review Coverage | ≥ 60% |

---

# 🏥 Pipeline Health Audit

A dedicated audit view monitors the overall health of the pipeline.

Metrics include:

- Source Rows
- Bronze Rows
- Silver Rows
- Rejected Rows

This provides a single-query snapshot of the entire pipeline.


# 📑 ER Diagram


<img width="812" height="1112" alt="ER_Diagram drawio" src="https://github.com/user-attachments/assets/f291b538-d2c2-4189-840a-3e37561b95cf" />


---

# 🔄 Pipeline Architecture
<img width="312" height="1292" alt="Pipeline_Architecture" src="https://github.com/user-attachments/assets/0bffb180-95b3-4d47-ab8b-3f20e4d8c6ea" />


---

# 🚀 How to Execute the Project

Execute SQL files in the following order.

```
01_source_layer.sql

↓

02_bronze_layer.sql

↓

03_silver_layer.sql

↓

04_gold_layer.sql
```

---


