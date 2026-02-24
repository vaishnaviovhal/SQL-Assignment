CREATE DATABASE Customers_Orders_Products;

USE Customers_Orders_Products;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductName VARCHAR(50),
    OrderDate DATE,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers (CustomerID, Name, Email) 
VALUES  
(1, 'John Doe', 'johndoe@example.com'),  
(2, 'Jane Smith', 'janesmith@example.com'),  
(3, 'Robert Johnson', 'robertjohnson@example.com'),  
(4, 'Emily Brown', 'emilybrown@example.com'),  
(5, 'Michael Davis', 'michaeldavis@example.com'),  
(6, 'Sarah Wilson', 'sarahwilson@example.com'),  
(7, 'David Thompson', 'davidthompson@example.com'),  
(8, 'Jessica Lee', 'jessicalee@example.com'),  
(9, 'William Turner', 'williamturner@example.com'),  
(10, 'Olivia Martinez', 'oliviamartinez@example.com'), 
(11, 'James Anderson', 'jamesanderson@example.com'), 
(12, 'Kelly Clarkson', 'kellyclarkson@example.com');

SELECT * FROM Customers

INSERT INTO Products (ProductID, ProductName, Price) 
VALUES  
(1, 'Product A', 10.99),  
(2, 'Product B', 8.99),  
(3, 'Product C', 5.99),  
(4, 'Product D', 12.99),  
(5, 'Product E', 7.99),  
(6, 'Product F', 6.99),  
(7, 'Product G', 9.99),  
(8, 'Product H', 11.99),  
(9, 'Product I', 14.99),  
(10, 'Product J', 4.99), 
(11, 'Product K', 3.99), 
(12, 'Product L', 15.99);

SELECT * FROM Products

INSERT INTO Orders (OrderID, CustomerID, ProductName, OrderDate, Quantity) 
VALUES  
(1, 1, 'Product A', '2023-07-01', 5),  
(2, 2, 'Product B', '2023-07-02', 3),  
(3, 3, 'Product C', '2023-07-03', 2),  
(4, 4, 'Product A', '2023-07-04', 1),  
(5, 5, 'Product B', '2023-07-05', 4),  
(6, 6, 'Product C', '2023-07-06', 2),  
(7, 7, 'Product A', '2023-07-07', 3),  
(8, 8, 'Product B', '2023-07-08', 2),  
(9, 9, 'Product C', '2023-07-09', 5),  
(10, 10, 'Product A', '2023-07-10', 1), 
(11, 11, 'Product D', '2023-07-10', 3), 
(12, 12, 'Product E', '2023-07-11', 6), 
(13, 5, 'Product G', '2023-07-12', 2), 
(14, 4, 'Product H', '2023-07-13', 4), 
(15, 6, 'Product I', '2023-07-14', 3);

SELECT * FROM Orders

-----Retrieve all records from Customers-------------------------
SELECT * FROM Customers;

-----Names & emails starting with ‘J’----------------------------
SELECT Name, Email
FROM Customers
WHERE Name LIKE 'J%';

-----Order details (OrderID, ProductName, Quantity)--------------
SELECT OrderID, ProductName, Quantity
FROM Orders;

-----Total quantity of products ordered--------------------------
SELECT SUM(Quantity) AS Total_Quantity
FROM Orders;

-----Customers who have placed an order--------------------------
SELECT DISTINCT C.Name
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID;

-----Products with price > $10------------------------------------
SELECT *
FROM Products
WHERE Price > 10.00;

-----Customer name & order date after '2023-07-05'-----------------
SELECT C.Name, O.OrderDate
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
WHERE O.OrderDate >= '2023-07-05';

-----Average price of all products---------------------------------
SELECT AVG(Price) AS Average_Price
FROM Products;

-----Customer names with total quantity ordered--------------------
SELECT C.Name, SUM(O.Quantity) AS Total_Quantity
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.Name;

-----Products not ordered-------------------------------------------
SELECT P.ProductName
FROM Products P
LEFT JOIN Orders O
ON P.ProductName = O.ProductName
WHERE O.ProductName IS NULL;
------------------------------------------------------------------------------------------------------------------------

-----Top 5 customers with highest total quantity---------------------
SELECT TOP 5 C.Name, SUM(O.Quantity) AS Total_Quantity
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.Name
ORDER BY Total_Quantity DESC;

-----Average price per product category----------------------------------
SELECT ProductName, AVG(Price) AS Avg_Price
FROM Products
GROUP BY ProductName;

-----Customers who have NOT placed any orders---------------------------
SELECT C.Name
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID
WHERE O.CustomerID IS NULL;

-----Orders placed by customers whose name starts with 'M'---------------
SELECT O.OrderID, O.ProductName, O.Quantity
FROM Orders O
JOIN Customers C
ON O.CustomerID = C.CustomerID
WHERE C.Name LIKE 'M%';

-----Total revenue from all orders---------------------------------------
SELECT SUM(O.Quantity * P.Price) AS Total_Revenue
FROM Orders O
JOIN Products P
ON O.ProductName = P.ProductName;

-----Customer name with total revenue------------------------------------
SELECT C.Name,
       SUM(O.Quantity * P.Price) AS Total_Revenue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Products P ON O.ProductName = P.ProductName
GROUP BY C.Name;

-----Customers who ordered every product----------------------------------
SELECT C.Name
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID
HAVING COUNT(DISTINCT O.ProductName) =
       (SELECT COUNT(*) FROM Products);

-----Customers who placed orders on consecutive days------------------------
SELECT DISTINCT C.Name
FROM Customers C
JOIN Orders O1 ON C.CustomerID = O1.CustomerID
JOIN Orders O2 ON C.CustomerID = O2.CustomerID
WHERE DATEDIFF(DAY, O1.OrderDate, O2.OrderDate) = 1;

-----Top 3 products with highest average quantity-----------------------
SELECT TOP 3 ProductName,
       AVG(Quantity) AS Avg_Quantity
FROM Orders
GROUP BY ProductName
ORDER BY Avg_Quantity DESC;

-----Percentage of orders with quantity > average------------------------
SELECT 
    (COUNT(*) * 100.0 /
    (SELECT COUNT(*) FROM Orders)) AS Percentage
FROM Orders
WHERE Quantity > (SELECT AVG(Quantity) FROM Orders);