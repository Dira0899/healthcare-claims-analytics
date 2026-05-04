--  HIGH COST MEMBER ANALYSIS
-- Total paid per member
WITH member_spend AS (
    SELECT
        member_id,
        SUM(paid_amount) AS total_paid
    FROM claims
    GROUP BY member_id
),
ranked AS (
    SELECT
        member_id,
        total_paid,
        
        -- Total spend across all members
        SUM(total_paid) OVER () AS overall_paid,
        -- Running cumulative spend
        SUM(total_paid) OVER (ORDER BY total_paid DESC) AS cumulative_paid
    FROM member_spend
)
SELECT
    member_id,
    total_paid,
    cumulative_paid / overall_paid AS cumulative_percentage
FROM ranked
ORDER BY total_paid DESC;
