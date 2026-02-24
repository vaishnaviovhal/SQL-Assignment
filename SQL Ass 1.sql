CREATE DATABASE Brands;
CREATE DATABASE Products;

USE Brands;

CREATE TABLE ITEMS_TABLE (
    Item_Id INT,
    Item_Description VARCHAR(100),
    Bottle_Size INT,
    Bottle_Price DECIMAL(10,2),
    Vendor_Nos INT,
    Vendor_Name VARCHAR(100)
);

USE Products;

CREATE TABLE PRODUCT_SALES_TABLE (
    Product_Id INT,
    Country VARCHAR(50),
    Units_Sold FLOAT,
    Sale_Price DECIMAL(10,2),
    Gross_Sales DECIMAL(10,2),
    Profit DECIMAL(10,2),
    Year INT
);

SELECT * FROM ITEMS_TABLE

INSERT INTO ITEMS_TABLE VALUES
(1,'Travis Hasse Apple Pie',750,9.77,305,'Mhw Ltd'),
(2,'DAristi Xtabentun',750,14.2,391,'Anchor Distilling'),
(3,'Hiram Walker Peach Brandy',1000,6.5,370,'Pernod Ricard Usa'),
(4,'Oak Cross Whisky',750,25.33,305,'Mhw Ltd'),
(5,'Uv Red Vodka',200,1.97,380,'Philips Beverage Company'),
(6,'Heaven Hill Old Style White Label',750,6.37,259,'Heaven Hill Distilleries Inc'),
(7,'Hyde Herbal Liqueur',750,5.06,194,'Fire Tall Brands Llc'),
(8,'Dupont Calvados Fine Reserve',750,23.61,403,'Robert Kacher Selection');

DELETE TOP (1)
FROM ITEMS_TABLE
WHERE Item_Id = 1;

SELECT * FROM PRODUCT_SALES_TABLE 

INSERT INTO PRODUCT_SALES_TABLE VALUES 
(1,'Canada',16185,20,32370,16185,2014),
(2,'Germany',1321,20,26420,13210,2015),
(3,'France',2178,15,32670,10890,2016),
(4,'Germany',888,15,13320,4440,2017),
(5,'Mexico',2470,15,37050,12350,2018),
(6,'Germany',1513,350,529550,136170,0219),
(7,'Germany',921,15,13815,4605,2020),
(8,'Canada',2518,12,30216,22662,2021);

-----Delete products with Units Sold = 1618.5, 888, 2470-----
DELETE FROM PRODUCT_SALES_TABLE
WHERE Units_Sold IN (1618.5, 888, 2470);

-----Select item_description and bottle_price from ITEMS_TABLE-----
SELECT Item_Description, Bottle_Price
FROM ITEMS_TABLE;

-----Find items where bottle_price > 20-----
SELECT Item_Description, Bottle_Price
FROM ITEMS_TABLE
WHERE Bottle_Price > 20;

-----Select unique Country from PRODUCT_SALES_TABLE-----
SELECT DISTINCT Country
FROM PRODUCT_SALES_TABLE;

-----Count number of Countries in PRODUCT_SALES_TABLE-----
SELECT COUNT(DISTINCT Country) AS Total_Countries
FROM PRODUCT_SALES_TABLE;

-----Countries having Sales Price between 10 and 20-----
SELECT DISTINCT Country
FROM PRODUCT_SALES_TABLE
WHERE Sale_Price BETWEEN 10 AND 20;

======================================================================================================================================
-----Find the Total Sale Price and Total Gross Sales-----
SELECT 
    SUM(Sale_Price) AS Total_Sale_Price,
    SUM(Gross_Sales) AS Total_Gross_Sales
FROM PRODUCT_SALES_TABLE;

-----In which year did we get the highest sales-----
SELECT TOP 1 Year, SUM(Gross_Sales) AS Total_Sales
FROM PRODUCT_SALES_TABLE
GROUP BY Year
ORDER BY Total_Sales DESC;

-----Which Product has sales of $37,050-----
SELECT Product_Id
FROM PRODUCT_SALES_TABLE
WHERE Gross_Sales = 37050;

-----Countries with Profit between $4,605 and $22,662-----
SELECT DISTINCT Country
FROM PRODUCT_SALES_TABLE
WHERE Profit BETWEEN 4605 AND 22662;

-----Which Product_Id has sales of $24,700-----
SELECT Product_Id
FROM PRODUCT_SALES_TABLE
WHERE Gross_Sales = 24700;

-----Find total Units Sold for each Country-----
SELECT Country, SUM(Units_Sold) AS Total_Units_Sold
FROM PRODUCT_SALES_TABLE
GROUP BY Country;

-----Find average sales for each country-----
SELECT Country, AVG(Gross_Sales) AS Average_Sales
FROM PRODUCT_SALES_TABLE
GROUP BY Country;

-----Retrieve all products sold in 2014-----
SELECT *
FROM PRODUCT_SALES_TABLE
WHERE Year = 2014;

-----Find the maximum Profit-----
SELECT MAX(Profit) AS Maximum_Profit
FROM PRODUCT_SALES_TABLE;

-----Retrieve records where Profit > Average Profit-----
SELECT *
FROM PRODUCT_SALES_TABLE
WHERE Profit >
      (SELECT AVG(Profit) FROM PRODUCT_SALES_TABLE);

-----Find item_description with Bottle Size = 750-----
SELECT Item_Description
FROM ITEMS_TABLE
WHERE Bottle_Size = 750;

-----Vendor Name with Vendor_Nos = 305, 380, 391-----
SELECT DISTINCT Vendor_Name
FROM ITEMS_TABLE
WHERE Vendor_Nos IN (305, 380, 391);

-----What is total Bottle_Price-----
SELECT SUM(Bottle_Price) AS Total_Bottle_Price
FROM ITEMS_TABLE;

-----Which Item_Id has Bottle_Price = $5.06-----
SELECT Item_Id
FROM ITEMS_TABLE
WHERE Bottle_Price = 5.06;

----------------------------------------------------------------------------------------------------------------------------------

-----Vendor name & item_description where----------------------------------------------------------
SELECT Vendor_Name, Item_Description
FROM ITEMS_TABLE
WHERE Bottle_Size = 750
AND Bottle_Price < 10;

-----Find Top 3 most expensive items----------------------------------------------------------------
SELECT TOP 3 *
FROM ITEMS_TABLE
ORDER BY Bottle_Price DESC;

-----Split Item_Description into Item_desc1 and Item_desc2-------------------------------------------
SELECT
    LEFT(Item_Description, CHARINDEX(' ', Item_Description) - 1) AS Item_desc1,
    SUBSTRING(
        Item_Description,
        CHARINDEX(' ', Item_Description) + 1,
        LEN(Item_Description)
    ) AS Item_desc2
FROM ITEMS_TABLE;

-----SELECT TOP 1 Country, SUM(Gross_Sales) AS Total_Sales-------------------------------
SELECT TOP 1 Country, SUM(Gross_Sales) AS Total_Sales
FROM PRODUCT_SALES_TABLE
WHERE Year = 2018
GROUP BY Country
ORDER BY Total_Sales DESC;

-----Item & Vendor where Vendor_Nos appears more than once------------------------------------------
SELECT Item_Description, Vendor_Name
FROM ITEMS_TABLE
WHERE Vendor_Nos IN (
    SELECT Vendor_Nos
    FROM ITEMS_TABLE
    GROUP BY Vendor_Nos
    HAVING COUNT(*) > 1
);
-----------------------------------------------------------------------------------------------------------------------------------------
-----Find item_description and bottle_price--------------------------------
SELECT Item_Description, Bottle_Price
FROM ITEMS_TABLE
WHERE Vendor_Name = (
    SELECT Vendor_Name
    FROM ITEMS_TABLE
    WHERE Item_Id = 1
);

-----Create a Stored Procedure------------------------------------------------
CREATE PROCEDURE Get_Items_By_Price
    @Price DECIMAL(10,2)
AS
BEGIN
    SELECT *
    FROM ITEMS_TABLE
    WHERE Bottle_Price > @Price;
END;
EXEC Get_Items_By_Price 10;

-----Create Stored Procedure to Insert into PRODUCT_SALES_TABLE-----------------------------------------
CREATE PROCEDURE Insert_Product_Sale
    @Product_Id INT,
    @Country VARCHAR(50),
    @Units_Sold FLOAT,
    @Sale_Price DECIMAL(10,2),
    @Gross_Sales DECIMAL(10,2),
    @Profit DECIMAL(10,2),
    @Year INT
AS
BEGIN
    INSERT INTO PRODUCT_SALES_TABLE
    VALUES (@Product_Id, @Country, @Units_Sold,
            @Sale_Price, @Gross_Sales, @Profit, @Year);
END;

-----Find items containing word "Whisky" (case insensitive)-------------------------------------
SELECT Item_Description
FROM ITEMS_TABLE
WHERE LOWER(Item_Description) LIKE '%whisky%';

-----Combine Item_Description and Vendor_Name with hyphen--------------------------------------
SELECT 
    Item_Description + ' - ' + Vendor_Name AS Combined_Info
FROM ITEMS_TABLE;

-----Display Bottle_Price rounded to 1 decimal-------------------------------------------------------
SELECT 
    Item_Description,
    ROUND(Bottle_Price, 1) AS Rounded_Price
FROM ITEMS_TABLE;

 





