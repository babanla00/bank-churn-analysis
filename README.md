Bank Customer Churn Analysis (SQL)

Overview
This project analyzes bank customer data to identify churn patterns and high-risk segments using SQL. The goal is to support data-driven retention strategies through clean, reusable analysis.

Objectives
Integrate customer and account data
Validate data quality and consistency
Analyze churn across demographics and behavior
Build reusable SQL views and procedures

Tool
Database: MySQL
Language: SQL
Techniques: Data Cleaning, EDA, Query Optimization

Key Insights
Germany has the highest churn rate (~65%)
Customers aged 45–60 churn the most
Customers with 3+ products show extreme churn (>80%)

Optimization
Consolidated churn view (master_info)
Setup stored procedure for regional churn reporting(regional_churn_report)
