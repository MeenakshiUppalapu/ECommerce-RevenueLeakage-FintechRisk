-- =====================================================================
-- Portfolio Case Study: E-Commerce Revenue Leakage & Fintech Credit Risk
-- Purpose: In-database distribution testing and business logic validation
-- =====================================================================

-- ---------------------------------------------------------------------
-- QUERY 1: Income Tier Credit Risk Matrix
-- Objective: Identify which financial brackets present the highest default volatility.
-- ---------------------------------------------------------------------
WITH income_segments AS (
    SELECT 
        customer_unique_id,
        total_ecom_spend,
        bnpl_default_status,
        -- Aligned with the final Power BI Star-Schema business thresholds
        CASE 
            WHEN annual_income < 25000 THEN 'Low Income (<$25K)'
            WHEN annual_income BETWEEN 25000 AND 55000 THEN 'Medium Income ($25K-$55K)'
            ELSE 'High Income (>$55K)'
        END AS income_tier
    FROM 'embedded_finance_risk_matrix.csv' 
)
SELECT 
    income_tier,
    COUNT(customer_unique_id) AS total_customers,
    SUM(total_ecom_spend) AS total_checkout_volume,
    SUM(bnpl_default_status) AS total_defaults,
    -- Calculate the exact percentage of loans failing to repay
    ROUND((SUM(bnpl_default_status) / COUNT(customer_unique_id)) * 100, 2) AS default_rate_percentage
FROM income_segments
GROUP BY income_tier
ORDER BY default_rate_percentage DESC;


-- ---------------------------------------------------------------------
-- QUERY 2: Revenue Leakage Matrix by Transaction Scale
-- Objective: Isolate exactly where the business is losing cold hard cash.
-- ---------------------------------------------------------------------
WITH risk_metrics AS (
    SELECT 
        customer_unique_id,
        total_ecom_spend,
        bnpl_default_status,
        -- Grouping customers by their physical checkout basket size
        CASE 
            WHEN total_ecom_spend < 100 THEN 'Small Basket (<$100)'
            WHEN total_ecom_spend BETWEEN 100 AND 300 THEN 'Medium Basket ($100-$300)'
            ELSE 'Large Luxury Basket (>$300)'
        END AS basket_size
    FROM 'embedded_finance_risk_matrix.csv'
)
SELECT 
    basket_size,
    COUNT(customer_unique_id) AS transactional_count,
    SUM(total_ecom_spend) AS gross_merchandise_value,
    -- Aggregate total capital lost directly to unpaid fintech default contracts
    SUM(CASE WHEN bnpl_default_status = 1 THEN total_ecom_spend ELSE 0 END) AS credit_revenue_leakage,
    -- Leakage Ratio Metric
    ROUND(
        (SUM(CASE WHEN bnpl_default_status = 1 THEN total_ecom_spend ELSE 0 END) / SUM(total_ecom_spend)) * 100, 
        2
    ) AS leakage_ratio_percentage
FROM risk_metrics
GROUP BY basket_size
ORDER BY credit_revenue_leakage DESC;