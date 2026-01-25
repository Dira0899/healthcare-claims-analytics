# 👩🏻‍⚕️ Healthcare Claims – Where Is the Money Going?

## 📚 Table of Contents
- [Project Overview](#-project-overview)
- [Business Questions](#-business-questions)
- [SQL Data Model & Workflow](#-sql-data-model--workflow)
- [Power BI Dashboard](#-power-bi-dashboard)
- [Key Insights](#-key-insights)
- [Business Questions – Summary of Findings](#-business-questions--summary-of-findings)

## 📌 Project Overview

This project analyzes healthcare claims data to identify cost drivers, high-cost members, and reimbursement inefficiencies (margin leakage). The dashboard is designed to help executive stakeholders understand where healthcare spending is concentrated and where opportunities for cost optimization exist.

The project follows an end-to-end analytics workflow:

- Data preparation and modeling using SQL
- Analytical measures and visualizations using Power BI
- Executive-focused dashboard design

## 🎯 Business Questions

This project answers the following questions:

- Which claim types are the most expensive?
- Which CPT and ICD codes drive the highest healthcare spending?
- Which members account for the largest share of total costs?
- How do billed amounts compare to paid amounts?
- Where are potential reimbursement inefficiencies (margin leakage)?

## ⚙️ Tech Stack

- SQL (MySQL) – data cleaning, validation, and analytics views
- Power BI – data modeling, DAX measures, and dashboards
  
## 🧱 SQL Data Model & Workflow
### 1. Schema Creation  ([`01_schema.sql`](sql/01_schema.sql))
- claims – claim-level financial and procedure data
- members – member demographics and enrollment information

````sql
CREATE TABLE claims (
    claim_id VARCHAR(50) PRIMARY KEY,
    member_id VARCHAR(50),
    provider_id VARCHAR(50),
    claim_date DATE,
    claim_type VARCHAR(50),
    cpt_code VARCHAR(20),
    icd_code VARCHAR(20),
    billed_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2)
)
````

### 2. Data Cleaning & Validation ([`02_Cleaning.sql`](sql/02_Cleaning.sql))
   
**Key steps include:**
  - Converting date fields from string to DATE format
  - Checking missing or invalid financial values
  - Checking and Removing claims with non-positive billed amounts
  - Basic data quality checks (duplicates, anomalies)
  
````sql
DELETE FROM claims
WHERE billed_amount IS NULL
   OR billed_amount <= 0;
````
### 3. Analytics Views ([`03_Analytic_View.sql`](sql/03_Analytic_View.sql))
**Reusable views created to support reporting and analysis:**
#### Member Level Aggregation

````sql
CREATE VIEW vw_member_costs AS
SELECT
    member_id,
    SUM(paid_amount) AS total_paid,
    COUNT(*) AS claim_count
FROM claims
GROUP BY member_id;
````
#### Provider Reimbursement Efficiency

````sql
CREATE VIEW vw_provider_efficiency AS
SELECT
    provider_id,
    SUM(paid_amount) / SUM(billed_amount) AS provider_paid_ratio,
    COUNT(*) AS claim_volume
FROM claims
GROUP BY provider_id;
````
#### Gold Analytics View (Primary Power BI Source)

````sql
CREATE VIEW vw_claims_gold AS
SELECT
    c.claim_id,
    c.claim_date,
    YEAR(c.claim_date) AS claim_year,
    MONTH(c.claim_date) AS claim_month,
    c.claim_type,
    c.cpt_code,
    c.icd_code,
    c.provider_id,
    c.billed_amount,
    c.paid_amount,
    c.paid_amount / c.billed_amount AS paid_ratio,
    m.member_age,
    m.member_gender,
    m.plan_type
FROM claims c
LEFT JOIN members m
    ON c.member_id = m.member_id
WHERE c.billed_amount > 0;
````
**This gold view serves as the single source of truth for Power BI.**

### 4. Analytical Queries ([`04_analysis_queries.sql`](sql/04_analysis_queries.sql))
**Standalone analytical queries used to validate insights using SQL window functions to identify high cost members.**

````sql
WITH member_spend AS (
    SELECT member_id, SUM(paid_amount) AS total_paid
    FROM claims
    GROUP BY member_id
)
SELECT
    member_id,
    total_paid,
    SUM(total_paid) OVER (ORDER BY total_paid DESC)
        / SUM(total_paid) OVER () AS cumulative_percentage
FROM member_spend
ORDER BY total_paid DESC;
````

# 📊 Power BI Dashboard

**The Power BI dashboard consists of four pages:**

## 1. Executive Overview
- Total Paid, Total Billed, and Paid Ratio KPIs
- Monthly paid trend
- Claim type cost distribution
  
![Executive Overview](<Power BI/dashboard_overview.jpg>)

## 2. Procedure & Diagnosis Cost Drivers
- Top 10 CPT and ICD codes by total paid amount
- Average paid per claim for high impact procedures

![Procedure & Diagnosis Cost Drivers](<Power BI/cost_drivers.jpg>)
  
## 3. High-Cost Member Analysis
- Pareto analysis identifying members driving the majority of costs
- Cost breakdown by claim type
- Member risk segmentation

![High-Cost Member Analysis](<Power BI/high_cost_members.jpg>)

## 4. Margin Leakage Analysis
- Paid ratio comparison by claim type, provider, and CPT code
- Scatter plot highlighting high-billing CPT codes with low reimbursement efficiency
- Provider-level reimbursement efficiency summary
- Paid Ratio is calculated as Total Paid ÷ Total Billed (weighted ratio).

![Margin Leakage Analysis](<Power BI/margin_leakage.jpg>)


## 💡 Key Insights
- A small subset of members accounts for a disproportionate share of total healthcare costs
- Inpatient claims are the largest contributors to total paid amounts
- Certain CPT codes have high financial exposure but low reimbursement efficiency
- Paid-to-billed ratios vary significantly across providers, indicating potential margin leakage

## ✅ Business Questions – Summary of Findings

This analysis answers the original business questions as follows:

- **Which claim types are the most expensive?**  
  Inpatient and outpatient claims account for the largest share of total paid amounts, indicating that facility-based care is the primary cost driver.
- **Which CPT and ICD codes drive the highest spending?**  
  A small number of CPT and ICD codes contribute disproportionately to total costs, driven by both high claim volume and high average cost per claim.
- **Which members account for the largest share of total costs?**  
  Pareto analysis shows that a minority of members are responsible for the majority of total healthcare spending, consistent with the 80/20 rule.
- **How do billed amounts compare to paid amounts?**  
  Paid-to-billed ratios vary significantly by claim type, provider, and CPT code, indicating differences in reimbursement efficiency and negotiated rates.
- **Where are potential reimbursement inefficiencies (margin leakage)?**  
  Certain providers and procedures exhibit high billed amounts but relatively low paid ratios, highlighting potential opportunities for contract review and cost optimization.

