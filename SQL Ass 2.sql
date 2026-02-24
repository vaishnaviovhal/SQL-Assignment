CREATE DATABASE EmployeeDB;
USE EmployeeDB;

CREATE TABLE EmployeeDetails (
    EmpId INT PRIMARY KEY,
    FullName VARCHAR(100),
    ManagerId INT,
    DateOfJoining DATE,
    City VARCHAR(100)
);

CREATE TABLE EmployeeSalary (
    EmpId INT,
    Project VARCHAR(50),
    Salary DECIMAL(10,2),
    Variable DECIMAL(10,2),
    FOREIGN KEY (EmpId) REFERENCES EmployeeDetails(EmpId)
);

INSERT INTO EmployeeDetails (EmpId, FullName, ManagerId, 
DateOfJoining, City) VALUES 
(101, 'Alice Johnson', 321, '2022-05-15', 'New York'), 
(102, 'Bob Smith', 876, '2020-03-12', 'Los Angeles'), 
(103, 'Charlie Brown', 986, '2021-08-23', 'Chicago'), 
(104, 'David Williams', 876, '2019-11-05', 'Houston'), 
(105, 'Eve Davis', 321, '2023-01-07', 'Phoenix'), 
(106, 'Frank Miller', 986, '2018-12-19', 'Philadelphia'), 
(107, 'Grace Wilson', 876, '2022-03-28', 'San Antonio'), 
(108, 'Hank Moore', 321, '2021-09-14', 'San Diego'), 
(109, 'Ivy Taylor', 986, '2020-02-11', 'Dallas'), 
(110, 'Jack Anderson', 876, '2022-11-30', 'San Jose'), 
(111, 'Karen Thomas', 321, '2021-07-16', 'Austin'), 
(112, 'Liam Jackson', 986, '2023-04-21', 'Fort Worth'), 
(113, 'Mia White', 876, '2019-06-03', 'Columbus'), 
(114, 'Noah Harris', 321, '2020-12-10', 'Charlotte'), 
(115, 'Olivia Martin', 986, '2021-10-25', 'San Francisco'), 
(116, 'Paul Garcia', 876, '2023-07-18', 'Indianapolis'), 
(117, 'Quinn Martinez', 321, '2022-09-07', 'Seattle'), 
(118, 'Rachel Rodriguez', 986, '2020-01-15', 'Denver'), 
(119, 'Steve Clark', 876, '2021-03-19', 'Washington'), 
(120, 'Tina Lewis', 321, '2019-08-31', 'Boston');

SELECT * FROM EmployeeDetails;

INSERT INTO EmployeeSalary (EmpId, Project, Salary, Variable) 
VALUES 
(101, 'P1', 7500, 500), 
(102, 'P2', 9200, 700), 
(103, 'P1', 6700, 600), 
(104, 'P3', 8300, 900), 
(105, 'P2', 7800, 800), 
(106, 'P3', 9100, 1000), 
(107, 'P1', 6200, 400), 
(108, 'P2', 8800, 750), 
(109, 'P3', 9500, 1100), 
(110, 'P1', 7200, 650), 
(111, 'P2', 8700, 850), 
(112, 'P3', 9300, 1200), 
(113, 'P1', 7900, 550), 
(114, 'P2', 6800, 450), 
(115, 'P3', 8400, 900), 
(116, 'P1', 7600, 500), 
(117, 'P2', 8900, 1000), 
(118, 'P3', 9200, 1100), 
(119, 'P1', 8100, 600), 
(120, 'P2', 8300, 750);

SELECT * FROM EmployeeSalary;

-----Records present in one table but not in another-------------------------------------------
SELECT ed.*
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId
WHERE es.EmpId IS NULL;

-----Employees not working on any project-----------------------------------------------------------
SELECT ed.FullName
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId
WHERE es.Project IS NULL;

-----Joined in 2020-------------------------------------------------------------------------------------
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

-----Employees who have salary record----------------------------------------------------------------
SELECT ed.*
FROM EmployeeDetails ed
INNER JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;

-----Project-wise employee count------------------------------------------------------------------------
SELECT Project, COUNT(*) AS TotalEmployees
FROM EmployeeSalary
GROUP BY Project;

-----Show employees even if salary not present--------------------------------------------------------------
SELECT ed.FullName, es.Salary
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;

-----Employees who are also managers---------------------------------------------------------------------------
SELECT *
FROM EmployeeDetails
WHERE EmpId IN (SELECT DISTINCT ManagerId FROM EmployeeDetails);

-----Duplicate records--------------------------------------------------------------------------------------------
SELECT EmpId, FullName, COUNT(*)
FROM EmployeeDetails
GROUP BY EmpId, FullName
HAVING COUNT(*) > 1;

-----Fetch odd rows-----------------------------------------------------------------------------------------------
SELECT *
FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY EmpId) AS RowNum
    FROM EmployeeDetails
) AS temp
WHERE RowNum % 2 = 1;

-----3rd highest salary (without TOP/LIMIT)---------------------------------------------------------------
SELECT DISTINCT Salary
FROM EmployeeSalary es1
WHERE 3 = (
    SELECT COUNT(DISTINCT Salary)
    FROM EmployeeSalary es2
    WHERE es2.Salary >= es1.Salary
);
----------------------------------------------------------------------------------------------------------------------------------------
-----Employees under Manager 986-------------------------------------------------------------------------------
SELECT EmpId, FullName
FROM EmployeeDetails
WHERE ManagerId = 986;

-----Different Projects-------------------------------------------------------------------------------------
SELECT DISTINCT Project
FROM EmployeeSalary;

-----Count employees in P1--------------------------------------------------------------------------------
SELECT COUNT(*)
FROM EmployeeSalary
WHERE Project = 'P1';

-----Max, Min, Avg salary----------------------------------------------------------------------------------
SELECT 
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary,
    AVG(Salary) AS AvgSalary
FROM EmployeeSalary;

-----Salary between 9000 and 15000--------------------------------------------------------------------------
SELECT EmpId
FROM EmployeeSalary
WHERE Salary BETWEEN 9000 AND 15000;

-----Toronto + Manager 321-------------------------------------------------------------------------------------
SELECT *
FROM EmployeeDetails
WHERE City = 'Toronto'
AND ManagerId = 321;

-----California OR Manager 321-----------------------------------------------------------------------------------
SELECT *
FROM EmployeeDetails
WHERE City = 'California'
OR ManagerId = 321;

-----Projects other than P1----------------------------------------------------------------------------------
SELECT *
FROM EmployeeSalary
WHERE Project <> 'P1';

-----Total salary (Salary + Variable)---------------------------------------------------------------------------
SELECT EmpId, (Salary + Variable) AS TotalSalary
FROM EmployeeSalary;

-----Name pattern (__hn%)---------------------------------------------------------------------------------------
SELECT *
FROM EmployeeDetails
WHERE FullName LIKE '__hn%';

-----------------------------------------------------------------------------------------------------------------------------------------
-----EmpIds present in either table----------------------------------------------------
SELECT EmpId FROM EmployeeDetails
UNION
SELECT EmpId FROM EmployeeSalary;

-----Common records-----------------------------------------------------------------------
SELECT ed.*
FROM EmployeeDetails ed
INNER JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;

-----Present in one but not another-------------------------------------------------------------
SELECT ed.*
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId
WHERE es.EmpId IS NULL;

-----EmpIds present in both tables--------------------------------------------------------------
SELECT ed.EmpId
FROM EmployeeDetails ed
INNER JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;

-----Present in Details but not Salary--------------------------------------------------------------
SELECT ed.EmpId
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId
WHERE es.EmpId IS NULL;

-----Replace space in name-------------------------------------------------------------------------
SELECT REPLACE(FullName, ' ', '_')
FROM EmployeeDetails;

-----Display EmpId & ManagerId together----------------------------------------------------------------
SELECT CONCAT(EmpId, '-', ManagerId)
FROM EmployeeDetails;

-----Uppercase name, lowercase city--------------------------------------------------------------------
SELECT UPPER(FullName), LOWER(City)
FROM EmployeeDetails;

---------------------------------------------------------------------------------------------------------------------------------
-----Remove leading & trailing spaces------------------------------------------------------------
UPDATE EmployeeDetails
SET FullName = TRIM(FullName);

-----Employees not working on project---------------------------------------------------------------
SELECT ed.*
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId
WHERE es.Project IS NULL;

-----Salary between 5000 and 10000----------------------------------------------------------------------
SELECT ed.FullName
FROM EmployeeDetails ed
JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId
WHERE Salary BETWEEN 5000 AND 10000;

-----Joined in 2020--------------------------------------------------------------------------------------
SELECT *
FROM EmployeeDetails
WHERE YEAR(DateOfJoining) = 2020;

-----Employees with salary record-------------------------------------------------------------------------
SELECT ed.*
FROM EmployeeDetails ed
INNER JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;

---------Project-wise count descending---------------------------------------------------------------------
SELECT Project, COUNT(*) AS TotalEmployees
FROM EmployeeSalary
GROUP BY Project
ORDER BY TotalEmployees DESC;

-----Show employee details even if salary missing-----------------------------------------------------------
SELECT ed.*, es.Salary
FROM EmployeeDetails ed
LEFT JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;

-----Join 3 tables--------------------------------------------------------------------------------------------
SELECT ed.EmpId, ed.FullName, es.Project, es.Salary
FROM EmployeeDetails ed
JOIN EmployeeSalary es
ON ed.EmpId = es.EmpId;