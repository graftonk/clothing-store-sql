-- SQL Part 1A CREATE TABLE Statements for ClothingStore Database
-- Written by Kaylee Grafton and Brennan Owings

Use master;
Go
drop database ClothingStore;
Go
create database ClothingStore;
go

--------------------------------------------------
-- 1. CREATE PERSON TABLE
-- Create the Person table and add table constraints
-- Written by Kaylee Grafton
--------------------------------------------------
create table Person (
	PersonID int Not Null identity(1000,1),
	FirstName char(15) Not Null,
	LastName char(25) Not Null,
	Address char(25) Not Null,
	City char(20) Not Null,
	State char(2) Not Null default 'MI',
	ZipCode char(10) Not Null,
	Email varchar(25) Not Null default 'No Email',
	Phone char(12) Not Null default 'No Phone',
	PersonType char(1) Not Null default 'C',
-- table constraints
	constraint person_personid_pk primary key(PersonID),
	constraint person_persontype_ck check (PersonType in ('C', 'E', 'B')) -- c for customer, e for employee, b for both
);

--------------------------------------------------
-- 2. CREATE EMPLOYEE TABLE
-- Create the Employee table and add table constraints
-- Written by Kaylee Grafton
--------------------------------------------------
create table Employee (
	PersonID int Not Null,
	DateHired date Not Null,
	DateTerminated date,
	SSN char(12) Not Null Unique,
	DOB date Not Null,
	Position char(25) Not Null,
	PayRate decimal(10,2) Not Null,
-- table constraints
	constraint employee_personid_pk primary key(PersonID),
	constraint employee_personid_fk foreign key(PersonID) references Person(PersonID)
		on update cascade -- auto updates personid if it is changed elsewhere
	        on delete no action, -- prevents deleting employees if they have data in other tables
	constraint employee_ssn_uk unique(SSN)
);

--------------------------------------------------
-- 3. CREATE CUSTOMER TABLE
-- Create the Customer table and add table constraints
-- Written by Kaylee Grafton
--------------------------------------------------
create table Customer (
	PersonID int Not Null,
	CustomerSince date Not Null,
-- table constraints
	constraint customer_personid_pk primary key(PersonID),
	constraint customer_personid_fk foreign key(PersonID) references Person(PersonID)
		on update cascade -- auto updates personid if it is changed elsewhere
	        on delete no action -- prevents deleting customers if they have data in other tables
);


--------------------------------------------------
-- 4. CREATE ORDER TABLE
-- Create the Order table and add table constraints
-- Written by Brennan Owings
--------------------------------------------------
create table [Order](
	OrderID int Not Null identity(1000,1),
	OrderDate date Not Null,
	EmployeeIDTookOrder int Not Null,
	CustomerIDPlacedOrder int Not Null
	constraint order_orderid_pk primary key(OrderID),
	constraint order_EmployeeIDTookOrder_fk foreign key(EmployeeIDTookOrder) references Employee(PersonID)
		on update no action
		on delete no action,
	constraint order_customeridplacedorder_fk foreign key(CustomerIDPlacedOrder) references Customer(PersonID)
		on update no action
		on delete no action
);

--------------------------------------------------
-- 6. CREATE CATEGORY TABLE
-- Create the Category table and add table constraints
-- Written by Brennan Owings
--------------------------------------------------
create table Category(
	CategoryID int Not Null identity(1000,1),
	CategoryName char(15) Not Null,
	CategoryDescription varchar(225) Not Null,
	constraint category_categoryid_pk primary key(CategoryID)
);

--------------------------------------------------
-- 8. CREATE SUPPLIER TABLE
-- Create the Supplier table and add table constraints
-- Written by Brennan Owings
--------------------------------------------------
create table Supplier(
	SupplierID int Not Null identity(1000,1),
	SupplierName varchar(50) Not Null,
	ContactPerson varchar(50) Not Null,
	Phone char(12) Not Null,
	Email varchar(25) Not Null,
	constraint supplier_supplierid_pk primary key(SupplierID)

);

--------------------------------------------------
-- 9. CREATE ITEM TABLE
-- Create the Item table and add table constraints
-- Written by Brennan Owings
--------------------------------------------------
create table Item(
	ItemID int Not Null identity(1000,1),
	ItemName Char(15) Not Null,
	ItemDescription VarChar(30) Not Null,
	RetailPrice decimal(5, 2) Not Null,
	WholesalePrice decimal(5, 2) Not Null,
	SupplierID int Not Null,
	CategoryID int Not Null,
	constraint item_itemid_pk primary key(ItemID),
	constraint item_supplierid_fk foreign key(SupplierID) references Supplier(SupplierID)
		on update cascade
			on delete no action,
	constraint item_categoryid_fk foreign key(CategoryID) references Category(CategoryID)
		on update cascade
			on delete no action

);

--------------------------------------------------
-- 5. CREATE ORDER_ITEM TABLE
-- Create the Order_Item table and add table constraints
-- Written by Brennan Owings
--------------------------------------------------
create table Order_Item(
	OrderItemID int Not Null identity(1000,1),
	OrderID int Not Null,
	ItemID int Not Null,
	Quantity int Not Null,
	constraint orderitem_orderitemid_pk primary key(OrderItemID),
	constraint orderitem_orderid_fk foreign key(OrderID) references [Order](OrderID)
		on update cascade
		on delete no action,
	constraint orderitem_itemid_fk foreign key (ItemID) references Item(ItemID)
		on update cascade
		on delete no action,

);

--------------------------------------------------
-- 7. CREATE INVENTORY TABLE
-- Create the Inventory table and add table constraints
-- Written by Brennan Owings
--------------------------------------------------
create table Inventory(
	StockID int Not Null identity(1000,1),
	ItemID int Not Null,
	QuantityInStock int Not Null,
	ReorderLevel int Not Null,
	constraint inventory_inventoryid_pk primary key(StockID),
	constraint inventory_itemid_fk foreign key(ItemID) references Item(ItemID)
		on update cascade
			on delete no action,

);

--------------------------------------------------
-- 10. CREATE PAYMENT TABLE
-- Create the Payment table and add table constraints
-- Written by Brennan Owings
--------------------------------------------------
create table Payment(
	PaymentID int Not Null identity(1000,1),
	OrderID int Not Null,
	PaymentMethod varchar(20) Not Null,
	PaymentStatus varchar(15) Not Null,
	constraint payment_paymentid_pk primary key(PaymentID),
	constraint payment_orderid_fk foreign key(OrderID) references [Order](OrderID)
		on update cascade
			on delete no action
);

-- SQL Part 1B INSERT INTO Statements for ClothingStore Database
-- Written by Kaylee Grafton

--------------------------------------------------
-- 1. INSERT INTO PERSON TABLE
-- Insert sample data into the Person table
-- Written by Kaylee Grafton
--------------------------------------------------

insert into Person (FirstName, LastName, Address, City, State, ZipCode, Email, Phone, PersonType)
values
('Teisha', 'Alexander', '123 Maplewood St', 'Roseville', 'MI', '48066', 'talexander@gmail.com', '586-123-4567', 'E'),
('Freddie', 'Clark', '456 Cherry Blossom Ave', 'Warren', 'MI', '48088', 'fredclark@yahoo.com', '586-234-5678', 'E'),
('Matthew', 'Knight', '123 Meadowbrook Blvd', 'Macomb', 'MI', '48044', 'matthew.knight@aol.com', '586-345-6789', 'E'),
('Anna', 'Nicholson', '456 Autumn Ridge Rd', 'Macomb', 'MI', '48042', 'anicholson@gmail.com', '586-456-7890', 'E'),
('Sidney', 'Price', '987 Riverbend Rd', 'Clinton Twp', 'MI', '48038', 'sidneyprice@gmail.com', '586-567-8901', 'E'),
('Tanner', 'Cooke', '123 Birchwood Dr', 'Sterling Heights', 'MI', '48312', 'tannercooke@aol.com', '586-678-9012', 'E'),
('Alexis', 'Kramer', '456 Copperfield Ln', 'Sterling Heights', 'MI', '48313', 'alexiskramer@yahoo.com', '586-789-0123', 'E'),
('Aiden', 'Browning', '345 Sycamore St', 'Warren', 'MI', '48089', 'abrowning@gmail.com', '586-890-1234', 'B'),
('Devon', 'Miller', '789 Oakridge Dr', 'Roseville', 'MI', '48066', 'devonmiller@outlook.com', '586-901-2345', 'B'),
('Jackson', 'Carter', '567 Crestwood Dr', 'Clinton Twp', 'MI', '48038', 'jacksoncarter@hotmail.com', '586-012-3456', 'B'),
('Leah', 'Gibson', '654 Sunrise Blvd', 'Sterling Heights', 'MI', '48313', 'leahgibson@yahoo.com', '586-213-4567', 'C'),
('Jamie', 'Kelley', '654 Valley View St', 'Macomb', 'MI', '48044', 'jkelly@hotmail.com', '586-324-5678', 'C'),
('Charles', 'Saunders', '890 Aspen Grove Dr', 'Roseville', 'MI', '48066', 'csaunders@gmail.com', '586-435-6789', 'C'),
('Jessie', 'Norris', '234 Willow Creek Rd', 'Roseville', 'MI', '48066', 'bitethebullet@aol.com', '586-546-7890', 'C'),
('Skylar', 'Hughes', '567 Poplar Way', 'Warren', 'MI', '48088', 'skyhughes@gmail.com', '586-657-8901', 'C'),
('Keira', 'Edwards', '789 Maple Crest Ct', 'Sterling Heights', 'MI', '48310', 'pieceofcake@yahoo.com', '586-768-9012', 'C'),
('Sophia', 'Webb', '890 Greenfield Ln', 'Clinton Twp', 'MI', '48035', 'sophiawebb@gmail.com', '586-879-0123', 'C');

--------------------------------------------------
-- 2. INSERT INTO EMPLOYEE TABLE
-- Insert sample data into the Employee table
-- Written by Kaylee Grafton
--------------------------------------------------

insert into Employee (PersonID, DateHired, SSN, DOB, Position, PayRate)
values
(1000, '2020-01-15', '123-45-6789', '1984-12-21', 'Store Manager', 25.00),
(1001, '2019-06-20', '234-56-7890', '1988-06-02', 'Assistant Store Manager', 20.00),
(1002, '2021-03-10', '345-67-8901', '1973-02-01', 'Sales Associate', 14.75),
(1003, '2022-07-01', '456-78-9012', '1966-07-24', 'Cashier', 13.25),
(1004, '2023-11-05', '567-89-0123', '1992-11-03', 'Stock Associate', 13.50),
(1005, '2018-05-10', '678-90-1234', '1996-04-05', 'Cashier', 13.00),
(1006, '2020-10-01', '789-01-2345', '1990-05-01', 'Stock Associate', 13.25),
(1007, '2023-04-22', '890-12-3456', '1982-09-19', 'Sales Associate', 14.00),
(1008, '2021-12-15', '901-23-4567', '1995-08-29', 'Cashier', 13.00),
(1009, '2019-08-30', '012-34-5678', '1992-05-03', 'Stock Associate', 13.25);

--------------------------------------------------
-- 3. INSERT INTO CUSTOMER TABLE
-- Insert sample data into the Customer table
-- Written by Kaylee Grafton
--------------------------------------------------

insert into Customer (PersonID, CustomerSince)
values
(1007, '2021-04-12'),
(1008, '2020-09-15'),
(1009, '2022-01-20'),
(1010, '2021-11-08'),
(1011, '2023-03-18'),
(1012, '2022-06-24'),
(1013, '2020-08-10'),
(1014, '2019-12-05'),
(1015, '2023-02-17'),
(1016, '2024-01-22');

--------------------------------------------------
-- 4. INSERT INTO ORDER TABLE
-- Insert sample data into the Order table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into [Order] (OrderDate, EmployeeIDTookOrder, CustomerIDPlacedOrder)
values
('2025-04-01', 1002, 1016),
('2025-04-03', 1003, 1011),
('2025-04-04', 1005, 1008),
('2025-04-05', 1007, 1009),
('2025-04-06', 1008, 1010),
('2025-04-07', 1005, 1012),
('2025-04-08', 1007, 1015),
('2025-04-09', 1003, 1014),
('2025-04-10', 1002, 1007),
('2025-04-11', 1003, 1013);

--------------------------------------------------
-- 6. INSERT INTO CATEGORY TABLE
-- Insert sample data into the Category table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Category (CategoryName, CategoryDescription)
values
('Tops', 'Shirts, blouses, tees, etc.'),
('Bottoms', 'Pants, skirts, and shorts.'),
('Outerwear', 'Coats, jackets, vests, etc.'),
('Footwear', 'Shoes, boots, sandals, etc.'),
('Accessories', 'Hats, scarves, gloves, bags, belts, ties, jewelry, etc.');

--------------------------------------------------
-- 8. INSERT INTO SUPPLIER TABLE
-- Insert sample data into the Supplier table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Supplier (SupplierName, ContactPerson, Phone, Email)
values
('Trendy Threads', 'Lisa Green', '123-456-7890', 'lisa@threads.com'),
('Classic Apparel', 'John Smith', '234-567-8901', 'john@classicapparel.com'),
('Footwear Factory', 'Mark Taylor', '345-678-9012', 'mark@footwearfactory.com'),
('Outerwear Co.', 'Sarah Johnson', '456-789-0123', 'sarah@outwear.com'),
('Accessory World', 'Emily Brown', '567-890-1234', 'emily@accessoryworld.com');

--------------------------------------------------
-- 9. INSERT INTO ITEM TABLE
-- Insert sample data into the Item table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Item (ItemName, ItemDescription, RetailPrice, WholesalePrice, SupplierID, CategoryID)
values
('Cotton T-Shirt', 'Soft cotton, classic fit.', 15.00, 8.00, 1000, 1000),
('Denim Jeans', 'Sturdy with modern style', 40.00, 25.00, 1001, 1001),
('Leather Jacket', 'Sleek, warm, timeless', 150.00, 100.00, 1003, 1002),
('Running Shoes', 'Lightweight and flexible', 70.00, 40.00, 1002, 1003),
('Beanie Hat', 'Warm knit, snug fit', 10.00, 5.00, 1004, 1004),
('Summer Shorts', 'Cool, relaxed comfort', 25.00, 15.00, 1001, 1001),
('Wool Scarf', 'Cozy, textured finish', 20.00, 12.00, 1004, 1004),
('Casual Sneakers', 'Everyday walking ease', 50.00, 30.00, 1002, 1003),
('Raincoat', 'Durable and waterproof', 60.00, 35.00, 1003, 1002),
('Graphic Tee', 'Bold print, casual vibe', 18.00, 10.00, 1000, 1000);

--------------------------------------------------
-- 5. INSERT INTO ORDER_ITEM TABLE
-- Insert sample data into the Order_Item table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Order_Item (OrderID, ItemID, Quantity)
values
(1000, 1000, 2),
(1000, 1002, 1),
(1001, 1001, 1),
(1002, 1004, 4),
(1003, 1003, 2),
(1004, 1005, 1),
(1004, 1009, 1),
(1005, 1006, 2),
(1006, 1007, 1),
(1007, 1008, 2),
(1008, 1009, 2),
(1008, 1001, 2),
(1008, 1002, 1),
(1009, 1009, 3);

--------------------------------------------------
-- 7. INSERT INTO INVENTORY TABLE
-- Insert sample data into the Inventory table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Inventory (ItemID, QuantityInStock, ReorderLevel)
values
(1000, 20, 5),
(1001, 15, 4),
(1002, 10, 2),
(1003, 25, 5),
(1004, 30, 10),
(1005, 12, 3),
(1006, 18, 5),
(1007, 22, 6),
(1008, 8, 3),
(1009, 30, 10);

--------------------------------------------------
-- 10. INSERT INTO PAYMENT TABLE
-- Insert sample data into the Payment table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Payment (OrderID, PaymentMethod, PaymentStatus)
values
(1000, 'Credit Card', 'Completed'),
(1001, 'Cash', 'Completed'),
(1002, 'Debit Card', 'Pending'),
(1003, 'Credit Card', 'Completed'),
(1004, 'Cash', 'Completed'),
(1005, 'Credit Card', 'Pending'),
(1006, 'Debit Card', 'Completed'),
(1007, 'Credit Card', 'Completed'),
(1008, 'Cash', 'Completed'),
(1009, 'Debit Card', 'Completed');

-- SQL Part 2 Queries for ClothingStore Database
-- Written by Saifur Rahman

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
