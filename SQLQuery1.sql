-- Create the ClothingStore Database
Use master;
Go
Drop database ClothingStore;
Go
Create database ClothingStore;

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
	Phone char(10) Not Null default 'No Phone',
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
