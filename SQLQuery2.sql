-- SQL Part 2 Queries for ClothingStore Database
-- Written by Saifur Rahman

USE ClothingStore;
GO

--------------------------------------------------
-- 1. WHERE clause
-- Select all employees hired after 2020
-- Written by Saifur Rahman
--------------------------------------------------
SELECT *
FROM Employee
WHERE DateHired > '2020-01-01';

--------------------------------------------------
-- 2. Multi-table JOIN
-- Get customer names and their order dates
-- Written by Saifur Rahman
--------------------------------------------------
SELECT p.FirstName, p.LastName, o.OrderDate
FROM Customer c
JOIN Person p ON c.PersonID = p.PersonID
JOIN [Order] o ON c.PersonID = o.CustomerIDPlacedOrder;

--------------------------------------------------
-- 3. JOIN with SET Operator
-- Get names of people who are only employees or only customers (not both)
-- Written by Saifur Rahman
--------------------------------------------------
SELECT p.FirstName, p.LastName, 'Employee' AS Role
FROM Employee e
JOIN Person p ON e.PersonID = p.PersonID
WHERE e.PersonID NOT IN (SELECT PersonID FROM Customer)

UNION

SELECT p.FirstName, p.LastName, 'Customer' AS Role
FROM Customer c
JOIN Person p ON c.PersonID = p.PersonID
WHERE c.PersonID NOT IN (SELECT PersonID FROM Employee);

--------------------------------------------------
-- 4. Subquery
-- List item names with quantity in stock below average
-- Written by Saifur Rahman
--------------------------------------------------
SELECT i.ItemName, inv.QuantityInStock
FROM Inventory inv
JOIN Item i ON inv.ItemID = i.ItemID
WHERE inv.QuantityInStock < (
    SELECT AVG(QuantityInStock) FROM Inventory
);

--------------------------------------------------
-- 5. OUTER JOIN
-- Show all items and their supplier names (including items without suppliers)
-- Written by Saifur Rahman
--------------------------------------------------
SELECT i.ItemName, s.SupplierName
FROM Item i
LEFT JOIN Supplier s ON i.SupplierID = s.SupplierID;

--------------------------------------------------
-- 6. GROUP BY
-- Get number of orders taken by each employee
-- Written by Saifur Rahman
--------------------------------------------------
SELECT e.PersonID, COUNT(o.OrderID) AS OrderCount
FROM Employee e
JOIN [Order] o ON e.PersonID = o.EmployeeIDTookOrder
GROUP BY e.PersonID;

--------------------------------------------------
-- 7. HAVING
-- Show employees who have taken more than 2 orders
-- Written by Saifur Rahman
--------------------------------------------------
SELECT e.PersonID, COUNT(o.OrderID) AS OrderCount
FROM Employee e
JOIN [Order] o ON e.PersonID = o.EmployeeIDTookOrder
GROUP BY e.PersonID
HAVING COUNT(o.OrderID) > 2;

-- End of SQL Queries --
