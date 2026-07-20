# Data Quality and Limitations

## Overview

The Olist Customer Intelligence Platform is built on the Brazilian E-Commerce Public Dataset by Olist.

Although the dataset is widely used for analytics and machine learning projects, it contains several real-world data quality issues that must be considered during analysis.

This document summarizes the major data quality considerations, the decisions made during the project, and the limitations that remain.

---

# Data Quality Approach

The project follows a simple principle:

> Preserve original business data whenever possible, and apply business rules explicitly within the analytics layer rather than modifying historical records.

Cleaning focuses on improving consistency without changing the meaning of the data.

---

# Missing Values

Several tables contain missing values.

Examples include:

- Product dimensions
- Product category names
- Delivery timestamps
- Review response timestamps

Project decision:

- Missing values were preserved unless they prevented analytical processing.
- Business logic handles missing values where appropriate.

---

# Product Categories

Some products do not have an English category translation.

Project decision:

- Use the English category name when available.
- Otherwise, fall back to the original Portuguese category name.

This prevents products from disappearing from analytical reports due to missing translations.

---

# Delivered Orders

Not every order in the dataset represents completed revenue.

Order statuses include:

- delivered
- shipped
- canceled
- unavailable
- processing
- invoiced

Project decision:

Revenue-related analyses include **only delivered orders**.

This rule is consistently applied across all analytical views.

---

# Customer Identity

The dataset contains two customer identifiers:

- customer_id
- customer_unique_id

Project decision:

Customer-level analysis uses **customer_unique_id** because a single customer may have multiple customer_id values across different purchases.

This produces more accurate customer metrics.

---

# Revenue Calculations

Revenue is calculated using product prices only.

Freight charges are analyzed separately.

Project decision:

Revenue = SUM(price)

Shipping costs remain available for logistics analysis but are not included in product revenue KPIs.

---

# Duplicate Business Logic

One common source of reporting errors is implementing different KPI definitions in different reports.

Project decision:

All business logic is centralized in SQL views within the **analytics** schema.

Power BI and future machine learning workflows consume these views instead of recalculating metrics independently.

---

# Performance Considerations

Analytical queries may require processing millions of rows.

Project decision:

Performance improvements include:

- Nonclustered indexes
- Optimized joins
- Aggregation-friendly SQL views
- Validation scripts

These optimizations improve query execution without changing business results.

---

# Known Limitations

The project has several intentional limitations.

## Historical Snapshot

The dataset represents historical transactions only.

It does not receive real-time updates.

---

## Geographic Analysis

Geolocation data is available but is not extensively analyzed in the current version of the project.

Future versions may include spatial analysis and logistics optimization.

---

## Machine Learning

Machine learning models are outside the scope of the current documentation phase.

The analytics layer has been designed to support future predictive modeling.

---

# Future Improvements

Possible future enhancements include:

- Customer Lifetime Value (CLV)
- Churn prediction
- Recommendation systems
- Sales forecasting
- Geographic analytics
- Interactive dashboards
- Automated data pipelines

---

# Conclusion

The project prioritizes transparent business rules, reproducible analytical results, and maintainable SQL logic.

Known limitations are documented explicitly to ensure that analytical results are interpreted correctly.