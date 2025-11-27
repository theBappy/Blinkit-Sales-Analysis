---------------------------------------------------------------------
-- ?? 1. Total Sales by Outlet Establishment Year
--    Shows how total sales vary by the year the outlet was established.
--    Helps analyze performance of older vs new outlets.
---------------------------------------------------------------------
SELECT
    Outlet_Establishment_Year,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;


---------------------------------------------------------------------
-- ?? 2. Percentage of Sales by Outlet Size
--    Breaks down sales by Small / Medium / High outlet sizes.
--    Also calculates percentage contribution using window function.
---------------------------------------------------------------------
SELECT
    Outlet_Size,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales,
    CAST(
        (SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) 
        AS DECIMAL(10, 2)
    ) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;


---------------------------------------------------------------------
-- ?? 3. Total Sales by Outlet Location Type
--    Compares sales across Tier 1, Tier 2, Tier 3 outlet locations.
---------------------------------------------------------------------
SELECT
    Outlet_Location_Type,
    CAST(SUM(Total_Sales) AS DECIMAL(10, 2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;


---------------------------------------------------------------------
-- ?? 4. All Key Metrics by Outlet Type
--    Provides a complete performance overview:
--      ? Total Sales
--      ? Average Sale
--      ? Number of Items
--      ? Average Customer Rating
--      ? Average Product Visibility
--    Useful for comparing:
--      Supermarket Type1, Type2, Type3, Grocery Store
---------------------------------------------------------------------
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
