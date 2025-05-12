-- Question 1: Transform ProductDetail table into 1NF
SELECT 
    OrderID, 
    CustomerName, 
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM 
    ProductDetail
JOIN 
    (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5) n
ON 
    CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1;

-- Question 2: Transform OrderDetails table into 2NF

-- Step 1: Create a table for customer details (CustomerID, CustomerName)
CREATE TABLE CustomerDetails (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Step 2: Insert the customer data into the new CustomerDetails table
INSERT INTO CustomerDetails (CustomerID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 3: Modify the OrderDetails table to include only the OrderID and Product, Quantity
CREATE TABLE OrderDetailsNew (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product)
);

-- Step 4: Insert the data into the new OrderDetails table
INSERT INTO OrderDetailsNew (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
