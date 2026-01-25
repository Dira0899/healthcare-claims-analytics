-- 1. RAW TABLE CREATION 

-- Claims Table
CREATE TABLE claims (
    claim_id VARCHAR(50) PRIMARY KEY,
    member_id VARCHAR(50),
    provider_id VARCHAR(50),
    claim_date VARCHAR(50),
    claim_type VARCHAR(50),
    cpt_code VARCHAR(20),
    icd_code VARCHAR(20),
    billed_amount DECIMAL(12,2),
    paid_amount DECIMAL(12,2)
);

-- Member Table
CREATE TABLE members (
    member_id VARCHAR(50) PRIMARY KEY,
    member_age INT,
    member_gender VARCHAR(10),
    plan_type VARCHAR(50),
    enrollment_start_date VARCHAR(50),
    enrollment_end_date VARCHAR(50)
);

SELECT *
FROM claims;
SELECT *
FROM members;
