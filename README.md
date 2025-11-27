🛒 Blinkit Retail Sales Analytics (SQL Project)
<img width="1024" height="1024" alt="Generated Image November 27, 2025 - 2_51PM" src="https://github.com/user-attachments/assets/c3d0b6dd-10a1-4e33-b32c-aa8bcb7cd5f2" />


A complete retail analytics project built using SQL Server, delivering insights on product sales, outlet performance, customer shopping patterns, and category-wise revenue based on real Blinkit (Grofers)-style retail data.

This project demonstrates how raw retail transactional data can be cleaned, modeled, analyzed, and transformed into actionable business metrics.

📌 Project Overview

This project analyzes 8,523 retail items across multiple Blinkit-style outlets to answer key business questions:

What is the total sales generated?

Which outlets perform best?

How do product categories contribute to revenue?

How does fat content affect customer sales?

Which outlet type, size, and location perform highest?

What is the customer rating behavior across outlets?

🗂 Dataset Description
Main Table: blinkit_data

Below is a clean HTML table version of the dataset fields:

<table> <tr><th>Column</th><th>Description</th></tr> <tr><td>Item_ID</td><td>Unique identifier for each retail item</td></tr> <tr><td>Outlet_Establishment_Year</td><td>Year in which the outlet was established</td></tr> <tr><td>Outlet_Size</td><td>Size category of outlet (Small, Medium, High)</td></tr> <tr><td>Outlet_Location_Type</td><td>Tier-1 / Tier-2 / Tier-3 city classification</td></tr> <tr><td>Item_Type</td><td>Product category (Dairy, Snacks, Frozen, etc.)</td></tr> <tr><td>Item_MRP</td><td>Maximum retail price</td></tr> <tr><td>Item_Visibility</td><td>Percentage visibility on display</td></tr> <tr><td>Item_Fat_Content</td><td>Regular / Low Fat category</td></tr> <tr><td>Rating</td><td>Customer rating for the product</td></tr> <tr><td>Total_Sales</td><td>Total sales amount contributed by the item</td></tr> </table>
🧩 ER Diagram (PNG)

Here is your clean ER Diagram PNG (Blinkit dataset has only 1 table):

<img src="attachment:/mnt/data/A_diagram_in_the_form_of_an_Entity-Relationship_(E.png" width="420"/>

If you want a multi-table professional ERD, tell me:
➡️ “buddy generate advanced Blinkit schema”

📊 Key KPIs Computed
1. Total Sales
SELECT CONCAT(CAST(SUM(Total_Sales)/1000000 AS DECIMAL(10,2)), ' Million') AS Total_Sales
FROM blinkit_data;


✔ Result: 1.20 Million

2. Average Sale
SELECT CAST(AVG(Total_Sales) AS INT) FROM blinkit_data;


✔ Result: 140

3. Number of Items / Orders
SELECT COUNT(*) AS No_of_orders FROM blinkit_data;


✔ Result: 8523

4. Average Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10, 1)) AS Avg_Rating FROM blinkit_data;


✔ Result: 4.0

🧠 Business Insights Summary

Total retail sales exceed ₹1.20 Million

Regular & Low-Fat products show strong variation in revenue

Grocery & Staples dominate sales categories

Medium-sized outlets contribute the highest revenue

Tier 3 outlets outperform Tier 1 in average ratings

Outlets established before 2000 show more stable performance

📈 Granular Sales Insights
Sales by Fat Content
SELECT
    Item_Fat_Content,
    SUM(Total_Sales) AS Total_Sales,
    AVG(Total_Sales) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    AVG(Rating) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

Sales by Item Type
SELECT
    Item_Type,
    SUM(Total_Sales) AS Total_Sales,
    AVG(Total_Sales) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    AVG(Rating) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

Fat Content by Outlet (Pivot Analysis)
SELECT 
    Outlet_Location_Type,
    ISNULL([Low Fat], 0) AS Low_Fat,
    ISNULL([Regular], 0) AS Regular
FROM (
    SELECT
        Outlet_Location_Type,
        Item_Fat_Content,
        SUM(Total_Sales) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT (
    SUM(Total_Sales)
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;

Sales by Establishment Year
SELECT
    Outlet_Establishment_Year,
    SUM(Total_Sales) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

Sales % by Outlet Size
SELECT
 Outlet_Size,
 SUM(Total_Sales) AS Total_Sales,
 SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER() AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

All Outlet Type Metrics
SELECT
    Outlet_Type,
    SUM(Total_Sales) AS Total_Sales,
    AVG(Total_Sales) AS Avg_Sales,
    COUNT(*) AS No_of_Items,
    AVG(Rating) AS Avg_Rating,
    AVG(Item_Visibility) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

🏗 Tech Stack

SQL Server

T-SQL

Azure Data Studio / SSMS

Power BI (optional dashboards)

📁 Folder Structure
blinkit-sql-analysis/
│
├── data/
├── sql/
├── visuals/
├── README.md

👨‍💻 Author

theBappy
