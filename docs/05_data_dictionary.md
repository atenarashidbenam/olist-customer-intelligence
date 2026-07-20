# Data Dictionary

## Overview

This document describes the primary entities used in the Olist Customer Intelligence Platform.

The data dictionary provides a business-oriented description of each table and its most important attributes.

---

# customers

## Description

Stores customer identification and location information.

| Column | Description |
|----------|-------------|
| customer_id | Unique identifier for each customer record |
| customer_unique_id | Persistent customer identifier across multiple orders |
| customer_city | Customer city |
| customer_state | Customer state |

---

# orders

## Description

Stores order lifecycle information.

| Column | Description |
|----------|-------------|
| order_id | Unique order identifier |
| customer_id | Customer who placed the order |
| order_status | Current order status |
| order_purchase_timestamp | Purchase date and time |
| order_approved_at | Payment approval timestamp |
| order_delivered_customer_date | Actual delivery date |
| order_estimated_delivery_date | Expected delivery date |

---

# order_items

## Description

Stores every item purchased within an order.

| Column | Description |
|----------|-------------|
| order_id | Related order |
| order_item_id | Item number inside the order |
| product_id | Purchased product |
| seller_id | Seller responsible for the item |
| shipping_limit_date | Shipping deadline |
| price | Product price |
| freight_value | Shipping cost |

---

# products

## Description

Stores product information.

| Column | Description |
|----------|-------------|
| product_id | Product identifier |
| product_category_name | Product category |
| product_weight_g | Product weight (grams) |
| product_length_cm | Product length |
| product_height_cm | Product height |
| product_width_cm | Product width |

---

# sellers

## Description

Stores seller information.

| Column | Description |
|----------|-------------|
| seller_id | Seller identifier |
| seller_city | Seller city |
| seller_state | Seller state |

---

# order_payments

## Description

Stores payment information for each order.

| Column | Description |
|----------|-------------|
| order_id | Related order |
| payment_sequential | Payment sequence |
| payment_type | Payment method |
| payment_installments | Number of installments |
| payment_value | Payment amount |

---

# order_reviews

## Description

Stores customer reviews.

| Column | Description |
|----------|-------------|
| review_id | Review identifier |
| order_id | Related order |
| review_score | Customer rating (1–5) |
| review_creation_date | Review creation date |
| review_answer_timestamp | Seller response timestamp |

---

# geolocation

## Description

Stores geographic reference data.

| Column | Description |
|----------|-------------|
| geolocation_zip_code_prefix | ZIP code prefix |
| geolocation_lat | Latitude |
| geolocation_lng | Longitude |
| geolocation_city | City |
| geolocation_state | State |

---

# product_category_name_translation

## Description

Maps Portuguese product categories to English.

| Column | Description |
|----------|-------------|
| product_category_name | Original Portuguese category |
| product_category_name_english | English translation |

---

# Business Rules

The following business rules are consistently applied throughout the project:

- Revenue metrics include only delivered orders.
- Freight charges are analyzed separately from product revenue.
- Customer behavior is measured using customer_unique_id.
- SQL views are the single source of business calculations.
- Analytical reports never duplicate transactional data.

---

# Naming Convention

The project follows consistent naming conventions:

- Tables use lowercase names.
- SQL views use the prefix `v_`.
- Schemas separate transactional and analytical layers.
- Descriptive column names are preserved whenever possible.