# 🍔 Food Delivery Analytics — SQL Portfolio Project

## Project Overview
This project analyzes a synthetic food-delivery dataset using SQL to answer practical business questions around orders, revenue, customers, restaurants, cuisines, delivery performance, ratings, discounts, and customer behavior.

The project is designed as a portfolio piece for a **Data Analyst / Business Analyst** role.

## Business Questions
- How much revenue and how many delivered orders were generated?
- Which cities and restaurants generate the most revenue?
- Which cuisines and menu items perform best?
- What are the peak ordering hours?
- What is the average order value?
- What is the cancellation rate?
- Which customers are high value or repeat customers?
- How does delivery time vary by city?
- How are discounts associated with order value?
- How does revenue change month over month?

## Tech Stack
- **SQL:** PostgreSQL
- **Data:** CSV
- **Concepts:** SELECT, WHERE, GROUP BY, HAVING, JOINs, CASE, CTEs, subqueries, date functions, window functions, aggregations

## Dataset
Synthetic data generated specifically for this portfolio project:
- 300 customers
- 60 restaurants
- 120 menu items
- 2,000 orders
- Order-item level transaction data

## Database Schema
```text
customers
   │
   └──< orders >── restaurants
          │
          └──< order_items >── menu_items
```

## Folder Structure
```text
food-delivery-analytics-sql/
├── data/
│   ├── customers.csv
│   ├── restaurants.csv
│   ├── menu_items.csv
│   ├── orders.csv
│   └── order_items.csv
├── sql/
│   ├── 01_schema.sql
│   └── 02_analysis_queries.sql
├── docs/
│   └── project_summary.md
└── README.md
```

## How to Run
1. Create a PostgreSQL database.
2. Run `sql/01_schema.sql`.
3. Import the CSV files from `data/`.
4. Run `sql/02_analysis_queries.sql`.
5. Use the query outputs to identify business trends and insights.

## Key SQL Skills Demonstrated
- Multi-table JOINs
- Aggregations and KPIs
- CASE statements
- CTEs
- Subqueries
- Date/time analysis
- FILTER clauses
- HAVING
- Window functions
- DENSE_RANK
- LAG
- Customer segmentation

## Resume Description
**Food Delivery Analytics | SQL**
- Analyzed food delivery order data to evaluate revenue, order volume, customer behavior, restaurant performance, delivery trends, and key business KPIs.
- Used SQL for data extraction, filtering, aggregation, GROUP BY, joins, subqueries, and date-based analysis to generate actionable business insights.
- Analyzed metrics such as total orders, revenue, average order value, delivery time, cancellation rates, customer order frequency, and restaurant performance.
- Identified high-performing restaurants, popular food categories, peak ordering periods, and customer purchasing patterns to support data-driven business decisions.
