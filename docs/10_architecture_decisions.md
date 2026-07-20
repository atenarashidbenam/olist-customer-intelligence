# Architecture Decisions

## Overview

This document explains the key architectural decisions made during the development of the Olist Customer Intelligence Platform.

The goal is not only to document *what* was built, but also *why* specific design choices were made.

---

# Decision 1 — Layered Architecture

## Decision

The project follows a layered architecture that separates data ingestion, storage, analytics, and reporting.

## Rationale

Separating responsibilities improves readability, maintainability, and scalability.

Each layer has a single purpose and can evolve independently.

## Benefits

- Clear separation of concerns
- Easier debugging
- Better scalability
- Simpler maintenance

---

# Decision 2 — Normalized Relational Database

## Decision

The transactional database is stored in a normalized relational model.

## Rationale

Normalization minimizes data redundancy while preserving data integrity.

The analytical layer is responsible for aggregation rather than storing duplicated information.

## Benefits

- Reduced redundancy
- Better consistency
- Easier maintenance
- Improved integrity

---

# Decision 3 — Separate Core and Analytics Schemas

## Decision

Transactional tables and analytical views are stored in different schemas.

## Rationale

Business logic should remain separate from operational data.

This makes the database easier to understand and prevents accidental modification of transactional objects.

## Benefits

- Cleaner organization
- Better maintainability
- Easier permission management
- Reusable analytical layer

---

# Decision 4 — SQL Views as the Business Layer

## Decision

Business logic is implemented in SQL views rather than Power BI or Python.

## Rationale

Business rules should exist in one place only.

Every downstream consumer uses identical calculations.

## Benefits

- Single source of truth
- Consistent KPIs
- Reduced duplication
- Easier maintenance

---

# Decision 5 — Delivered Orders for Revenue

## Decision

Revenue calculations include only delivered orders.

## Rationale

Canceled, unavailable, or incomplete orders do not represent realized revenue.

Restricting calculations to delivered orders produces more reliable business metrics.

## Benefits

- Accurate KPIs
- Consistent financial reporting
- Realistic business analysis

---

# Decision 6 — Customer Identity

## Decision

Customer analysis uses `customer_unique_id` instead of `customer_id`.

## Rationale

The dataset assigns different `customer_id` values to the same customer across multiple purchases.

Using `customer_unique_id` provides a stable customer identity.

## Benefits

- Correct customer counts
- Reliable RFM analysis
- Better customer segmentation

---

# Decision 7 — Revenue Excludes Freight Charges

## Decision

Revenue is calculated from product prices only.

Freight costs are analyzed separately.

## Rationale

Shipping costs are operational expenses rather than product revenue.

Separating them enables clearer financial analysis.

## Benefits

- Transparent revenue metrics
- Better logistics analysis
- Flexible KPI design

---

# Decision 8 — Performance Optimization

## Decision

Analytical performance is improved using nonclustered indexes and query optimization.

## Rationale

Analytical queries frequently aggregate large transactional tables.

Optimizing access paths improves responsiveness without altering business logic.

## Benefits

- Faster reporting
- Better scalability
- Improved user experience

---

# Decision 9 — Documentation-First Approach

## Decision

Comprehensive technical documentation is included as part of the project.

## Rationale

Well-documented projects are easier to understand, reproduce, and maintain.

Documentation also demonstrates engineering maturity.

## Benefits

- Easier onboarding
- Better collaboration
- Improved reproducibility
- Higher portfolio quality

---

# Future Architecture

The current architecture is designed to support future enhancements without significant redesign.

Potential extensions include:

- Automated ETL pipelines
- Cloud deployment
- Incremental data loading
- Data warehouse architecture
- Machine learning pipelines
- Workflow orchestration
- CI/CD for SQL deployment

---

# Conclusion

The architectural decisions documented here prioritize maintainability, consistency, scalability, and reproducibility.

By separating responsibilities, centralizing business logic, and documenting design choices, the project provides a solid foundation for business intelligence and future data science applications.