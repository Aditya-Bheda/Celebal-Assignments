# Week-7: Delta Lake Data Cleaning using Databricks

## 📌 Objective

The objective of this assignment is to understand how to use Databricks with Apache Spark for data cleaning and Delta Lake operations. The assignment demonstrates reading data from a CSV file, performing data quality checks, cleaning the dataset, storing it as a Delta Table, and validating the final output.

---

## 🛠️ Tools & Technologies

- Databricks Free Edition
- Apache Spark (PySpark)
- Delta Lake
- Python
- CSV Dataset

---

## 📂 Dataset

**Dataset Name:** `customer_master.csv`

The dataset contains customer information with the following columns:

- customer_id
- name
- city
- age
- email

The dataset contains approximately **10,000 customer records** with intentionally inserted:

- NULL values
- Duplicate records
- Invalid age values

These issues were added to demonstrate real-world data cleaning.

---

## 📋 Steps Performed

### Step 1: Upload Dataset

- Uploaded `customer_master.csv` into Databricks.
- Created a managed table named:

```
workspace.default.customer_master
```

---

### Step 2: Read Data

Loaded the table into a Spark DataFrame.

Operations performed:

- Displayed records
- Counted total rows
- Printed schema

---

### Step 3: Data Quality Checks

Performed the following validations:

- Total Record Count
- Schema Verification
- NULL Value Detection
- Duplicate Record Detection
- Invalid Age Detection

---

### Step 4: Data Cleaning

Applied the following cleaning operations:

- Removed NULL values
- Removed duplicate records
- Removed customers having invalid ages

Condition used:

```
Age > 0
```

---

### Step 5: Save as Delta Table

Stored the cleaned data into a Delta Lake table.

Table Name:

```
workspace.default.customer_master_clean
```

Storage Format:

```
Delta Lake
```

---

### Step 6: Verification

Verified that the cleaned Delta table:

- Loads successfully
- Contains only valid records
- Has no NULL values
- Has no duplicate records
- Contains valid age values only

---

## 📊 Results

### Initial Dataset

- Records : 10,014

### After Removing NULL Values

- Records : 9,999

### After Removing Invalid Ages

- Records : 9,995

### Final Dataset

- Records : 9,995

---

## 📈 Data Cleaning Workflow

```
CSV File
      │
      ▼
Upload into Databricks
      │
      ▼
Create Spark DataFrame
      │
      ▼
Check Schema
      │
      ▼
Detect NULL Values
      │
      ▼
Detect Duplicate Records
      │
      ▼
Detect Invalid Ages
      │
      ▼
Clean Dataset
      │
      ▼
Save as Delta Table
      │
      ▼
Verify Final Data
```

---

## 📁 Repository Structure

```
Week-7/
│
├── customer_master.csv
├── Week7_DeltaLake.ipynb
├── README.md
└── screenshots/
```

---

## 📚 Key Concepts Learned

- Databricks Workspace
- Serverless Compute
- Apache Spark DataFrames
- PySpark Transformations
- Data Cleaning Techniques
- Delta Lake
- Managed Tables
- Data Validation
- Data Quality Checks

---

## ✅ Learning Outcomes

After completing this assignment, I learned how to:

- Upload datasets into Databricks
- Create managed tables
- Read data using Spark DataFrames
- Perform exploratory data analysis
- Detect NULL values
- Detect duplicate records
- Filter invalid data
- Clean datasets using PySpark
- Save cleaned data into Delta Lake
- Verify the final cleaned dataset

---

## 🚀 Conclusion

This assignment provided practical experience with Databricks and Delta Lake by implementing a complete data cleaning pipeline. The workflow included reading raw data, performing quality checks, cleaning the dataset, saving it as a Delta Table, and validating the final results. This process demonstrates the importance of maintaining high-quality data before performing analytics or machine learning tasks.