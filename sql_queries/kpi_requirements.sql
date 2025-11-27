-------------------------------------------------------------
-- ?? 1. Preview Raw Data
--    Helpful to verify column names & structure.
-------------------------------------------------------------
SELECT 
    * 
FROM blinkit_data;

-------------------------------------------------------------
-- ?? 2. Total Sales (in Millions)
--    Converts total sales into Million format for reporting.
-------------------------------------------------------------
SELECT 
    CONCAT(
        CAST(SUM(Total_Sales) / 1000000 AS DECIMAL(10, 2)),
        ' Million'
    ) AS Total_Sales
FROM blinkit_data;
-- ? Result: 1.20 Million

-------------------------------------------------------------
-- ?? 3. Average Sale per Item
--    Average of Total_Sales column.
-------------------------------------------------------------
SELECT
    CAST(AVG(Total_Sales) AS INT) AS Avg_Sale
FROM blinkit_data;
-- ? Result: 140

-------------------------------------------------------------
-- ?? 4. Number of Items (Total Orders)
--    Count total rows ? total unique products/items.
-------------------------------------------------------------
SELECT
    COUNT(*) AS No_of_Items
FROM blinkit_data;
-- ? Result: 8523

-------------------------------------------------------------
-- ?? 5. Average Rating
--    Rounded to 1 decimal place for dashboard accuracy.
-------------------------------------------------------------
SELECT
    CAST(AVG(Rating) AS DECIMAL(10,1)) AS Avg_Rating
FROM blinkit_data;
-- ? Result: 4.0
