🛒 Blinkit Sales Analytics – SQL Project

⚠️ Replace with your actual banner. If you want, say “buddy design blinkit banner” and I’ll create one.

📌 Project Overview

This project performs a complete retail sales and outlet performance analysis on Blinkit (Grofers)-style data using SQL Server.

You will find:

🔎 KPI Insights (Sales, Ratings, Orders)

🛍 Product Performance (Fat content, item types)

🏪 Outlet Analytics (size, location, establishment year)

📊 Pivot analysis for category-wise sales

🧹 Data cleaning & transformation scripts

This project is designed to replicate real-world retail analytics scenarios used in FMCG, supply chain, and supermarket analytics teams.

🗂 Dataset Overview

Main table:

blinkit_data
Column	Description
Item_Identifier	Unique product ID
Item_Weight	Product weight
Item_Fat_Content	Low Fat / Regular
Item_Visibility	Visibility score
Item_Type	Category of product
Item_MRP	Maximum retail price
Outlet_Identifier	Unique store code
Outlet_Establishment_Year	Year when outlet started
Outlet_Size	Small / Medium / High
Outlet_Location_Type	Tier 1 / Tier 2 / Tier 3
Outlet_Type	Grocery / Supermarket type1/2/3
Total_Sales	Total revenue from the item
Rating	Customer rating
🧩 ER Diagram
                    ┌──────────────────────────┐
                    │       blinkit_data       │
                    │--------------------------│
                    │ Item_Identifier          │
                    │ Item_Fat_Content         │
                    │ Item_Type                │
                    │ Item_Visibility          │
                    │ Item_MRP                 │
                    │ Total_Sales              │
                    │ Rating                   │
                    │                          │
                    │ Outlet_Identifier        │
                    │ Outlet_Est_Year          │
                    │ Outlet_Size              │
                    │ Outlet_Location_Type     │
                    │ Outlet_Type              │
                    └──────────────────────────┘


✔ Single fact table (denormalized dataset, retail-style)
✔ If you want a normalized schema for warehouse (fact + dims), I can build that too.

✔ If you want this ER diagram as a PNG, say “buddy generate ER PNG”.

📊 KPI Summary
✔ Total Sales

1.20 Million INR

✔ Average Sales per Item

140 INR

✔ Total Number of Items

8,523 items

✔ Average Customer Rating

4.0 / 5

📌 Key Business Findings
1. Fat Content Performance

Regular items outperform Low Fat in sales.

Ratings are nearly identical → customer preference driven by product type.

2. Item Type Insights

Top-selling product groups:

Fruits & Vegetables

Snack Foods

Frozen Foods

Dairy

3. Outlet Size Analysis

Medium outlets generate the highest revenue

High-size outlets have lower count but good average sales per item

4. Outlet Establishment

Newly established outlets (2010–2017) show highest sales activity

5. Outlet Type Performance

Supermarket Type1 is the dominant revenue generator

Grocery stores have far lower sales volume but stable ratings

🧼 Data Cleaning Script
UPDATE blinkit_data
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF','Low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

🧮 Core KPI Queries
Total Sales
SELECT 
    CONCAT(CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10,2)), ' Million') AS Total_Sales
FROM blinkit_data;

Average Sales
SELECT CAST(AVG(Total_Sales) AS INT) FROM blinkit_data;

Total Items
SELECT COUNT(*) FROM blinkit_data;

Average Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) FROM blinkit_data;

🏪 Outlet-Level Advanced Analysis
Sales by Outlet Size
SELECT
 Outlet_Size,
 CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
 CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

Sales by Fat Content (Pivot)
SELECT 
    Outlet_Location_Type,
    ISNULL([Low Fat], 0) AS Low_Fat,
    ISNULL([Regular], 0) AS Regular
FROM (
    SELECT
        Outlet_Location_Type,
        Item_Fat_Content,
        CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT
(
    SUM(Total_Sales)
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

🧱 Tech Stack

SQL Server

Azure Data Studio (optional)

Power BI / Tableau (for dashboards)

📁 Folder Structure
blinkit-sql-analysis/
│
├── data/
│   └── blinkit_data.csv
│
├── sql/
│   ├── cleaning.sql
│   ├── kpis.sql
│   ├── outlet_analysis.sql
│   ├── fat_content_pivot.sql
│   └── item_analysis.sql
│
├── visuals/
│   ├── dashboard.png
│   └── er-diagram.png
│
└── README.md

✨ Author

SH Haque
SQL Developer • Data Analyst • BI Dashboard Engineer
