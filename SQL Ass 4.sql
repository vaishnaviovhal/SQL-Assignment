CREATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE students (
    studentId INT PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50),
    birthdate DATE,
    gender CHAR(1),
    class VARCHAR(20),
    point INT
);

CREATE TABLE authors (
    authorId INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50),
    surname VARCHAR(50)
);

CREATE TABLE types (
    typeId INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE books (
    bookId INT PRIMARY KEY,
    name VARCHAR(100),
    pagecount INT,
    point INT,
    authorId INT,
    typeId INT,
    FOREIGN KEY (authorId) REFERENCES authors(authorId),
    FOREIGN KEY (typeId) REFERENCES types(typeId)
);

CREATE TABLE borrows (
    borrowId INT PRIMARY KEY,
    studentId INT,
    bookId INT,
    takenDate DATE,
    broughtDate DATE,
    FOREIGN KEY (studentId) REFERENCES students(studentId),
    FOREIGN KEY (bookId) REFERENCES books(bookId)
);

INSERT INTO students (studentId, name, surname, birthdate, gender, class, point) VALUES 
(1, 'John', 'Doe', '2005-01-15', 'M', '10A', 85), 
(2, 'Jane', 'Smith', '2006-03-22', 'F', '10B', 90), 
(3, 'Alice', 'Johnson', '2005-07-12', 'F', '10A', 88), 
(4, 'Bob', 'Brown', '2006-11-30', 'M', '10C', 76), 
(5, 'Charlie', 'Davis', '2005-05-05', 'M', '10B', 92), 
(6, 'Diana', 'Miller', '2006-06-25', 'F', '10C', 81), 
(7, 'Eve', 'Wilson', '2005-09-18', 'F', '10A', 87), 
(8, 'Frank', 'Moore', '2006-12-02', 'M', '10B', 80), 
(9, 'Grace', 'Taylor', '2005-04-17', 'F', '10C', 83), 
(10, 'Hank', 'Anderson', '2006-10-20', 'M', '10A', 78);

SELECT*FROM Students

INSERT INTO authors (name, surname) VALUES
('F. Scott', 'Fitzgerald'),
('Harper', 'Lee'),
('George', 'Orwell'),
('Jane', 'Austen'),
('J.D.', 'Salinger'),
('J.R.R.', 'Tolkien'),
('Herman', 'Melville'),
('Leo', 'Tolstoy'),
('James', 'Joyce'),
('Homer', '');

SELECT*FROM authors

INSERT INTO types (name) VALUES
('Fiction'),
('Classic'),
('Dystopian'),
('Literature'),
('Fantasy'),
('Adventure'),
('Historical Fiction'),
('Science Fiction'),
('Mythology'),
('Philosophy');

SELECT*FROM types

INSERT INTO books VALUES
(1,'The Great Gatsby',180,95,1,1),
(2,'To Kill a Mockingbird',281,90,2,2),
(3,'1984',328,88,3,3),
(4,'Pride and Prejudice',279,93,4,4),
(5,'The Catcher in the Rye',214,85,5,1),
(6,'The Hobbit',310,91,6,2),
(7,'Moby-Dick',635,80,7,3),
(8,'War and Peace',1225,92,8,4),
(9,'Ulysses',730,89,9,1),
(10,'The Odyssey',541,87,10,2);

SELECT*FROM books

INSERT INTO borrows VALUES
(1,1,3,'2024-01-10','2024-01-20'),
(2,2,5,'2024-01-12','2024-01-22'),
(3,3,7,'2024-01-15','2024-01-25'),
(4,4,2,'2024-01-18','2024-01-28'),
(5,5,1,'2024-01-20','2024-01-30'),
(6,6,4,'2024-01-22','2024-02-01'),
(7,7,6,'2024-01-24','2024-02-03'),
(8,8,8,'2024-01-26','2024-02-05'),
(9,9,10,'2024-01-28','2024-02-07'),
(10,10,9,'2024-01-30','2024-02-09');

SELECT*FROM borrows

SELECT bookId FROM books;

-----List all students-----------------------------
SELECT * FROM students;

-----Name, surname, class--------------------------
SELECT name, surname, class FROM students;

-----Female students-------------------------------
SELECT * FROM students
WHERE gender = 'F';

-----Unique classes--------------------------------
SELECT DISTINCT class FROM students;

-----Female in 10Math------------------------------
SELECT * FROM students
WHERE gender='F' AND class='10Math';

-----Students in 10Math or 10Sci-------------------
SELECT name, surname, class
FROM students
WHERE class='10Math' OR class='10Sci';

-----Name, surname, student number-----------------
SELECT studentId, name, surname FROM students;

-----Combine name & surname------------------------
SELECT CONCAT(name,' ',surname) AS FullName
FROM students;

-----Names starting with A-------------------------
SELECT * FROM students
WHERE name LIKE 'A%';

-----Books between 50–200 pages-------------------
SELECT name, pagecount
FROM books
WHERE pagecount BETWEEN 50 AND 200;

-----Students named Emma, Sophia, Robert------------
SELECT * FROM students
WHERE name IN ('Emma','Sophia','Robert');

------Names starting A, D, K----------------
SELECT * FROM students
WHERE name LIKE 'A%' 
   OR name LIKE 'D%'
   OR name LIKE 'K%';

-----(Males in 9Math) OR (Females in 9His)--------
SELECT name, surname, class, gender
FROM students
WHERE (gender='M' AND class='9Math')
   OR (gender='F' AND class='9His');

-----Males in 10Math or 10Bio------------------
SELECT * FROM students
WHERE gender='M'
AND class IN ('10Math','10Bio');

-----Birth year 1989----------------------------
SELECT * FROM students
WHERE YEAR(birthdate)=1989;

-----Female studentId between 30–50--------------
SELECT * FROM students
WHERE gender='F'
AND studentId BETWEEN 30 AND 50;

-----Order by name----------------------------------
SELECT * FROM students
ORDER BY name;

-----Same names ordered by surname-------------------
SELECT * FROM students
ORDER BY name, surname;

-----10Math by decreasing studentId------------------
SELECT * FROM students
WHERE class='10Math'
ORDER BY studentId DESC;

-----First 10 records--------------------------------
SELECT TOP 10 * FROM students;

-----First 10 name, surname, birthdate----------------
SELECT TOP 10 name, surname, birthdate
FROM students;

-----Book with most pages-----------------------------
SELECT * FROM books
ORDER BY pagecount DESC
LIMIT 1;

-----Youngest student-------------------------------
SELECT * FROM students
ORDER BY birthdate DESC
LIMIT 1;

-----Oldest in 10Math---------------------------------
SELECT * FROM students
WHERE class='10Math'
ORDER BY birthdate
LIMIT 1;

-----Second letter N-------------------------------------
SELECT * FROM books
WHERE name LIKE '_N%';

-----Group by class----------------------------------------
SELECT class, COUNT(*) AS TotalStudents
FROM students
GROUP BY class;

-----Random students---------------------------------------
SELECT * FROM students
ORDER BY RAND();

-----One random student-----------------------------------
SELECT TOP 1 * FROM students
ORDER BY NEWID();

-----Random from 10Math--------------------------------------
SELECT TOP 1 name, surname, studentId
FROM students
WHERE class='10Math'
ORDER BY NEWID();

-----Add Smith Allen-----------------------------------------
INSERT INTO authors(name, surname)
VALUES ('Smith','Allen');

-----Add Biography-------------------------------------------
INSERT INTO types(name)
VALUES ('Biography');

-----Add 3 students------------------------------------------
INSERT INTO students 
VALUES
(11,'Thomas','Nelson','2005-02-02','M','10Math',80),
(12,'Sally','Allen','2006-03-03','F','9Bio',85),
(13,'Linda','Sandra','2004-04-04','F','11His',90);

-----Add random student as author-----------------------------------
INSERT INTO authors (name, surname)
SELECT TOP 1 name, surname
FROM students
ORDER BY NEWID();

-----Students 10–30 as authors----------------------------
INSERT INTO authors(name, surname)
SELECT name, surname
FROM students
WHERE studentId BETWEEN 10 AND 30;

-----Insert & show identity-------------------------------
INSERT INTO authors(name, surname)
VALUES ('Cindy','Brown');

SELECT LAST_INSERT_ID();

-----Change class of student 3-------------------------------
UPDATE students
SET class='10His'
WHERE studentId=3;

-----Transfer 9Math to 10Math----------------------------------
UPDATE students
SET class='10Math'
WHERE class='9Math';

-----Increase all points by 5----------------------------------
UPDATE students
SET point = point + 5;

-----Delete author 25-----------------------------------------------
DELETE FROM authors
WHERE authorId=25;

-----Birthdate NULL-------------------------------------------------
SELECT * FROM students
WHERE birthdate IS NULL;

-----Student name, surname & takenDate---------------------------------
SELECT s.name, s.surname, b.takenDate
FROM students s
JOIN borrows b ON s.studentId = b.studentId;
