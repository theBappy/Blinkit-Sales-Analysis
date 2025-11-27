-------------------------------------------------------------
-- ?? 1. Preview Raw Data
--    Check the structure and sample rows before cleaning.
-------------------------------------------------------------
SELECT 
    * 
FROM blinkit_data;

-------------------------------------------------------------
-- ?? 2. Count Total Records
--    Helps verify data volume before & after cleaning.
-------------------------------------------------------------
SELECT 
    COUNT(*) AS Total_Rows
FROM blinkit_data;

-------------------------------------------------------------
-- ?? 3. Data Cleaning: Standardizing Item_Fat_Content
-- 
-- The column contains inconsistent values:
--   - 'LF', 'Low fat'   ? 'Low Fat'
--   - 'reg'             ? 'Regular'
-- 
-- Goal: Normalize these values for accurate analysis.
-------------------------------------------------------------
UPDATE blinkit_data
SET Item_Fat_Content = CASE 
        WHEN Item_Fat_Content IN ('LF', 'Low fat') THEN 'Low Fat'
        WHEN Item_Fat_Content = 'reg' THEN 'Regular'
        ELSE Item_Fat_Content
    END;

-------------------------------------------------------------
-- ?? 4. Validate Cleaning
--    Check distinct values after standardization.
-------------------------------------------------------------
SELECT 
    DISTINCT Item_Fat_Content
FROM blinkit_data;
