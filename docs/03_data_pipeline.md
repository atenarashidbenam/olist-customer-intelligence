# Data Pipeline

## Overview

The Olist Customer Intelligence Platform follows a structured data pipeline that transforms raw CSV files into analytics-ready datasets for business intelligence and machine learning.

Each stage of the pipeline has a clearly defined responsibility to ensure data quality, consistency, and maintainability.

---

# Pipeline Overview

```
Raw CSV Files
      │
      ▼
Data Understanding
      │
      ▼
Data Cleaning (Python)
      │
      ▼
Clean CSV Files
      │
      ▼
ETL (SQL Server)
      │
      ▼
Core Relational Database
      │
      ▼
Analytics Views
      │
      ▼
Business KPIs
      │
      ├──────────────► Power BI
      │
      └──────────────► Machine Learning
```

---

# Stage 1 — Raw Data

The project starts with the Brazilian E-Commerce Public Dataset by Olist.

The raw dataset consists of multiple CSV files representing different business entities, including:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Payments
- Reviews
- Geolocation
- Product Categories

---

# Stage 2 — Data Understanding

Before importing the data, each dataset is explored to understand:

- Business meaning
- Relationships
- Primary keys
- Foreign keys
- Missing values
- Data quality issues

This stage defines the database design and business scope.

---

# Stage 3 — Data Cleaning

Python scripts clean and standardize the datasets before loading them into SQL Server.

Typical cleaning tasks include:

- Handling missing values
- Removing invalid records
- Standardizing column formats
- Preparing consistent datasets

Output:

Clean CSV files ready for ETL.

---

# Stage 4 — ETL

The ETL process loads the cleaned datasets into SQL Server.

Responsibilities include:

- Importing data
- Preserving referential integrity
- Maintaining consistent relationships
- Loading tables in dependency order

The ETL process is designed to be repeatable and deterministic.

---

# Stage 5 — Core Database

The cleaned data is stored in a normalized relational database.

The core schema represents business entities and relationships.

Examples include:

- Customers
- Orders
- Order Items
- Sellers
- Products
- Payments
- Reviews

The database serves as the single source of truth for all analytical calculations.

---

# Stage 6 — Analytics Layer

SQL views transform transactional data into business-ready metrics.

Examples include:

- Executive Dashboard
- Monthly Sales
- Customer RFM
- Customer Segmentation
- Product Performance
- Seller Performance
- Delivery Performance
- Review Analysis

All analytical views apply consistent business rules.

---

# Stage 7 — Business Intelligence

Power BI dashboards consume the analytics views directly.

Typical dashboards include:

- Executive KPIs
- Revenue trends
- Customer insights
- Product analysis
- Seller performance
- Delivery performance

---

# Stage 8 — Machine Learning

The analytics layer also serves as a clean and validated data source for future machine learning models.

Potential applications include:

- Customer segmentation
- Customer lifetime value prediction
- Sales forecasting
- Product recommendation
- Churn prediction

---

# Pipeline Design Principles

The pipeline follows several engineering principles:

- Layered architecture
- Single source of truth
- Reusable transformations
- Consistent business rules
- Data quality before analytics
- Reproducible ETL
- Scalable design