
# Customer Retention and Churn Analysis Documentation

## Overview
This project models and analyzes customer retention, churn, and acquisition metrics for a subscription-based business using dbt on BigQuery. By employing a cohort-based approach, we track customer retention and churn rates over time, enabling insights into customer behavior by acquisition date, country, and business category.

## Pre-requisites
1. DBT BQ installed on your local machine

## Execution Steps
1. Copy the data in the data folder to tables in BQ (under a project you own or have enough access and permissions).
2. Create a Service Account JSON Key.
3. Edit profiles.yml to point to your JSON key.
4. cd manual-pasfield
5. run `dbt debug` to ensure the setup is correct
6. run `dbt deps` to ensure all dependencies are installed correctly
7. run `dbt seed` to ensure the seed is correctly set up
8. run `dbt run` to create all the models in your BQ project
9. run `dbt test` to make sure the data quality is high
10. run `dbt docs generate` and then `dbt docs serve --port 8080` to self serve yourself some wicked documentation.

A little test is the DAG png in this folder.

## Final Thoughts

The data model and approach enables flexible cohort analysis by focusing on acquisition dates, activity periods, and grouping dimensions such as country and business category. This structure provides a comprehensive view of customer engagement, supporting both high-level and granular insights into customer behavior, enabling the business to make data-driven decisions.

In terms of a technical test this also showcases my understanding of multilayered wearhouse, in which each layer has a different purpose. It also showcases my understanding and ability to use DBT competently with Seeds, Macros, Docs and Tests.

MORE MODEL SPECIFIC DOCUMENTATION IN THE overview.md!

Thanks you for your time :) 
