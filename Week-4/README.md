# Week-4: Azure Cloud Fundamentals and Data Pipeline using Azure Data Factory

## Objective

The objective of this assignment was to understand Azure Cloud fundamentals and build an end-to-end data pipeline using Azure Storage Account and Azure Data Factory (ADF). The pipeline reads a CSV file from Azure Blob Storage, validates its metadata, copies it to another Blob container, and verifies the successful execution of the pipeline.

---

## Azure Services Used

- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Azure Data Factory (ADF)
- Azure IAM (Identity and Access Management)

---

## Project Architecture

```
                 Azure Storage Account
               (Source Blob Container)
                        │
                        ▼
              Sample-Superstore.csv
                        │
                        ▼
              Linked Service (ADF)
                        │
                        ▼
                Source Dataset
                        │
                        ▼
                Get Metadata Activity
                        │
                        ▼
                 Copy Data Activity
                        │
                        ▼
             Destination Dataset
                        │
                        ▼
          Output Blob Container
          Copied-Superstore.csv
```

---

## Steps Performed

### 1. Created Resource Group

- Created a Resource Group named **Celebal-Week4-RG**.
- All Azure resources were organized under this Resource Group.

---

### 2. Created Storage Account

- Created an Azure Storage Account.
- Used StorageV2 (General Purpose v2).
- Enabled Blob Storage for storing files.

---

### 3. Created Blob Containers

Created two Blob Containers:

- **superstore-data** (Source)
- **output-data** (Destination)

Uploaded the provided **Sample-Superstore.csv** file into the **superstore-data** container.

---

### 4. Created Azure Data Factory

- Created an Azure Data Factory instance.
- Opened Azure Data Factory Studio.
- Used the Author, Manage, and Monitor sections for pipeline development.

---

### 5. Created Linked Service

Created a Linked Service to connect Azure Data Factory with Azure Blob Storage.

Configuration:

- Azure Blob Storage
- Account Key Authentication
- AutoResolve Integration Runtime

The Linked Service allows Azure Data Factory to communicate with the Storage Account.

---

### 6. Created Datasets

Two datasets were created.

#### Source Dataset

- Dataset Name: **DS_Source_CSV**
- Container: **superstore-data**
- File: **Sample-Superstore.csv**

#### Destination Dataset

- Dataset Name: **DS_Output_CSV**
- Container: **output-data**
- Output File: **Copied-Superstore.csv**

Datasets define the source and destination files used in the pipeline.

---

### 7. Built Azure Data Factory Pipeline

Created a pipeline named:

**PL_Copy_CSV**

The pipeline contains two activities.

#### Get Metadata Activity

Purpose:

- Checks whether the source file exists.
- Retrieves metadata before executing the copy operation.

#### Copy Data Activity

Purpose:

- Reads the CSV file from the source Blob container.
- Copies the file into the destination Blob container.

Pipeline Flow:

```
Get Metadata
      │
      ▼
Copy Data
```

---

### 8. Executed the Pipeline

- Validated the pipeline.
- Published all changes.
- Executed the pipeline using **Debug**.
- Verified the execution in the Monitor section.

Pipeline execution status:

**Succeeded**

---

### 9. Verified Output

After successful execution:

- The destination container **output-data** contained the file:

```
Copied-Superstore.csv
```

This confirms that the data pipeline executed successfully.

---

### 10. IAM Role Assignment

Assigned the following roles to Azure Data Factory Managed Identity:

- Reader
- Contributor

These permissions allow Azure Data Factory to access Azure Storage resources during pipeline execution.

---

## Project Outcome

Successfully implemented an end-to-end Azure Data Pipeline that:

- Reads data from Azure Blob Storage.
- Validates file metadata.
- Copies the CSV file to another Blob container.
- Executes successfully using Azure Data Factory.
- Verifies the output file after execution.

---

## Azure Concepts Learned

During this assignment, I learned:

- Cloud Computing fundamentals
- Azure Resource Group
- Azure Storage Account
- Azure Blob Storage
- Linked Services
- Datasets
- Azure Data Factory
- Get Metadata Activity
- Copy Data Activity
- Pipeline Execution
- Azure IAM Roles
- End-to-End Data Pipeline Implementation

---

## Output

- Successfully created Azure resources.
- Built an end-to-end Azure Data Factory pipeline.
- Pipeline executed successfully.
- Output file generated in the destination Blob container.
- IAM roles configured successfully.

---

## Screenshots

The repository includes screenshots of:

- Resource Group
- Storage Account
- Blob Containers
- Azure Data Factory
- Linked Service
- Source Dataset
- Destination Dataset
- Pipeline Design
- Pipeline Execution
- Output Blob Container
- IAM Role Assignment

---

## Conclusion

This assignment provided hands-on experience with Azure Cloud and Azure Data Factory by implementing a complete data movement pipeline. It demonstrated how Azure services work together to build scalable and reliable data engineering workflows. The project also strengthened my understanding of Blob Storage, Linked Services, Datasets, IAM Roles, and pipeline orchestration using Azure Data Factory.