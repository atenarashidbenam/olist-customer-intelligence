# Project Architecture

## Overview

The Olist Customer Intelligence Platform follows a layered architecture that separates data ingestion, transformation, storage, analytics, and reporting.

This architecture improves maintainability, scalability, and readability while ensuring that business rules remain consistent throughout the project.

---

# Architecture Overview

```
                Raw CSV Files
                      │
                      ▼
            Data Cleaning (Python)
                      │
                      ▼
              ETL / Data Import
                      │
                      ▼
        SQL Server Relational Database
                      │
                      ▼
            Analytics SQL Views
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
      Power BI             Machine Learning
          │                       │
          └───────────┬───────────┘
                      ▼
              Business Insights
```

---

# Layer 1 — Data Understanding

The project starts by exploring the original Olist dataset.

Objectives:

- Understand each dataset
- Identify relationships
- Detect missing values
- Understand business entities
- Define project scope

Main tools:

- Jupyter Notebook
- Pandas

---

# Layer 2 — Data Cleaning

Python scripts clean and standardize the raw CSV files before loading them into SQL Server.

Typical tasks include:

- Removing invalid rows
- Handling missing values
- Standardizing formats
- Preparing clean datasets for import

Main tools:

- Python
- Pandas

---

# Layer 3 — ETL

The cleaned datasets are imported into SQL Server.

The ETL layer focuses on reliable and repeatable data loading.

Responsibilities:

- Import CSV files
- Preserve data integrity
- Prepare relational tables

---

# Layer 4 — Relational Database

The core database stores normalized business entities.

Main schemas:

- core
- analytics

The core schema contains:

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

# Layer 5 — Analytics Layer

Business logic is implemented using SQL views.

Examples include:

- Executive Dashboard
- Monthly Sales
- Customer RFM
- Customer Segmentation
- Product Performance
- Seller Performance
- Delivery Performance
- Review Analysis

The analytics layer guarantees that business rules remain consistent across reports.

---

# Layer 6 — Performance Optimization

Performance improvements are implemented using:

- Nonclustered indexes
- Query optimization
- Validation scripts

The objective is to improve analytical query performance while maintaining correctness.

---

# Layer 7 — Documentation

Technical documentation explains:

- Architecture
- Database design
- Business rules
- KPIs
- Data quality
- Setup instructions

---

# Layer 8 — Business Intelligence

Power BI dashboards visualize:

- Executive KPIs
- Sales trends
- Customer behavior
- Product performance
- Seller performance

---

# Layer 9 — Machine Learning

The analytics layer provides clean datasets for future predictive models such as:

- Customer segmentation
- Customer lifetime value prediction
- Sales forecasting
- Recommendation systems

---

# Design Principles

The project follows several engineering principles:

- Layered architecture
- Separation of concerns
- Reusable SQL views
- Consistent business rules
- Modular ETL
- Readable SQL code
- Documentation-first development