# Setup and Execution

## Overview

This document explains how to set up and run the Olist Customer Intelligence Platform.

The project has been designed to be reproducible, allowing anyone to rebuild the database, analytics layer, and reporting environment from the original dataset.

---

# Prerequisites

Before running the project, install the following software:

- Python 3.11 or later
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- Visual Studio Code
- Git
- Power BI Desktop (optional for dashboards)

---

# Clone the Repository

Clone the project from GitHub.

```bash
git clone https://github.com/<your-username>/olist-customer-intelligence-platform.git
```

Move into the project directory.

```bash
cd olist-customer-intelligence-platform
```

---

# Download the Dataset

Download the Brazilian E-Commerce Public Dataset by Olist from Kaggle.

Place the CSV files inside the project's raw data directory.

```
data/
└── raw/
```

---

# Project Structure

```
project-root/
│
├── data/
│   ├── raw/
│   └── processed/
│
├── docs/
│
├── notebooks/
│
├── sql/
│   ├── core/
│   ├── etl/
│   ├── analytics/
│   └── performance/
│
├── src/
│
└── README.md
```

---

# Execution Order

Run the project in the following order.

## Step 1

Create the database.

---

## Step 2

Create schemas.

---

## Step 3

Create core tables.

---

## Step 4

Define constraints.

---

## Step 5

Import cleaned data.

---

## Step 6

Create analytics views.

---

## Step 7

Run validation scripts.

---

## Step 8

Create performance indexes.

---

## Step 9

Run performance validation.

---

# Business Rules

The following rules are implemented throughout the project.

- Revenue includes delivered orders only.
- Customer analysis uses `customer_unique_id`.
- Freight costs are analyzed separately from product revenue.
- SQL views are the single source of business logic.

---

# Expected Outputs

After completing all steps, the project provides:

- A normalized SQL Server database
- Analytics-ready SQL views
- Validated business KPIs
- Performance-optimized queries
- Data source for Power BI
- Data source for future Machine Learning models

---

# Verification

After the setup is complete, verify that:

- All tables have been created successfully.
- All analytics views return data.
- Validation scripts complete without errors.
- Performance indexes have been created successfully.
- KPI values are consistent across reports.

---

# Troubleshooting

## Database Connection

Ensure SQL Server is running and the correct database is selected.

---

## Missing Data

Verify that all required CSV files are placed in the `data/raw` directory before importing.

---

## View Errors

If a view cannot be created, verify that all core tables and required dependencies have already been created.

---

## Performance

If analytical queries are slow, ensure that the performance index script has been executed successfully.