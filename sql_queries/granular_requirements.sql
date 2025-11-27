---------------------------------------------------------------------
-- ?? 1. Total Sales by Fat Content
--    Breakdown of sales, average sale, item count, and rating
--    grouped by item fat category (Low Fat vs Regular).
--    ?? Optional: filter results by specific outlet establishment year.
---------------------------------------------------------------------
SELECT
    Item_Fat_Content,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
-- WHERE Outlet_Establishment_Year = 2022   -- (Optional condition)
GROUP BY Item_Fat_Content
ORDER BY Total_Sales DESC;


---------------------------------------------------------------------
-- ?? 2. Total Sales by Item Type
--    Comparative performance across all product categories.
--    ?? To extract "Top 5" or "Bottom 5", modify ORDER BY direction.
---------------------------------------------------------------------
SELECT
    -- TOP 5                                    -- Uncomment for Top 5
    Item_Type,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL(10, 1)) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL(10, 2)) AS Avg_Rating
FROM blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC;     -- Change to ASC for Bottom 5


---------------------------------------------------------------------
-- Preview dataset (optional)
---------------------------------------------------------------------
SELECT * 
FROM blinkit_data;


---------------------------------------------------------------------
-- ?? 3. Fat Content Sales Distribution by Outlet Location Type
--    Using PIVOT to compare Low Fat vs Regular item sales 
--    across different location types (Urban, Tier 1, Tier 2 etc.).
---------------------------------------------------------------------
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
