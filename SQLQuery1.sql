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
	PersonID int Not Null,
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
	OrderID int Not Null,
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
	CategoryID int Not Null,
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
	SupplierID int Not Null,
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
	ItemID int Not Null,
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
	OrderItemID int Not Null,
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
	StockID int Not Null,
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
	PaymentID int Not Null,
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

insert into Person (PersonID, FirstName, LastName, Address, City, State, ZipCode, Email, Phone, PersonType)
values
(1, 'Teisha', 'Alexander', '123 Maplewood St', 'Roseville', 'MI', '48066', 'talexander@gmail.com', '586-123-4567', 'E'),
(2, 'Freddie', 'Clark', '456 Cherry Blossom Ave', 'Warren', 'MI', '48088', 'fredclark@yahoo.com', '586-234-5678', 'E'),
(3, 'Matthew', 'Knight', '123 Meadowbrook Blvd', 'Macomb', 'MI', '48044', 'matthew.knight@aol.com', '586-345-6789', 'E'),
(4, 'Anna', 'Nicholson', '456 Autumn Ridge Rd', 'Macomb', 'MI', '48042', 'anicholson@gmail.com', '586-456-7890', 'E'),
(5, 'Sidney', 'Price', '987 Riverbend Rd', 'Clinton Twp', 'MI', '48038', 'sidneyprice@gmail.com', '586-567-8901', 'E'),
(6, 'Tanner', 'Cooke', '123 Birchwood Dr', 'Sterling Heights', 'MI', '48312', 'tannercooke@aol.com', '586-678-9012', 'E'),
(7, 'Alexis', 'Kramer', '456 Copperfield Ln', 'Sterling Heights', 'MI', '48313', 'alexiskramer@yahoo.com', '586-789-0123', 'E'),
(8, 'Aiden', 'Browning', '345 Sycamore St', 'Warren', 'MI', '48089', 'abrowning@gmail.com', '586-890-1234', 'B'),
(9, 'Devon', 'Miller', '789 Oakridge Dr', 'Roseville', 'MI', '48066', 'devonmiller@outlook.com', '586-901-2345', 'B'),
(10, 'Jackson', 'Carter', '567 Crestwood Dr', 'Clinton Twp', 'MI', '48038', 'jacksoncarter@hotmail.com', '586-012-3456', 'B'),
(11, 'Leah', 'Gibson', '654 Sunrise Blvd', 'Sterling Heights', 'MI', '48313', 'leahgibson@yahoo.com', '586-213-4567', 'C'),
(12, 'Jamie', 'Kelley', '654 Valley View St', 'Macomb', 'MI', '48044', 'jkelly@hotmail.com', '586-324-5678', 'C'),
(13, 'Charles', 'Saunders', '890 Aspen Grove Dr', 'Roseville', 'MI', '48066', 'csaunders@gmail.com', '586-435-6789', 'C'),
(14, 'Jessie', 'Norris', '234 Willow Creek Rd', 'Roseville', 'MI', '48066', 'bitethebullet@aol.com', '586-546-7890', 'C'),
(15, 'Skylar', 'Hughes', '567 Poplar Way', 'Warren', 'MI', '48088', 'skyhughes@gmail.com', '586-657-8901', 'C'),
(16, 'Keira', 'Edwards', '789 Maple Crest Ct', 'Sterling Heights', 'MI', '48310', 'pieceofcake@yahoo.com', '586-768-9012', 'C'),
(17, 'Sophia', 'Webb', '890 Greenfield Ln', 'Clinton Twp', 'MI', '48035', 'sophiawebb@gmail.com', '586-879-0123', 'C');

--------------------------------------------------
-- 2. INSERT INTO EMPLOYEE TABLE
-- Insert sample data into the Employee table
-- Written by Kaylee Grafton
--------------------------------------------------

insert into Employee (PersonID, DateHired, SSN, DOB, Position, PayRate)
values
(1, '2020-01-15', '123-45-6789', '1984-12-21', 'Store Manager', 25.00),
(2, '2019-06-20', '234-56-7890', '1988-06-02', 'Assistant Store Manager', 20.00),
(3, '2021-03-10', '345-67-8901', '1973-02-01', 'Sales Associate', 14.75),
(4, '2022-07-01', '456-78-9012', '1966-07-24', 'Cashier', 13.25),
(5, '2023-11-05', '567-89-0123', '1992-11-03', 'Stock Associate', 13.50),
(6, '2018-05-10', '678-90-1234', '1996-04-05', 'Cashier', 13.00),
(7, '2020-10-01', '789-01-2345', '1990-05-01', 'Stock Associate', 13.25),
(8, '2023-04-22', '890-12-3456', '1982-09-19', 'Sales Associate', 14.00),
(9, '2021-12-15', '901-23-4567', '1995-08-29', 'Cashier', 13.00),
(10, '2019-08-30', '012-34-5678', '1992-05-03', 'Stock Associate', 13.25);

--------------------------------------------------
-- 3. INSERT INTO CUSTOMER TABLE
-- Insert sample data into the Customer table
-- Written by Kaylee Grafton
--------------------------------------------------

insert into Customer (PersonID, CustomerSince)
values
(8, '2021-04-12'),
(9, '2020-09-15'),
(10, '2022-01-20'),
(11, '2021-11-08'),
(12, '2023-03-18'),
(13, '2022-06-24'),
(14, '2020-08-10'),
(15, '2019-12-05'),
(16, '2023-02-17'),
(17, '2024-01-22');

--------------------------------------------------
-- 4. INSERT INTO ORDER TABLE
-- Insert sample data into the Order table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into [Order] (OrderID, OrderDate, EmployeeIDTookOrder, CustomerIDPlacedOrder)
values
(1, '2025-04-01', 3, 17),
(2, '2025-04-03', 4, 12),
(3, '2025-04-04', 6, 9),
(4, '2025-04-05', 8, 10),
(5, '2025-04-06', 9, 11),
(6, '2025-04-07', 6, 13),
(7, '2025-04-08', 8, 16),
(8, '2025-04-09', 4, 15),
(9, '2025-04-10', 3, 8),
(10, '2025-04-11', 4, 14);

--------------------------------------------------
-- 6. INSERT INTO CATEGORY TABLE
-- Insert sample data into the Category table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Category (CategoryID, CategoryName, CategoryDescription)
values
(1, 'Tops', 'Shirts, blouses, tees, etc.'),
(2, 'Bottoms', 'Pants, skirts, and shorts.'),
(3, 'Outerwear', 'Coats, jackets, vests, etc.'),
(4, 'Footwear', 'Shoes, boots, sandals, etc.'),
(5, 'Accessories', 'Hats, scarves, gloves, bags, belts, ties, jewelry, etc.');

--------------------------------------------------
-- 8. INSERT INTO SUPPLIER TABLE
-- Insert sample data into the Supplier table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Supplier (SupplierID, SupplierName, ContactPerson, Phone, Email)
values
(1, 'Trendy Threads', 'Lisa Green', '123-456-7890', 'lisa@threads.com'),
(2, 'Classic Apparel', 'John Smith', '234-567-8901', 'john@classicapparel.com'),
(3, 'Footwear Factory', 'Mark Taylor', '345-678-9012', 'mark@footwearfactory.com'),
(4, 'Outerwear Co.', 'Sarah Johnson', '456-789-0123', 'sarah@outwear.com'),
(5, 'Accessory World', 'Emily Brown', '567-890-1234', 'emily@accessoryworld.com');

--------------------------------------------------
-- 9. INSERT INTO ITEM TABLE
-- Insert sample data into the Item table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Item (ItemID, ItemName, ItemDescription, RetailPrice, WholesalePrice, SupplierID, CategoryID)
values
(1, 'Cotton T-Shirt', 'Soft cotton, classic fit.', 15.00, 8.00, 1, 1),
(2, 'Denim Jeans', 'Sturdy with modern style', 40.00, 25.00, 2, 2),
(3, 'Leather Jacket', 'Sleek, warm, timeless', 150.00, 100.00, 4, 3),
(4, 'Running Shoes', 'Lightweight and flexible', 70.00, 40.00, 3, 4),
(5, 'Beanie Hat', 'Warm knit, snug fit', 10.00, 5.00, 5, 5),
(6, 'Summer Shorts', 'Cool, relaxed comfort', 25.00, 15.00, 2, 2),
(7, 'Wool Scarf', 'Cozy, textured finish', 20.00, 12.00, 5, 5),
(8, 'Casual Sneakers', 'Everyday walking ease', 50.00, 30.00, 3, 4),
(9, 'Raincoat', 'Durable and waterproof', 60.00, 35.00, 4, 3),
(10, 'Graphic Tee', 'Bold print, casual vibe', 18.00, 10.00, 1, 1);

--------------------------------------------------
-- 5. INSERT INTO ORDER_ITEM TABLE
-- Insert sample data into the Order_Item table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Order_Item (OrderItemID, OrderID, ItemID, Quantity)
values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 1),
(4, 3, 5, 4),
(5, 4, 4, 2),
(6, 5, 6, 1),
(7, 5, 10, 1),
(8, 6, 7, 2),
(9, 7, 8, 1),
(10, 8, 9, 2),
(11, 9, 10, 2),
(12, 9, 2, 2),
(13, 9, 3, 1),
(14, 10, 10, 3);

--------------------------------------------------
-- 7. INSERT INTO INVENTORY TABLE
-- Insert sample data into the Inventory table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Inventory (StockID, ItemID, QuantityInStock, ReorderLevel)
values
(1, 1, 20, 5),
(2, 2, 15, 4),
(3, 3, 10, 2),
(4, 4, 25, 5),
(5, 5, 30, 10),
(6, 6, 12, 3),
(7, 7, 18, 5),
(8, 8, 22, 6),
(9, 9, 8, 3),
(10, 10, 30, 10);

--------------------------------------------------
-- 10. INSERT INTO PAYMENT TABLE
-- Insert sample data into the Payment table
-- Written by Kaylee Grafton
--------------------------------------------------
insert into Payment (PaymentID, OrderID, PaymentMethod, PaymentStatus)
values
(1, 1, 'Credit Card', 'Completed'),
(2, 2, 'Cash', 'Completed'),
(3, 3, 'Debit Card', 'Pending'),
(4, 4, 'Credit Card', 'Completed'),
(5, 5, 'Cash', 'Completed'),
(6, 6, 'Credit Card', 'Pending'),
(7, 7, 'Debit Card', 'Completed'),
(8, 8, 'Credit Card', 'Completed'),
(9, 9, 'Cash', 'Completed'),
(10, 10, 'Debit Card', 'Completed');

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
