
{% docs __overview__ %}
# Customer Retention and Churn Analysis Documentation

## Overview

This project models and analyzes customer retention, churn, and acquisition metrics for a subscription-based business using dbt on BigQuery. By employing a cohort-based approach, we track customer retention and churn rates over time, enabling insights into customer behavior by acquisition date, country, and business category.

## Data Model

The project is organized into three key stages:

1. **Referential Layer**: Raw data tables (`ref_customers`, `ref_acq_orders`, and `ref_activity`) represent the foundational data sources.
2. **Preparatory Layer**: Preprocessed data where initial transformations and joins are performed. The primary model here is `prep_customer`, which merges `ref_customers`, `ref_acq_orders`, and `ref_activity`.
3. **Marts Layer**: Aggregated tables designed for reporting, such as `mart_customer_metrics`, used to track key metrics like retention, churn, and acquisition by cohort.

## Design Decisions

### 1. Cohort Retention Analysis Approach
   - Customers are grouped into cohorts based on their acquisition month. This allows us to analyze retention and churn trends for each cohort over time.
   - Monthly retention and churn are calculated for each cohort, providing insight into the overall health of customer engagement.

### 2. Customer Metrics (Retention and Churn) Approach
   - **Retention Metrics**: Count of customers who remain active at specific intervals (1 month, 3 months, and 6 months).
   - **Churn Metrics**: customers who have stopped their subscription based on the `to_date` field.
   - **Group By Country and Taxonomy**: Metrics are segmented by `customer_country` and `taxonomy_business_category_group` to support region-specific and business-category-specific insights.

### 3. Modeling Assumptions
   - **Handling Nulls in `to_date`**: For active customers without a specified `to_date`, the model assumes they remain active up to the current date and that this field in particular is clean.

UPDATE THIS
## Dataset Descriptions

### 1. **`prep_customer`**
   - This table merges customer, acquisition, and activity data for analysis.
   - **Generated Fields**:
     - `from_date`: The date each customer subscribed.
     - `to_date`: The date each customer churned or the end of their subscription period.
     - `customer_country`: The country associated with each customer.
     - `taxonomy_business_category_group`: The business category each customer belongs to.

### 2. **`mart_customer_metrics_monthly`**
   - This model calculates core customer metrics, including acquisition, retention, and churn rates on a monthly basis, grouped by country and business category.
   - **Generated Fields**:
     - `acquisition_month`: The month in which each customer cohort was acquired.
     - `acquired_customers`: The number of customers acquired in each cohort month.
     - `retained_customers`: The number of customers who remain active each month.
     - `churned_customers`: The number of customers who churned in each cohort month.
     - `retention_rate`: The percentage of customers retained, calculated as `(retained_customers / acquired_customers) * 100`.
     - `churn_rate`: The percentage of customers who churned, calculated as `(churned_customers / acquired_customers) * 100`.

### 3. **`cohort_retention_analysis_monthly`**
   - This model evaluates retention rates for customer cohorts at specified intervals (e.g., 1, 3, and 6 months post-acquisition), enabling insights into customer behavior over time. The data is grouped by acquisition month, country, and business category.
   - **Generated Fields**:
     - `cohort_month`: The acquisition month of each customer cohort.
     - `total_customers`: The total number of customers in each cohort.
     - `retained_1_month`: The number of customers retained after 1 month.
     - `retained_3_months`: The number of customers retained after 3 months.
     - `retained_6_months`: The number of customers retained after 6 months.
     - `retention_rate_1_month`: The 1-month retention rate, calculated as `(retained_1_month / total_customers) * 100`.
     - `retention_rate_3_months`: The 3-month retention rate, calculated as `(retained_3_months / total_customers) * 100`.
     - `retention_rate_6_months`: The 6-month retention rate, calculated as `(retained_6_months / total_customers) * 100`.

### 4. **`customer_retention_metrics`**
   - This foundational model provides a base of essential customer retention and activity metrics for further analysis or model extensions.
   - **Generated Fields**:
     - `subscription_length_days`: The length of each customer’s subscription, calculated as the difference between `to_date` and `from_date`.
     - `time_since_last_activity_days`: The time since the customer’s last recorded activity, calculated as the difference between `current_date()` and `to_date`.


## Final Thoughts

The data model and approach enables flexible cohort analysis by focusing on acquisition dates, activity periods, and grouping dimensions such as country and business category. This structure provides a comprehensive view of customer engagement, supporting both high-level and granular insights into customer behavior, enabling the business to make data-driven decisions.

In terms of a technical test this also showcases my understanding of multilayered wearhouse, in which each layer has a different purpose. It also showcases my understanding and ability to use DBT competently with Seeds, Macros, Docs and Tests.

Tanks you for your time :) 
{% enddocs %}