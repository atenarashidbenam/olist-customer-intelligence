# Database Schema

## Overview

The Olist Customer Intelligence Platform uses a normalized relational database implemented in Microsoft SQL Server.

The database is designed to preserve data integrity, reduce redundancy, and provide a reliable foundation for analytical reporting.

The project separates transactional data from analytical logic by using dedicated database schemas.

---

# Database Schemas

The database is organized into two primary schemas.

## core

The **core** schema stores normalized business entities imported from the Olist dataset.

It represents the transactional layer of the platform and serves as the single source of truth.

Main tables include:

- customers
- orders
- order_items
- products
- sellers
- order_payments
- order_reviews
- geolocation
- product_category_name_translation

---

## analytics

The **analytics** schema contains SQL views that transform transactional data into business-ready datasets.

This layer centralizes business logic and ensures that every report uses the same calculation rules.

Examples include:

- v_executive_dashboard
- v_monthly_sales
- v_customer_rfm
- v_product_performance
- v_seller_performance

---

# Database Design

The database follows a normalized relational model.

Key design principles include:

- Primary Keys for entity uniqueness
- Foreign Keys for referential integrity
- Separation of transactional and analytical layers
- Readable object naming
- Consistent data types
- Reusable analytical views

---

# Core Tables

## customers

Stores customer information.

Primary Key

- customer_id

Important columns

- customer_unique_id
- customer_city
- customer_state

---

## orders

Stores order lifecycle information.

Primary Key

- order_id

Foreign Keys

- customer_id

Important columns

- order_status
- order_purchase_timestamp
- order_delivered_customer_date
- order_estimated_delivery_date

---

## order_items

Stores every purchased item.

Composite Primary Key

- order_id
- order_item_id

Foreign Keys

- order_id
- product_id
- seller_id

Important columns

- price
- freight_value

---

## products

Stores product information.

Primary Key

- product_id

Important columns

- product_category_name
- product_weight_g
- product_length_cm
- product_height_cm
- product_width_cm

---

## sellers

Stores seller information.

Primary Key

- seller_id

Important columns

- seller_city
- seller_state

---

## order_payments

Stores payment information.

Foreign Key

- order_id

Important columns

- payment_type
- payment_installments
- payment_value

---

## order_reviews

Stores customer review information.

Primary Key

- review_id

Foreign Key

- order_id

Important columns

- review_score
- review_creation_date

---

## geolocation

Stores Brazilian geographic reference data.

Important columns

- geolocation_zip_code_prefix
- geolocation_city
- geolocation_state

---

## product_category_name_translation

Maps Portuguese product categories to English.

Important columns

- product_category_name
- product_category_name_english

---

# Relationships

The database models the complete e-commerce workflow.

Customer

↓

Orders

↓

Order Items

↓

Products

↓

Sellers

Orders are additionally linked to:

- Payments
- Reviews

---

# Data Integrity

Data integrity is maintained through:

- Primary Keys
- Foreign Keys
- NOT NULL constraints
- Appropriate data types
- Controlled ETL process

---

# Analytical Layer

The analytics schema never stores duplicated transactional data.

Instead, SQL views calculate business metrics directly from the normalized tables.

This approach guarantees:

- Consistent KPIs
- Easier maintenance
- Better reusability
- Reduced redundancy

---

# Performance

To improve analytical performance, the project includes:

- Nonclustered indexes
- Optimized joins
- Aggregation-friendly views
- Validation scripts

These optimizations improve reporting performance while preserving data consistency.