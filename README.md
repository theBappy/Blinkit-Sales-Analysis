<div align="center">🛒 Blinkit Retail Analytics (SQL Project)</div>
<div align="center"> A complete retail sales & outlet performance analysis using Microsoft SQL Server. All data cleaning, KPI generation, revenue analysis, and outlet segmentation are performed using SQL queries. </div>
<br>
📌 Project Overview

This project analyzes Blinkit-style retail grocery sales data using SQL Server.
It includes full data cleaning, KPI calculations, outlet performance,
item segmentation, and fat-content-based performance.

The dataset contains information about:

Item sales

Item types & fat content

Outlet demographics

Ratings

Establishment year

Location & size

<br>
🗂️ Folder Structure
<table> <tr><th>Folder</th><th>Description</th></tr> <tr><td><b>/sql/01_data_cleaning.sql</b></td> <td>Scripts for cleaning raw Blinkit dataset (fat content fix, null handling)</td></tr> <tr><td><b>/sql/02_kpi_analysis.sql</b></td> <td>All high-level KPI calculations (Total Sales, Avg Sales, No. of Items, Rating)</td></tr> <tr><td><b>/sql/03_granular_analysis.sql</b></td> <td>Item-level & outlet-level performance queries</td></tr> <tr><td><b>/sql/04_pivot_reports.sql</b></td> <td>Pivot tables (Fat content × Outlet type)</td></tr> <tr><td><b>/assets/er_diagram.png</b></td> <td>ER diagram for Blinkit data model</td></tr> </table>
<br>
🧩 ER Diagram
<div align="center"> <img src="assets/er_diagram.png" width="650"> </div>
<br>
📊 KPI Summary Dashboard (SQL Results)
<table> <tr><th>KPI</th><th>Result</th></tr> <tr> <td><b>Total Sales</b></td> <td>1.20 Million INR</td> </tr> <tr> <td><b>Average Sales per Item</b></td> <td>140 INR</td> </tr> <tr> <td><b>Total Items Sold</b></td> <td>8523 Items</td> </tr> <tr> <td><b>Average Rating</b></td> <td>4.0 / 5</td> </tr> </table>
<br>
🧹 Data Cleaning (SQL)
-- View raw data
SELECT * FROM blinkit_data;

-- Count records
SELECT COUNT(*) FROM blinkit_data;

-- Clean Item_Fat_Content values
UPDATE blinkit_data
SET Item_Fat_Content = 
    CASE 
        WHEN Item_Fat_Content IN ('LF', 'Low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

-- Verify cleanup
SELECT DISTINCT Item_Fat_Content
FROM blinkit_data;

<br>
📈 KPI Queries
-- Total Sales (in Millions)
SELECT 
    CONCAT(CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10,2)), ' Million') AS Total_Sales
FROM blinkit_data;

-- Avg Sale Per Item
SELECT CAST(AVG(Total_Sales) AS INT) FROM blinkit_data;

-- Number of Items
SELECT COUNT(*) AS No_of_orders FROM blinkit_data;

-- Average Rating
SELECT CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating FROM blinkit_data;

<br>
📊 Granular Analysis
1. Total Sales by Fat Content
SELECT
	Item_Fat_Content,
	CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;

2. Total Sales by Item Type
SELECT
	Item_Type,
	CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
	COUNT(*) AS No_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;

3. Fat Content Pivot by Outlet Type
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

<br>
🏬 Outlet Performance
Sales by Establishment Year
SELECT
    Outlet_Establishment_Year,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

Sales % by Outlet Size
SELECT
 Outlet_Size,
 CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
 CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

Sales by Location Type
SELECT
	Outlet_Location_Type,
	CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

All Metrics by Outlet Type
SELECT
	Outlet_Type,
	CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
	CAST(AVG(Total_Sales) AS DECIMAL(10, 0)) AS Avg_Sales,
	COUNT(*) AS No_of_Items,
	CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating,
	CAST(AVG(Item_Visibility) AS DECIMAL(10, 2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

<br>
📘 Conclusion

This project delivers:

✔ Cleaned & standardized Blinkit dataset
✔ All KPI calculations
✔ Outlet & item level performance analytics
✔ Pivot tables & segmentation
✔ Production-ready SQL scripts
