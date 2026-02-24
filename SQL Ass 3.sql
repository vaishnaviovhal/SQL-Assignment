CREATE DATABASE UniversityDB;

USE UniversityDB;

CREATE TABLE College_Table (
    College_ID INT PRIMARY KEY,
    College_Name VARCHAR(50),
    College_Area VARCHAR(50)
);

CREATE TABLE Department_Table (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(50),
    Dept_Facility VARCHAR(50),
    College_ID INT,
    FOREIGN KEY (College_ID) REFERENCES College_Table(College_ID)
);

CREATE TABLE Professor_Table (
    Professor_ID INT PRIMARY KEY,
    Professor_Name VARCHAR(50),
    Professor_Subject VARCHAR(50)
);

CREATE TABLE Student_Table (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Student_Stream VARCHAR(50),
    Professor_ID INT,
    FOREIGN KEY (Professor_ID) REFERENCES Professor_Table(Professor_ID)
);

INSERT INTO College_Table VALUES
(1,'ABC College','Pune'),
(2,'City College','Mumbai'),
(3,'National College','Delhi'),
(4,'Modern College','Chennai'),
(5,'Royal College','Bangalore'),
(6,'Central College','Nagpur'),
(7,'Green College','Hyderabad'),
(8,'Global College','Kolkata'),
(9,'Sunrise College','Jaipur'),
(10,'Silver Oak College','Goa');

SELECT*FROM College_Table

INSERT INTO Department_Table VALUES
(1,'Computer','Lab',1),
(2,'Mechanical','Workshop',2),
(3,'Civil','Site',3),
(4,'IT','Lab',4),
(5,'Electrical','Lab',5),
(6,'MBA','Seminar Hall',6),
(7,'Pharmacy','Lab',7),
(8,'Architecture','Design Lab',8),
(9,'Law','Library',9),
(10,'Arts','Auditorium',10);

SELECT*FROM Department_Table 

INSERT INTO Professor_Table VALUES
(1,'Ramesh','DBMS'),
(2,'Suresh','Java'),
(3,'Anita','Maths'),
(4,'Kiran','Physics'),
(5,'Meena','English'),
(6,'Arjun','C++'),
(7,'Priya','AI'),
(8,'Rahul','Networks'),
(9,'Sneha','Python'),
(10,'Amit','OS');

SELECT*FROM Professor_Table

INSERT INTO Student_Table VALUES
(1,'Aman','IT',1),
(2,'Ajay','CS',2),
(3,'Riya','Civil',3),
(4,'Anjali','Mechanical',4),
(5,'Akash','IT',5),
(6,'Neha','CS',6),
(7,'Rohit','Electrical',7),
(8,'Aryan','MBA',8),
(9,'Simran','Law',9),
(10,'Alok','Arts',10);

SELECT*FROM Student_Table

-----College_ID and College_Name----------------------------------------------------
SELECT College_ID, College_Name FROM College_Table;

-----Top 5 rows from Student table-----------------------------------------------------
SELECT * FROM Student_Table
LIMIT 5;

-----Professor name whose ID = 5-----------------------------------------------------------
SELECT Professor_Name 
FROM Professor_Table
WHERE Professor_ID = 5;

-----Convert Professor name to Upper Case-------------------------------------------------------
SELECT UPPER(Professor_Name) 
FROM Professor_Table;

-----Students whose name starts with 'A'-------------------------------------------------------------
SELECT Student_Name 
FROM Student_Table
WHERE Student_Name LIKE 'A%';

-----Colleges whose name ends with 'a'--------------------------------------------------------------------
SELECT College_Name 
FROM College_Table
WHERE College_Name LIKE '%a';

-----Add Salary Column in Professor_Table---------------------------------------------------------------------
ALTER TABLE Professor_Table
ADD Salary INT;

-----Add Contact Column in Student_Table-----------------------------------------------------------------------
ALTER TABLE Student_Table
ADD Contact VARCHAR(15);

-----Find Total Salary of Professor------------------------------------------------------------------------------
SELECT SUM(Salary) AS Total_Salary
FROM Professor_Table;

-----Apply INNER JOIN on all 4 tables-------------------------------------------------------------------------------
SELECT *
FROM College_Table C
INNER JOIN Department_Table D 
ON C.College_ID = D.College_ID
INNER JOIN Student_Table S 
ON S.Professor_ID = S.Professor_ID
INNER JOIN Professor_Table P 
ON S.Professor_ID = P.Professor_ID;

-----Show some NULL values---------------------------------------------------
UPDATE Department_Table
SET Dept_Facility = NULL
WHERE Dept_ID = 3;

SELECT * FROM Department_Table
WHERE Dept_Facility IS NULL;

-----Create View for College name starts with 'C'--------------------------------------------------
CREATE VIEW College_View AS
SELECT * FROM College_Table
WHERE College_Name LIKE 'C%';

SELECT * FROM College_View;


