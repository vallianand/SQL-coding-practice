/* coding challenge 
1: CREATE Table Scenario:
 You are a data analyst at City Hospital. Management wants to create a new table to store patient details*/
CREATE DATABASE City_Hospital_DB;

USE City_Hospital_DB;
-- Create Books table with PRIMARY KEY
CREATE TABLE Patients_details (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    PatientName VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    AdmissionDate DATE
);
-- Create Orders table with FOREIGN KEY referencing Books(BookID)
/* SQL Question 2: ALTER – Add Column 
Scenario: Later, the hospital decides to store the doctor assigned to each patient.*/

ALTER TABLE Patients_details
ADD COLUMN DoctorAssigned VARCHAR(50);

select * from Patients_details;

/* 
Constraints
SQL Question 1: PRIMARY KEY & FOREIGN KEY Scenario: 
You are creating a database for an online bookstore. Task: 
Define a primary key for Books(BookID) and a foreign key in Orders(BookID) referencing Books*/ 

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    ISBN VARCHAR(30)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    BookID INT,
    OrderDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

/* SQL Question 2: UNIQUE Constraint
Scenario:
 Each book must have a unique ISBN.*/
 
 -- Add UNIQUE to existing table
 ALTER TABLE Books
ADD CONSTRAINT unique_isbn UNIQUE (ISBN);

/*SQL Question 3: DELETE vs TRUNCATE
Scenario:
 The store wants to clear test orders but sometimes preserve structure.*/
 
 -- DELETE with WHERE clause 
 DELETE FROM Orders
WHERE OrderID = 5;

-- TRUNCATE table/ Deletes all rows but keeps table structure.
TRUNCATE TABLE Orders;

-- sample Students 
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Department VARCHAR(50)
);
INSERT INTO Students (StudentID, StudentName, Department)
VALUES 
(1, 'Arun', 'Computer Science'),
(2, 'Priya', 'Commerce'),
(3, 'Rahul', 'Computer Science'),
(4, 'Meena', 'Physics');

-- 4. DISTINCT & WHERE Scenario: In a university database, you want to list unique departments
SELECT DISTINCT Department
FROM Students;

/* 5. IS NULL & NOT NULL 
Scenario: Some students don’t have email addresses recorded. */

-- alter table 
ALTER TABLE Students
ADD COLUMN Email VARCHAR(100);

-- to show is null 
SELECT * FROM Students
WHERE Email IS NULL;

-- to show not null

select * from students 
where email is NOT NULL;

/* 1. SQL Question 3: IN, BETWEEN, NOT BETWEEN
Scenario:
 Filter students enrolled in specific courses or within certain GPA ranges.
Task:
 Write queries using IN, BETWEEN, and NOT BETWEEN operators. */
 
 -- Create a Students table with Course + GPA
 CREATE TABLE Students1 (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    Course VARCHAR(50),
    GPA DECIMAL(3,1)
);

INSERT INTO Students1 (StudentID, StudentName, Course, GPA)
VALUES
(1, 'Arun', 'Computer Science', 8.2),
(2, 'Priya', 'Commerce', 7.5),
(3, 'Rahul', 'Physics', 6.8),
(4, 'Meena', 'Maths', 9.1),
(5, 'Karthik', 'Commerce', 5.9);

ALTER TABLE Students1
ADD COLUMN Course1 VARCHAR(50);

ALTER TABLE Students1
ADD COLUMN GPA1 DECIMAL(3,1);

UPDATE Students1 SET Course1='Computer Science', GPA=8.2 WHERE StudentID=1;
UPDATE Students1 SET Course1='Commerce', GPA=7.5 WHERE StudentID=2;
UPDATE Students1 SET Course1='Physics', GPA=6.8 WHERE StudentID=3;
UPDATE Students1 SET Course1='Maths', GPA=9.1 WHERE StudentID=4;
UPDATE Students1 SET Course1='Commerce', GPA=5.9 WHERE StudentID=5;


-- In operator
SELECT * FROM Students1
WHERE Course IN ('Commerce', 'Physics');

-- Between operator 
SELECT * FROM Students1
WHERE GPA1 BETWEEN 7 AND 9;

-- Not between
SELECT * FROM Students1
WHERE GPA1 NOT BETWEEN 7 AND 9;

SELECT * FROM Students1;

/* SQL Question 4: ORDER BY & LIMIT Scenario: In an e-commerce system, 
show the top 3 highest-priced products*/
-- create product table

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Laptop', 55000),
(2, 'Smartphone', 22000),
(3, 'Headphones', 3000),
(4, 'Smartwatch', 12000),
(5, 'Tablet', 28000);

SELECT * FROM Products
ORDER BY Price DESC
LIMIT 3;

/* Question 5: Aggregate Functions 
Scenario: Management wants statistics of sales data.*/

-- create a sale table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT,
    Amount DECIMAL(10,2)
);

INSERT INTO Sales (SaleID, ProductName, Quantity, Amount)
VALUES
(1, 'Laptop', 1, 55000),
(2, 'Headphones', 3, 3000),
(3, 'Smartphone', 1, 22000),
(4, 'Tablet', 2, 28000),
(5, 'Smartwatch', 1, 12000);

-- Aggregate Function Queries 1. COUNT to Count number of sales 
SELECT COUNT(*) AS TotalSales
FROM Sales;

-- SUM — Total revenue generated
SELECT SUM(Amount) AS TotalRevenue
FROM Sales;

-- AVG — Average sale amount
SELECT AVG(Amount) AS AverageSaleAmount
FROM Sales;

-- MAX — Highest sale amount
SELECT MAX(Amount) AS HighestSale
FROM Sales;

-- MIN — Lowest sale amount
SELECT MIN(Amount) AS LowestSale
FROM Sales;
/*6: GROUP BY & HAVING Scenario: Find departments with more than 10 employees.*/

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50)
);

INSERT INTO Employees (EmployeeID, EmployeeName, Department)
VALUES
(1, 'Arun', 'HR'),
(2, 'Meena', 'IT'),
(3, 'Karthik', 'IT'),
(4, 'Priya', 'Finance'),
(5, 'Rahul', 'IT'),
(6, 'Swathi', 'HR'),
(7, 'Dinesh', 'IT'),
(8, 'Keerthi', 'IT'),
(9, 'Ravi', 'Finance'),
(10, 'Anu', 'IT'),
(11, 'Bala', 'IT'),
(12, 'Sathya', 'IT');

SELECT Department, COUNT(*) AS TotalEmployees
FROM Employees
GROUP BY Department
HAVING COUNT(*) > 10;

/*Question 7 INNER JOIN Scenario: Show students with their enrolled course names.*/

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

INSERT INTO Courses (CourseID, CourseName)
VALUES
(101, 'Computer Science'),
(102, 'Commerce'),
(103, 'Physics'),
(104, 'Maths');

-- alter table
ALTER TABLE Students
ADD COLUMN CourseID INT;

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

INSERT INTO Courses (CourseID, CourseName)
VALUES
(101, 'Computer Science'),
(102, 'Commerce'),
(103, 'Physics'),
(104, 'Maths');

UPDATE Students SET CourseID = 101 WHERE StudentID = 1;
UPDATE Students SET CourseID = 102 WHERE StudentID = 2;
UPDATE Students SET CourseID = 103 WHERE StudentID = 3;
UPDATE Students SET CourseID = 104 WHERE StudentID = 4;
UPDATE Students SET CourseID = 102 WHERE StudentID = 5;


SELECT 
    Students.StudentID,
    Students.StudentName,
    Courses.CourseName
FROM Students
INNER JOIN Courses
ON Students.CourseID = Courses.CourseID;

/* SQL Question 2: LEFT & RIGHT JOIN Scenario: 
List all students and their courses, including those without matches.*/
-- enrollement table 
CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseName VARCHAR(100)
);
INSERT INTO Enrollments (EnrollmentID, StudentID, CourseName)
VALUES
(1, 1, 'Computer Science'),
(2, 2, 'Commerce'),
(3, 3, 'Physics');


SELECT 
    Students.StudentID,
    Students.StudentName,
    Enrollments.CourseName
FROM Students
LEFT JOIN Enrollments
ON Students.StudentID = Enrollments.StudentID;

/* Question 3: UNION vs UNION ALL
Scenario:
 Combine lists of current and past employees.*/
 -- current employee
CREATE TABLE CurrentEmployees (
    EmpID INT PRIMARY KEY,
    EmployeeName VARCHAR(100)
);

INSERT INTO CurrentEmployees VALUES
(1, 'Arun'),
(2, 'Priya'),
(3, 'Meena');
-- past employee
CREATE TABLE PastEmployees (
    EmpID INT PRIMARY KEY,
    EmployeeName VARCHAR(100)
);

INSERT INTO PastEmployees VALUES
(1, 'Priya'),
(2, 'Rahul'),
(3, 'Karthik');

-- UNIO remove duplicate
SELECT EmployeeName
FROM CurrentEmployees

UNION

SELECT EmployeeName
FROM PastEmployees;

-- UNION ALL — Keeps duplicates
SELECT EmployeeName
FROM CurrentEmployees

UNION ALL

SELECT EmployeeName
FROM PastEmployees;

/* Question 1: String Functions 
Scenario: Clean up employee names for reporting.*/
-- UPPER – Convert name to uppercase
SELECT UPPER(EmployeeName) AS UpperName
FROM Employees;

-- LOWER – Convert name to lowercase
SELECT LOWER(EmployeeName) AS LowerName
FROM Employees;

-- SUBSTRING – Extract part of the name
SELECT SUBSTRING(EmployeeName, 1, 3) AS FirstThreeLetters
FROM Employees;

-- CONCAT – Combine first name and last name
SELECT CONCAT('Employee: ', EmployeeName) AS FormattedName
FROM Employees;

/*Question 2: Date Functions 
Scenario: Calculate employee tenure in years*/
-- alter
ALTER TABLE Employees
ADD COLUMN JoinDate DATE;
UPDATE Employees SET JoinDate = '2020-06-12' WHERE EmployeeID = 1;
UPDATE Employees SET JoinDate = '2019-03-20' WHERE EmployeeID = 2;
UPDATE Employees SET JoinDate = '2022-11-01' WHERE EmployeeID = 3;
UPDATE Employees SET JoinDate = '2021-01-15' WHERE EmployeeID = 4;
UPDATE Employees SET JoinDate = '2018-09-10' WHERE EmployeeID = 5;


-- Use DATEDIFF() to calculate tenure in days
SELECT 
    EmployeeName,
    DATEDIFF(NOW(), JoinDate) AS TenureInDays
FROM Employees;

-- Tenure in years (most commonly asked in interviews)
SELECT 
    EmployeeName,
    ROUND(DATEDIFF(NOW(), JoinDate) / 365, 1) AS TenureInYears
FROM Employees;

SELECT
    EmployeeName,
    JoinDate,
    NOW() AS Today,
    DATEDIFF(NOW(), JoinDate) AS TotalDaysWorked,
    ROUND(DATEDIFF(NOW(), JoinDate) / 365, 2) AS TenureYears
FROM Employees;

/*Question 3: User-defined Function 
Scenario: Create a reusable function to return full name of a student.*/

DROP FUNCTION IF EXISTS GetFullName;

-- Create the UDF (Function)
DELIMITER $$

CREATE FUNCTION GetFullName(Name VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN Name;
END $$

DELIMITER ;

SELECT 
    StudentID,
    GetFullName(StudentName) AS FullName
FROM Students;

SHOW FUNCTION STATUS WHERE Db = 'city_hospital_db';

/* 1: Stored Procedure 
Scenario: HR wants a quick way to fetch employee details by ID. */
 
 DELIMITER $$

CREATE PROCEDURE GetEmployeeByID(IN EmpID INT)
BEGIN
    SELECT *
    FROM Employees
    WHERE EmployeeID = EmpID;
END $$

DELIMITER ;

CALL GetEmployeeByID(3);

/*  2: Simple View 
Scenario:
 Management wants a view for employee name and department.*/
 
  CREATE VIEW EmployeeSummary AS
SELECT 
    EmployeeName,
    Department
FROM Employees;

SELECT * FROM EmployeeSummary; 
/* Question 3: Complex View
Scenario:
 Create a view joining Employees, Departments, and Salaries.*/
 
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Operations');

ALTER TABLE Employees
ADD COLUMN DepartmentID INT;

UPDATE Employees SET DepartmentID = 1 WHERE EmployeeID = 1;
UPDATE Employees SET DepartmentID = 2 WHERE EmployeeID = 2;
UPDATE Employees SET DepartmentID = 2 WHERE EmployeeID = 3;
UPDATE Employees SET DepartmentID = 3 WHERE EmployeeID = 4;
UPDATE Employees SET DepartmentID = 4 WHERE EmployeeID = 5;

CREATE TABLE Salaries (
    EmployeeID INT PRIMARY KEY,
    SalaryAmount DECIMAL(10,2)
);

INSERT INTO Salaries (EmployeeID, SalaryAmount)
VALUES
(1, 45000),
(2, 55000),
(3, 60000),
(4, 50000),
(5, 48000);

CREATE VIEW EmployeeFullInfo AS
SELECT 
    e.EmployeeID,
    e.EmployeeName,
    d.DepartmentName,
    s.SalaryAmount
FROM Employees e
INNER JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
INNER JOIN Salaries s
    ON e.EmployeeID = s.EmployeeID;
    
    SELECT * FROM EmployeeFullInfo;
    
    /*Triggers & Transactions
SQL Question 1: Trigger
Scenario:
 Log every deletion in the Orders table.*/
 
 CREATE TABLE Order_History (
    OrderID INT,
    BookID INT,
    OrderDate DATE,
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER LogOrderDeletion
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History (OrderID, BookID, OrderDate)
    VALUES (OLD.OrderID, OLD.BookID, OLD.OrderDate);
END $$

DELIMITER ;

DELETE FROM Orders WHERE OrderID = 3;
SELECT * FROM Order_History;

/*SQL Question 2: DCL Commands
Scenario:
 Grant reporting access to junior analysts.*/
 
 GRANT SELECT ON city_hospital_db.* TO 'junior_analyst'@'localhost';
 
REVOKE SELECT ON city_hospital_db.* FROM 'junior_analyst'@'localhost';

FLUSH PRIVILEGES;

/*SQL Question 3: TCL Commands
Scenario:
 During a bank transfer, ensure atomicity.*/

CREATE TABLE Accounts (
    AccountNo VARCHAR(10) PRIMARY KEY,
    AccountHolder VARCHAR(100),
    Balance DECIMAL(10,2)
);

INSERT INTO Accounts (AccountNo, AccountHolder, Balance)
VALUES
('A001', 'Arun Kumar', 20000),
('B001', 'Priya Sharma', 15000);

 
 START TRANSACTION;

-- Step 1: Deduct money from Sender
UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountNo = 'A001';

-- Savepoint after deduction
SAVEPOINT AfterDeduction;

-- Step 2: Add money to Receiver
UPDATE Accounts
SET Balance = Balance + 5000
WHERE AccountNo = 'B001';

-- If everything is correct, commit the transaction
COMMIT;

/* SQL Question 4: Subquery
Scenario:
Find employees who earn more than the average salary.*/

SELECT
    e.EmployeeID,
    e.EmployeeName,
    s.SalaryAmount
FROM Employees e
JOIN Salaries s 
    ON e.EmployeeID = s.EmployeeID
WHERE s.SalaryAmount > (
    SELECT AVG(SalaryAmount)
    FROM Salaries
);

























































