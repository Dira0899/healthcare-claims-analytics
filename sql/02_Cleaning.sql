-- 2. DATE CONVERSION & CLEANING

-- Convert claim_date from string to DATE
UPDATE claims
SET claim_date = STR_TO_DATE(claim_date, '%m/%d/%Y');
ALTER TABLE claims
MODIFY claim_date DATE;

-- Convert enrollment_start_date to DATE
UPDATE members
SET enrollment_start_date = STR_TO_DATE(enrollment_start_date, '%m/%d/%Y');
ALTER TABLE members
MODIFY enrollment_start_date DATE;

-- Handle empty enrollment_end_date values
UPDATE members
SET enrollment_end_date = NULL
WHERE enrollment_end_date = '';

-- Convert enrollment_end_date to DATE
UPDATE members
SET enrollment_end_date = STR_TO_DATE(enrollment_end_date, '%m/%d/%Y')
WHERE enrollment_end_date IS NOT NULL;
ALTER TABLE members
MODIFY enrollment_end_date DATE;

SELECT *
FROM claims;
SELECT *
FROM members;

-- 3. DATA QUALITY CHECKS

-- Check valid claim types
SELECT DISTINCT claim_type
FROM claims;

-- Identify missing financial values
SELECT *
FROM claims
WHERE billed_amount IS NULL
   OR paid_amount IS NULL;
DELETE FROM claims
WHERE billed_amount IS NULL
	OR billed_amount <= 0;

-- Validate amount ranges
SELECT
    MIN(paid_amount),
    MAX(paid_amount),
    MIN(billed_amount),
    MAX(billed_amount)
FROM claims;

-- Identify overpaid claims (potential anomalies)
SELECT COUNT(*) AS overpaid_claims
FROM claims
WHERE paid_amount > billed_amount;

-- Detect duplicate claim IDs
SELECT claim_id, COUNT(*)
FROM claims
GROUP BY claim_id
HAVING COUNT(*) > 1;
