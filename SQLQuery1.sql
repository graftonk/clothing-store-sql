-- Create the ClothingStore Database
Use master;
Go
drop database ClothingStore;
Go
create database ClothingStore;
go

/*
   Create the PERSON table
   Written by Kaylee Grafton
*/
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

/*
   Create the EMPLOYEE table
   Written by Kaylee Grafton
*/
create table Employee (
	PersonID int Not Null,
	DateHired date Not Null,
	DateTerminated date,
	SSN char(10) Not Null Unique,
	DOB date Not Null,
	Position char(15) Not Null,
	PayRate decimal(10,2) Not Null,
-- table constraints
	constraint employee_personid_pk primary key(PersonID),
	constraint employee_personid_fk foreign key(PersonID) references Person(PersonID)
		on update cascade -- auto updates personid if it is changed elsewhere
	        on delete no action, -- prevents deleting employees if they have data in other tables
	constraint employee_ssn_uk unique(SSN)
);

/*
   Create the CUSTOMER table
   Written by Kaylee Grafton
*/
create table Customer (
	PersonID int Not Null,
	CustomerSince date Not Null,
-- table constraints
	constraint customer_personid_pk primary key(PersonID),
	constraint customer_personid_fk foreign key(PersonID) references Person(PersonID)
		on update cascade -- auto updates personid if it is changed elsewhere
	        on delete no action -- prevents deleting customers if they have data in other tables
);

-- ORDER TABLE

-- ITEM TABLE

-- ORDER_ITEM TABLE

-- CATEGORY TABLE

-- INVENTORY TABLE

-- SUPPLIER TABLE

-- PAYMENT TABLE

-- INSERT INTO STATEMENTS
/*
   Insert sample data into the PERSON table
   Written by Kaylee Grafton
*/
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
