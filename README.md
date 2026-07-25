# End-to-End Customer Loan Analytics Pipeline (Python ➔ SQL Server)

##  Project Overview
This repository contains a comprehensive data pipeline project analyzing a retail consumer loan portfolio. The project encompasses raw data ingestion, programmatic data cleaning, database connection automation via Python, and an intensive analytical breakdown of 15+ complex business scenarios using T-SQL.

## Tech Stack & Skills Demonstrated
- **Data Cleaning & EDA:** python(Pandas, Numpy, Matplotlib, Seaborn
-  **Database Engine & Connection:** Microsoft SQL Server (T-SQL), Database Connection Drivers
- **Advanced SQL Features:** Common Table Expressions (CTEs), Window Functions (`DENSE_RANK`, `RANK`), Conditional Logic (`CASE WHEN`), and Time-Series Aggregations.

## Database Pipeline Connection
- Established a secure data interface linking the Python environment directly to Microsoft SQL Server.
- Automated the extraction and operational upload of the fully scrubbed dataset into the target schema table `dbo.customer_loan_cleaned`.

##  Key Queries & Analytical Focus
- **Portfolio Health Evaluation:** Tracked high-level approval percentages versus raw application volume.
- **Risk Portfolio Segmentation:** Grouped accounts into actionable Low, Medium, and High-Risk tranches using conditional metrics.
- **Operational Performance Rankings:** Evaluated team member capabilities through analytical leaderboard window rankings.
- **Channel Delivery Metrics:** Identified the top 5 distinct dealerships driving loan disbursement trends.

## How to Use
1. Clone or download this repository to your desktop machine.
2. Run your Python data cleaning script to preprocess and push the sanitized table directly to your database instance.
3. Open the `loan-data-analysis.sql` script inside SQL Server Management Studio (SSMS).
4. Execute the analytical queries against your database schema to inspect the business insights.
