# 👩🏻‍⚕️ Healthcare Claims Analytics: Cost Drivers, Risk Segmentation & Reimbursement Efficiency

> End-to-end healthcare data analysis project using SQL and Power BI to uncover cost drivers, high-risk members, and reimbursement inefficiencies.

## Table of Contents
- [Executive Summary](#executive-summary)
- [Business Objectives](#business-objectives)
- [Tech Stack](#tech-stack)
- [Project Workflow](#project-workflow)
- [Dashboard Overview](#dashboard-overview)
- [Key Insights & Business Recommendations](#key-insights--business-recommendations)
- [Business Impact](#business-impact)
- [Skills Demonstrated](#skills-demonstrated)
- [Repository Structure](#repository-structure)

## Executive Summary
This project delivers an end-to-end analysis of healthcare claims data to uncover the key drivers of medical spending, identify high-cost member segments, and evaluate reimbursement efficiency across providers and procedures.

Using SQL for data preparation and Power BI for visualization, the project transforms raw claims data into structured, analytics-ready datasets and translates them into actionable insights. The analysis is designed to support data-driven decision-making in healthcare cost management, financial optimization, and operational efficiency.

---

## Business Objectives
This analysis addresses the following key questions:

- Which claim types contribute the most to total healthcare spending?  
- Which CPT and ICD codes drive the highest costs?  
- Which members account for the largest share of total spending?  
- How do billed amounts compare to paid amounts?  
- Where are potential reimbursement inefficiencies (margin leakage)?  

---

## Tech Stack
- **SQL (MySQL):** Data cleaning, validation, transformation, and analysis  
- **Power BI:** Data modeling, DAX measures, and dashboard development  

---

## Project Workflow

### 1. Data Preparation & Modeling
- Designed relational schema for claims and member datasets  
- Structured data to support efficient querying and analysis  
- Established relationships between claims, members, and providers  

### 2. Data Cleaning & Validation
- Standardized date formats and data types  
- Removed invalid records (e.g., non-positive billed amounts)  
- Performed data quality checks for missing values, duplicates, and anomalies  
- Ensured data accuracy and consistency across datasets  

### 3. Analytical Data Modeling
- Built reusable SQL views for member-level and provider-level analysis  
- Created a **gold-layer analytical dataset** as a single source of truth  
- Applied structured data modeling to support scalable reporting  

### 4. Data Analysis & Visualization
- Developed interactive dashboards in Power BI  
- Created DAX measures for KPIs and reimbursement metrics  
- Visualized trends, cost drivers, and efficiency patterns  

---

## Dashboard Overview

### Executive Overview
- Total Paid, Total Billed, and Paid Ratio KPIs  
- Monthly healthcare cost trends  
- Claim type cost distribution

![Executive Overview](<Power BI/dashboard_overview.jpg>)

### Procedure & Diagnosis Cost Drivers
- Top CPT and ICD codes by total cost  
- Average cost per high-impact procedure

![Procedure & Diagnosis Cost Drivers](<Power BI/cost_drivers.jpg>)

### High-Cost Member Analysis
- Pareto analysis identifying high-cost members  
- Cost distribution by claim type  
- Member risk segmentation

![High-Cost Member Analysis](<Power BI/high_cost_members.jpg>)

### Margin Leakage Analysis
- Paid-to-billed ratio by provider, claim type, and procedure  
- Identification of high-billing, low-reimbursement cases  
- Provider-level efficiency comparison

![Margin Leakage Analysis](<Power BI/margin_leakage.jpg>)

---

## Key Insights & Business Recommendations

### 1. High-Cost Member Concentration
- A small percentage of members accounts for the majority of total healthcare costs  
- This concentration highlights significant financial risk within a limited population  

**Recommendation:**  
Implement targeted care management programs for high-risk members to reduce long-term costs.

---

### 2. Claim Type Cost Drivers
- Inpatient and outpatient claims contribute the largest share of total spending  
- Facility-based care is the primary cost driver  

**Recommendation:**  
Monitor utilization patterns and evaluate cost-control strategies for high-impact services.

---

### 3. Procedure-Level Cost Exposure
- A limited number of CPT codes drive a disproportionate share of total costs  
- These procedures combine high frequency with high average cost  

**Recommendation:**  
Prioritize these procedures for cost optimization and utilization review.

---

### 4. Reimbursement Inefficiency (Margin Leakage)
- Paid-to-billed ratios vary significantly across providers and procedures  
- Some high-cost services show low reimbursement efficiency  

**Recommendation:**  
Review provider contracts and renegotiate reimbursement structures where necessary.

---

## Business Impact
This analysis enables healthcare organizations to:

- Identify major cost drivers and spending concentrations  
- Detect inefficiencies in reimbursement processes  
- Improve financial planning and cost control strategies  
- Support data-driven decision-making in healthcare operations  

---

## Skills Demonstrated
- Data Cleaning & Validation  
- SQL Querying (CTEs, Window Functions, Aggregations)  
- Data Modeling & Analytical View Design  
- Dashboard Development (Power BI, DAX)  
- Business Insight Generation  
- Healthcare Data Analysis  

---

## Repository Structure
```text
healthcare-claims-analysis/
│
├── data/
│   ├── raw/
│   │   ├── claims.csv
│   │   └── members.csv
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_cleaning.sql
│   ├── 03_analytic_views.sql
│   └── 04_analysis_queries.sql
│
├── dashboard/
│   ├── healthcare_claims_dashboard.pbix
│   └── screenshots/
│       ├── dashboard_overview.jpg
│       ├── cost_drivers.jpg
│       ├── high_cost_members.jpg
│       └── margin_leakage.jpg
│
└── README.md
```
