# Customer Loan Data Analysis Project (SQL)

##  Project Overview
This repository contains an end-to-end SQL data analysis project designed to extract actionable business insights from a retail loan portfolio. The project spans over 15 distinct business scenarios, assessing key metrics like loan volumes, risk distributions, regional growth, and sales performance.

## Tech Stack & Skills Demonstrated
- **Database Engine:** Microsoft SQL Server (T-SQL)
- **SQL Mechanics:** CTEs, Window Functions (`DENSE_RANK`, `RANK`), Grouping & Aggregations, Conditional Logic (`CASE WHEN`), and Date Functions (`DATEPART`).

##  Key Queries & Analytical Focus
1. **Basic Portfolio KPIs:** Summarizing total applications, approval rates, and total rejection rates.
2. **Geographic & Product Analysis:** Drilling down into city/regional performance and tracking high-value loan schemes.
3. **Risk Segmentation:** Using interest rates (`roi`) to bucket active loans into Low, Medium, and High-Risk tiers.
4. **Performance Leaderboards:** Ranking individual sales representatives dynamically within their assigned manager teams.
5. **Channel Efficiency:** Identifying the top 5 dealership streams bringing in the highest loan volumes.

## How to Use
1. Clone or download this repository to your computer.
2. Open the `loan-data-analysis.sql` script inside SQL Server Management Studio (SSMS).
3. Run the script against your database to see the results.
