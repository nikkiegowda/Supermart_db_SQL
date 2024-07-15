-------------------------- Assignment:-04 -------------------------

-------------- SELECTION COMMANDS:- (FILTERING):- in,like, between

-- 1.	Create a Supermart_DB with the tables created from the datasets shared (Customer.csv, Sales.csv and Product.csv files)
CREATE DATABASE Supermart_DB;

-- 2.	Define the relationship between the tables using constraints/keys.
USE Supermart_DB;
CREATE TABLE customers
(
customer_id VARCHAR(50) PRIMARY KEY,
customer_name VARCHAR(50),
segment varchar(50),
age int,
country VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
postal_code int,
region VARCHAR(50)
);
LOAD DATA INFILE 'C:/Customer.csv'
INTO TABLE customers 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;
CREATE TABLE Product (
   ProductID varchar(50) PRIMARY KEY,
   Category TEXT,
   sub_category TEXT,
   ProductName TEXT
);
LOAD DATA INFILE 'C:/Product.csv'
INTO TABLE Product 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

CREATE TABLE Sales (
   order_line int PRIMARY KEY,
   OrderID varchar(50) ,
   order_date NVARCHAR(50),
   ship_date NVARCHAR(50),
   ship_mode varchar(50),
   customer_id varchar(50),
   ProductID varchar(50),
   Sales decimal(10,4),
   Quantity INTEGER,
   Discount decimal(10,4),
   Profit decimal(10,4),
   FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
   FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
LOAD DATA INFILE 'C:/Sales.csv'
INTO TABLE Sales 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

SELECT * FROM customers;
SELECT * FROM Product;
SELECT * FROM Sales;

-- 3.	In the database Supermart_DB, find the following:
-- a.	Get the list of all the cities where the region is north or east without any duplicates using IN statement.
SELECT DISTINCT city
FROM customers
WHERE region IN ('North', 'East');

-- b.	Get the list of all orders where the ‘sales’ value is between100 and 500 using the BETWEEN operator.
SELECT * FROM Sales
WHERE sales BETWEEN 100 AND 500;

-- c.	Get the list of customers whose last name contains only 4 characters using LIKE.
SELECT * FROM Customers
WHERE LENGTH(last_name) = 4;

----------------------------- SELECTION COMMANDS:- ordering ---------------------------------

-- 1.	Retrieve all orders where the ‘discount’ value is greater than zero ordered in descending order basis ‘discount’ value
SELECT * FROM Sales
WHERE discount > 0
ORDER BY discount DESC;

-- 2.	Limit the number of results in the above query to the top 10.
SELECT * FROM Sales
WHERE discount > 0
ORDER BY discount DESC
LIMIT 10;

-------------------------- Aggregate commands:--------------------------

-- 1.	Find the sum of all ‘sales’ values.
SELECT SUM(sales) AS TotalSales
FROM Sales;

-- 2.	Find count of the number of customers in the north region with ages between 20 and 30
SELECT COUNT(*) AS CustomerCount
FROM Customers
WHERE region = 'North' AND age BETWEEN 20 AND 30;

-- 3.	Find the average age of east region customers
SELECT AVG(age) AS AverageAge
FROM Customers
WHERE region = 'East';

-- 4.	Find the minimum and maximum aged customers from Philadelphia
SELECT MIN(age) AS MinAge, MAX(age) AS MaxAge
FROM Customers
WHERE city = 'Philadelphia';

----------------------- GROUP BY COMMANDS:-----------------------

-- 1.	Make a dashboard showing the following figures for each product ID

-- a.	Total sales (in $) order by this column in descending 
-- b.	Total sales quantity
-- c.	The number of orders
-- d.	Max Sales value
-- e.	Min Sales value
-- f.	Average sales value

SELECT 
    ProductID,
    SUM(sales) AS total_sales,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT OrderID) AS num_orders,
    MAX(sales) AS max_sales,
    MIN(sales) AS min_sales,
    AVG(sales) AS avg_sales
FROM Sales
GROUP BY ProductID
ORDER BY total_sales DESC;

-- 2.	Get the list of product ID’s where the quantity of product sold is greater than 10

SELECT DISTINCT ProductID
FROM Sales
WHERE quantity > 10;



