-- ANALYTICS VIEW

-- 1. MEMBER COST

-- Total spend and claim count per member
CREATE VIEW vw_member_costs AS
SELECT
    member_id,
    SUM(paid_amount) AS total_paid,
    COUNT(*) AS claim_count
FROM claims
GROUP BY member_id;

-- 2. Member Risk
CREATE VIEW vw_member_risk AS
SELECT *,
    CASE
        WHEN total_paid > 50000 THEN 'High Risk'
        WHEN total_paid BETWEEN 20000 AND 50000 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level
FROM vw_member_costs;

-- 3. PROVIDER PERFORMANCE

CREATE VIEW vw_provider_efficiency AS
SELECT
    provider_id,
	-- Ratio of paid to billed
    SUM(paid_amount) / SUM(billed_amount) AS provider_paid_ratio,
	-- Number of claims handled
    COUNT(*) AS claim_volume
FROM claims
GROUP BY provider_id;


-- 4. GOLD ANALYTICS VIEW

CREATE VIEW vw_claims_gold AS
SELECT
	-- Claim details
    c.claim_id,
    c.claim_date,
    YEAR(c.claim_date)  AS claim_year,
    MONTH(c.claim_date) AS claim_month,

    c.claim_type,
    c.cpt_code,
    c.icd_code,
    c.provider_id,
    
	-- Financials
    c.billed_amount,
    c.paid_amount,
    c.paid_amount / c.billed_amount AS paid_ratio,
    
	-- Member attributes
    m.member_id,
    m.member_age,
    m.member_gender,
    m.plan_type,
    m.enrollment_start_date,
    m.enrollment_end_date
FROM claims c
LEFT JOIN members m
    ON c.member_id = m.member_id
WHERE c.billed_amount > 0;

SELECT table_name
FROM information_schema.views
WHERE table_schema = DATABASE();
