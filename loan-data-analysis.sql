-- ============================================================================================
--                             Customer Loan Data Analysis Project                             
-- ============================================================================================
use customer_loan_db;
GO

-- =====================================
-- BASIC QUERIES      
-- =====================================
---- Total loan Applications
select COUNT(*) as total_applications
from dbo.customer_loan_cleaned;

---- Total Approved loans
select COUNT(*) as approved_loans
from dbo.customer_loan_cleaned
where remarks ='Approved';

---- Total Rejected loans
select COUNT(*) as rejected_loans
from dbo.customer_loan_cleaned
where remarks ='Rejected';

-- =====================================
-- Customer Analysis
-- =====================================
---- Financial & loan Volume Analysis
 SELECT
	COUNT(*) as total_customers,
	SUM(loan_amt) as total_loan_amount,
	AVG(roi) as average_interest_rate,
	AVG(tenure) as average_months_tenure
 FROM dbo.customer_loan_cleaned;


 ---- Regional & City Breakdown
 SELECT
	region,
	city,
	COUNT(*) as customer_count,
	SUM(loan_amt) as total_loan_volume
FROM dbo.customer_loan_cleaned
GROUP BY region, city
ORDER BY total_loan_volume DESC;


---- Sales Representaive Performance
SELECT
	sales_manager,
	sales_rep,
	COUNT(*) as deals_closed,
	SUM(disb_amount) as total_disbursed
FROM dbo.customer_loan_cleaned
GROUP BY sales_manager, sales_rep
ORDER BY total_disbursed DESC;


---- Scheme and Dealer Popularity
SELECT 
    scheme_code, 
    dealer, 
    COUNT(*) AS total_applications,
    AVG(loan_amt) AS average_loan_size
FROM dbo.customer_loan_cleaned
GROUP BY scheme_code, dealer
ORDER BY total_applications DESC;


-- =====================================
-- Loan Analysis
-- =====================================
---- Loan Disbursement & Variance Analysis
SELECT 
    COUNT(*) AS total_loans,
    SUM(loan_amt) AS total_requested_amount,
    SUM(disb_amount) AS total_disbursed_amount,
    SUM(loan_amt) - SUM(disb_amount) AS total_shortfall,
    AVG(disb_var) AS average_disbursal_variance
FROM dbo.customer_loan_cleaned;

----  Tenure and Interest Rate Risk Analysis
SELECT 
    tenure AS loan_tenure_months,
    COUNT(*) AS total_accounts,
    MIN(roi) AS minimum_roi,
    MAX(roi) AS maximum_roi,
    AVG(roi) AS average_roi,
    SUM(disb_amount) AS total_disbursed_in_tier
FROM dbo.customer_loan_cleaned
GROUP BY tenure
ORDER BY loan_tenure_months ASC;

-----  Status Performance Metrics
SELECT 
    remarks AS loan_status,
    COUNT(*) AS application_count,
    SUM(loan_amt) AS total_portfolio_value,
    AVG(loan_amt) AS average_loan_size
FROM dbo.customer_loan_cleaned
GROUP BY remarks
ORDER BY application_count DESC;

---- Sales Performance Ranking
WITH ManagerRanking AS (
    SELECT 
        sales_manager,
        SUM(disb_amount) AS total_disbursed,
        COUNT(*) AS loans_closed,
        DENSE_RANK() OVER (ORDER BY SUM(disb_amount) DESC) AS manager_rank
    FROM dbo.customer_loan_cleaned
    GROUP BY sales_manager
)
SELECT * 
FROM ManagerRanking 
WHERE manager_rank <= 5;

---- Top 3 Customers with the Highest Loan Amount in Each Branch
WITH RankedCustomers AS (
    SELECT 
        customer,
        city AS branch,
        loan_amt,
        roi AS interest_rate,
        DENSE_RANK() OVER (PARTITION BY city ORDER BY loan_amt DESC) AS customer_rank
    FROM dbo.customer_loan_cleaned
)
SELECT 
    branch,
    customer_rank,
    customer,
    loan_amt
FROM RankedCustomers
WHERE customer_rank <= 3
ORDER BY branch ASC, customer_rank ASC;

---- Geographic Concentration & Market Share
WITH TotalCompanyVolume AS (
    SELECT SUM(disb_amount) AS overall_total FROM dbo.customer_loan_cleaned)
SELECT 
    region,
    COUNT(*) AS customer_count,
    SUM(disb_amount) AS regional_disbursed,
    ROUND((SUM(disb_amount) * 100.0) / (SELECT overall_total FROM TotalCompanyVolume), 2)
    AS market_share_percentage
FROM dbo.customer_loan_cleaned
GROUP BY region
ORDER BY regional_disbursed DESC;
---- Interest Rate Tiers (Low, Medium, High)
SELECT 
    CASE 
        WHEN roi < 8 THEN 'Low Interest'
        WHEN roi BETWEEN 8 AND 12 THEN 'Medium Interest'
        ELSE 'High Interest'
    END AS loan_tier,
    COUNT(*) AS total_loans,
    SUM(disb_amount) AS total_money
FROM dbo.customer_loan_cleaned
GROUP BY 
    CASE 
        WHEN roi < 8 THEN 'Low Interest'
        WHEN roi BETWEEN 8 AND 12 THEN 'Medium Interest'
        ELSE 'High Interest'
    END;
---- Data Quality Check
SELECT 
    COUNT(CASE WHEN app_id IS NULL THEN 1 END) AS missing_ids,
    COUNT(CASE WHEN loan_amt <= 0 THEN 1 END) AS negative_loans
FROM dbo.customer_loan_cleaned;



