# Analytics Layer

## Overview

The analytics schema contains reusable SQL views that transform normalized transactional data into business-ready datasets.

Instead of embedding business logic in dashboards or reports, all calculations are centralized in SQL views to ensure consistency, maintainability, and reusability.

These views serve as the primary data source for Power BI dashboards and future machine learning models.

---

# Design Principles

The analytics layer follows these principles:

- Single source of truth for business metrics
- Reusable SQL logic
- Consistent KPI calculations
- Readable and modular queries
- Performance-oriented design

---

# Business Rule

Unless explicitly stated otherwise, **all revenue-related metrics are calculated using delivered orders only**.

Orders with statuses such as *canceled*, *unavailable*, or *processing* are excluded from finalized business metrics.

This rule is consistently applied across all analytical views.

---

# Analytics Views

## v_executive_dashboard

### Purpose

Provides a high-level summary of the business for executive reporting.

### Main KPIs

- Total Revenue
- Total Delivered Orders
- Total Customers
- Average Order Value
- Average Review Score
- Average Delivery Time

### Typical Use Cases

- Executive dashboard
- Management reporting
- Business overview

---

## v_monthly_sales

### Purpose

Aggregates sales performance by month.

### Metrics

- Monthly Revenue
- Delivered Orders
- Average Order Value

### Typical Use Cases

- Revenue trend analysis
- Growth monitoring
- Seasonality analysis

---

## v_customer_rfm

### Purpose

Calculates customer purchasing behavior using the RFM framework.

### Dimensions

- Recency
- Frequency
- Monetary Value

### Typical Use Cases

- Customer segmentation
- Marketing campaigns
- Loyalty analysis

---

## v_product_performance

### Purpose

Measures product performance across sales and customer satisfaction.

### Metrics

- Revenue
- Units Sold
- Average Selling Price
- Average Freight Cost

### Typical Use Cases

- Product portfolio analysis
- Pricing strategy
- Category performance

---

## v_seller_performance

### Purpose

Evaluates seller performance.

### Metrics

- Revenue
- Orders
- Average Order Value
- Average Review Score

### Typical Use Cases

- Marketplace management
- Seller comparison
- Operational monitoring

---

# Data Flow

The analytics layer receives data exclusively from the normalized core schema.

```
core tables
      │
      ▼
Analytics Views
      │
      ▼
Power BI
Machine Learning
Business Reports
```

No analytical view writes data back to the transactional database.

---

# Performance Considerations

The analytics layer is optimized through:

- Nonclustered indexes
- Efficient joins
- Aggregation-friendly queries
- Validation scripts

These optimizations reduce execution time while preserving correctness.

---

# Benefits

Centralizing business logic in SQL views provides several advantages:

- Consistent KPI calculations
- Reduced code duplication
- Easier maintenance
- Simplified dashboard development
- Improved scalability
- Better collaboration between analysts and engineers